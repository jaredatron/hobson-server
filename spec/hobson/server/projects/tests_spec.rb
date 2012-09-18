require 'spec_helper'

describe '/projects/tests' do

  include ServerSupport

  let!(:project){ Factory.create(Hobson::Project) }


  # index
  describe "get /projects/:origin/:tests" do

    def get!
      get "#{project_path(project)}/tests"
      response.should be_ok
      response.headers["Content-Type"].should == 'application/json;charset=utf-8'
      response_should_equal({"tests" => tests})
    end

    context "when there are no test_runs" do
      let(:tests){ [] }

      it "should return an empty set" do
        get!
      end
    end

    context "when there are 2 test_runs" do
      let!(:tests) do
        10.times.map{ Factory.create(Hobson::Project::Test, project: project) }
      end

      it "should return those 2 test_runs" do
        get!
      end
    end

  end

end
