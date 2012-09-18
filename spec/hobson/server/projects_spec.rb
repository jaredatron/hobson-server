require 'spec_helper'

describe '/projects' do

  include ServerSupport

  # index
  describe "get /projects" do

    def get!
      get '/projects'
      response.should be_ok
      JSON.parse(response.body).should == {"projects" => projects}.as_json
    end

    context "when there are no projects" do
      let(:projects){ [] }

      it "should return an empty set" do
        get!
      end
    end

    context "when there are 2 projects" do
      let!(:projects) do
        [Factory.create(Hobson::Project), Factory.create(Hobson::Project)]
      end
      it "should return those 2 projects" do
        get!
      end
    end

  end

  # read
  describe "get /projects/:origin" do
    let(:project){ Factory.create(Hobson::Project) }
    it "should work" do
      get project_path(project)
      response.should be_ok
      response_data.should == j(project: project)
    end
  end

end
