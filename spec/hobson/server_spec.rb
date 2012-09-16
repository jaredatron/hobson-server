require 'spec_helper'

describe Hobson::Server do

  include Rack::Test::Methods

  def app
    Hobson::Server
  end

  alias_method :response, :last_response


  def encode_origin origin
    origin.gsub('/', '%2F')
  end

  # create
  describe "post /projects" do
    context "when given a valid post body" do
      it "should work" do
        Hobson::Project.all.size.should == 0
        post '/projects', {"project" => {"origin" => "fakeorigin"}}
        response.should be_ok
        response.body.should == ''
        Hobson::Project.all.size.should == 1
        Hobson::Project[1].origin.should == "fakeorigin"
      end
    end

  end

  # index
  describe "get /projects" do

    def get!
      get '/projects'
      response.should be_ok
      response.headers["Content-Type"].should == 'application/json;charset=utf-8'
    end

    context "when there are no projects" do
      let(:projects){ [] }

      it "should return an empty set" do
        get!
        JSON.parse(response.body).should == {"projects" => []}
      end
    end

    context "when there are 2 projects" do
      let!(:projects) do
        [
          Hobson::Project.create(origin: 'git://github.com/soveran/ohm.git'),
          Hobson::Project.create(origin: 'git://github.com/rails/rails.git'),
        ]
      end
      it "should return those 2 projects" do
        get!
        JSON.parse(response.body).should == {
          "projects" => [
            {"id" => "1", "origin" => 'git://github.com/soveran/ohm.git'},
            {"id" => "2", "origin" => 'git://github.com/rails/rails.git'},
          ]
        }
      end
    end

  end

  # read
  describe "get /projects/:origin" do
    it "should work" do
      project = Hobson::Project.create(origin: 'git://github.com/rails/rails.git')
      get "/projects/#{encode_origin(project.origin)}"
      response.should be_ok
      JSON.parse(response.body).should == {
        "id" => "1",
        "origin" => 'git://github.com/rails/rails.git',
      }
    end
  end

end
