require 'spec_helper'

describe '/test_runs' do

  include ServerSupport

  freeze_time!

  # index
  describe "get /test_runs" do

    def get!
      get "/test_runs"
      response.should be_ok
    end

    context "when there are no test_runs" do
      let(:test_runs){ [] }

      it "should return an empty set" do
        get!
        JSON.parse(response.body).should == j({"test_runs" => []})
      end
    end

    context "when there are 2 test_runs" do
      let!(:test_runs) do
        [Factory.create(Hobson::TestRun), Factory.create(Hobson::TestRun)]
      end
      it "should return those 2 test_runs" do
        get!
        # debugger;1
        JSON.parse(response.body).should == j({"test_runs" => test_runs})
      end
    end
  end

  # create
  describe "post /test_runs" do
    context "when given a valid post body" do
      it "should work" do
        Hobson::TestRun.all.size.should == 0
        post "/test_runs", {
          "test_run" => {
            'project_origin' => 'fake origin',
            'sha' => 'abcd',
            'requestor' => 'your mom',
          }
        }
        response.should be_ok
        JSON.parse(response.body).should == j({
          "test_run" => {
            'id'             => "1",
            'path'           => "/test_runs/1",
            'project_origin' => 'fake origin',
            'sha'            => 'abcd',
            'requestor'      => 'your mom',
            'created_at'     => now,
            'tests'          => [],
            'jobs'           => [],
          }
        })
        Hobson::TestRun.all.size.should == 1
        test_run = Hobson::TestRun[1]
        test_run.project_origin.should == 'fake origin'
        test_run.sha.should == "abcd"
        test_run.requestor.should == "your mom"
      end
    end

  end

  # read
  describe "get /test_runs/:id" do
    it "should work" do
      test_run = Factory.create(Hobson::TestRun)
      get "/test_runs/1"
      response.should be_ok
      response_data.should == j(test_run: test_run)
    end
  end

  # delete
  describe "delete /test_runs/:id" do
    it "should work" do
      test_run = Factory.create(Hobson::TestRun)
      get "/test_runs/1"
      response.should be_ok
      delete "/test_runs/1"

      response.status.should == 406
      Hobson::TestRun.all.size.should == 0

      delete "/test_runs/1"
      response.should_not be_ok
    end
  end

end
