require 'spec_helper'

describe '/test_runs' do

  include ServerSupport

  # index
  describe "get /test_runs" do

    def get!
      get "/test_runs"
      response.should be_ok
      response.headers["Content-Type"].should == 'application/json;charset=utf-8'
    end

    context "when there are no test_runs" do
      let(:test_runs){ [] }

      it "should return an empty set" do
        get!
        JSON.parse(response.body).should == {"test_runs" => []}
      end
    end

    context "when there are 2 test_runs" do
      let!(:test_runs) do
        [Factory.create(Hobson::Project::TestRun), Factory.create(Hobson::Project::TestRun)]
      end
      it "should return those 2 test_runs" do
        get!
        # debugger;1
        JSON.parse(response.body).should == {"test_runs" => test_runs}.as_json
      end
    end

  end
end
