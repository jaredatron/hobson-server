require 'spec_helper'

describe Hobson::Server do

  include Rack::Test::Methods

  def app
    Hobson::Server
  end

  alias_method :response, :last_response




  describe "get /projects" do

    def get!
      get '/projects'
      response.headers["Content-Type"].should == 'application/json;charset=utf-8'
      response.body.should == {"projects" => projects.map(&:attributes)}.to_json
    end

    context "when there are no projects" do
      let(:projects){ [] }

      it "should return an empty set" do
        get!
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
      end
    end

  end

end
