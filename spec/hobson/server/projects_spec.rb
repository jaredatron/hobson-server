require 'spec_helper'

describe '/projects' do

  include ServerSupport

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
        JSON.parse(response.body).should == {"projects" => projects}.as_json
      end
    end

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

  # read
  describe "get /projects/:origin" do
    it "should work" do
      project = Hobson::Project.create(origin: 'git://github.com/rails/rails.git')
      get project_path(project)
      response.should be_ok
      JSON.parse(response.body).should == {
        "id" => "1",
        "origin" => 'git://github.com/rails/rails.git',
      }
    end
  end

  # delete
  describe "delete /projects/:origin" do
    it "should work" do
      project = Hobson::Project.create(origin: 'git://github.com/rails/rails.git')
      get project_path(project)
      response.should be_ok

      delete project_path(project)
      response.should be_ok
      Hobson::Project.all.size.should == 0

      delete project_path(project)
      response.should_not be_ok
    end
  end

end
