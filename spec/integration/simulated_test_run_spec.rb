require 'spec_helper'

describe Hobson::Server do

  include ServerSupport

  let(:origin){ 'git@github.com:deadlyicon/hobson-server.git' }

  def uri
    "/projects/#{encode_origin(origin)}"
  end

  let!(:now){ Time.at(1347801214) }

  before do
    Time.should_receive(:now).any_number_of_times.and_return{ now }
  end

  it "should be able to support a full test run" do

    # create test run (and project)
    post "/test_runs", {
      "test_run" => {
        "project" => "git@github.com:deadlyicon/hobson-server.git",
        "sha" => "12321321321321",
        "requestor" => "Jared Grippe",
      }
    }

    response_data.should == j({
      "test_run" => {
        "id"         => "1",
        "project"    => "git@github.com:deadlyicon/hobson-server.git",
        "sha"        => "12321321321321",
        "requestor"  => "Jared Grippe",
        "created_at" => now,
        "tests"      => [],
        "jobs"       => [],
      }
    })

    get "/test_runs/1"

    response.status.should == 200
    response_data.should == j({
      "test_run" => {
        "id"         => "1",
        "project"    => "git@github.com:deadlyicon/hobson-server.git",
        "sha"        => "12321321321321",
        "requestor"  => "Jared Grippe",
        "created_at" => now,
        "tests"      => [],
        "jobs"       => [],
      }
    })


    # build test run
    put "/test_runs/1", {
      "test_run" => {
        "tests" => [
          { "job_index" => "0", "uuid" => "spec:models/user_spec.rb" },
          { "job_index" => "0", "uuid" => "spec:models/post_spec.rb" },
          { "job_index" => "1", "uuid" => "scenario:I should be able to see my first post" },
          { "job_index" => "1", "uuid" => "scenario:I should be able to delete my first post" },
        ]
      }
    }

    # response.status.should == 200
    response.body.should == ''

    # execute test run

    get "/test_runs/1"

    response.status.should == 200
    response_data.should == j({
      "test_run" => {
        "id"         => "1",
        "project"    => "git@github.com:deadlyicon/hobson-server.git",
        "sha"        => "12321321321321",
        "requestor"  => "Jared Grippe",
        "created_at" => now,
        "tests" => [
          {
            "uuid"         => "spec:models/user_spec.rb",
            "job_index"    => "0",
            "started_at"   => nil,
            "completed_at" => nil,
            "result"       => nil,
            "tries"        => nil,
          },{
            "uuid"         => "spec:models/post_spec.rb",
            "job_index"    => "0",
            "started_at"   => nil,
            "completed_at" => nil,
            "result"       => nil,
            "tries"        => nil,
          },{
            "uuid"         => "scenario:I should be able to see my first post",
            "job_index"    => "1",
            "started_at"   => nil,
            "completed_at" => nil,
            "result"       => nil,
            "tries"        => nil,
          },{
            "uuid"         => "scenario:I should be able to delete my first post",
            "job_index"    => "1",
            "started_at"   => nil,
            "completed_at" => nil,
            "result"       => nil,
            "tries"        => nil,
          },
        ],
        "jobs" => [
          {"index"=>"0"},
          {"index"=>"1"},
        ]
      }
    })

    # started a test
    put "/test_runs/1", {
      "test_run" => {
        "tests" => [
          {
            "uuid" => "spec:models/user_spec.rb",
            "started_at" => "2012-09-17 18:13:02 -0700"
          },
        ]
      }
    }
    response.status.should == 200

    get "/test_runs/1"
    response_data["test_run"]["tests"][0].should == j({
      "uuid"         => "spec:models/user_spec.rb",
      "job_index"    => "0",
      "started_at"   => "2012-09-17 18:13:02 -0700",
      "completed_at" => nil,
      "result"       => nil,
      "tries"        => nil,
    })

    put "/test_runs/1", {
      "test_run" => {
        "tests" => [
          {
            "uuid" => "spec:models/user_spec.rb",
            "completed_at" => "2012-09-17 18:13:04 -0700",
            "result" => 'PASS',
            "tries" => "1",
          },
        ]
      }
    }
    response.status.should == 200


    get "/test_runs/1"
    response_data["test_run"]["tests"][0].should == j({
      "uuid"         => "spec:models/user_spec.rb",
      "job_index"    => "0",
      "started_at"   => "2012-09-17 18:13:02 -0700",
      "completed_at" => "2012-09-17 18:13:04 -0700",
      "result"       => 'PASS',
      "tries"        => "1",
    })

    # simulate requesting a test run

      # POST /projects/git@github.com%2Frails%2Frails/test_runs
      # should create a project
      # should create a project test run

    # simulate building a test run

      # PUT /projects/git@github.com%2Frails%2Frails/test_runs/1
      # PUT /projects/git@github.com%2Frails%2Frails/test_runs/tests
      # should update the test run

    # simulate running a test run




  end

  def create_test_run!


  end

  def read_test_run!
    get "/projects/#{e origin}/test_runs/1"
  end

end
#     get '/projects'
#     response_should_equal({'projects' => []})

#     post '/projects', {"project" => {"origin" => origin}}
#     response_should_equal(nil)

#     get '/projects'
#     response_should_equal({
#       'projects' => [
#         {"id" => "1", "origin" => origin}
#       ]
#     })

#     get "/projects/#{encode_origin(origin)}"
#     response_should_equal({"id" => "1", "origin" => origin})

#     get "/projects/#{encode_origin(origin)}/tests"
#     response_should_equal({
#       "tests" => []
#     })

#     tests = [
#       ["1", 'spec', "models/user_spec.rb"],
#       ["2", 'spec', "models/post_spec.rb"],
#       ["3", 'scenario', "i should be able to see my first post"],
#       ["4", 'scenario', "i should be able to delete my first post"],
#     ]

#     # create 4 tests
#     tests.each do |(id, type,name)|
#       post "/projects/#{encode_origin(origin)}/tests", {
#         "test" => {"type" => type, "name" => name}
#       }
#     end

#     # get project tests
#     get "/projects/#{encode_origin(origin)}/tests"
#     response_should_equal({
#       "tests" => tests.map{|(id, type,name)|
#         {
#           "project_id" => "1",
#           "id"         => id,
#           "type"       => type,
#           "name"       => name,
#         }
#       }
#     })

#     get "/projects/#{encode_origin(origin)}/test_runs"
#     response_should_equal({
#       "test_runs" => []
#     })

#     post "/projects/#{encode_origin(origin)}/test_runs", {
#       "test_run" => {
#         "sha"       => "c10cde0d30e79be5c3d427862e9a89852d4f8496",
#         "requestor" => "Jared Grippe",
#       }
#     }
#     response_should_equal(nil)

#     get "/projects/#{encode_origin(origin)}/test_runs"
#     response_should_equal({
#       "test_runs" => [
#         {
#           "project_id" => "1",
#           "id"         => "1",
#           "sha"        => "c10cde0d30e79be5c3d427862e9a89852d4f8496",
#           "requestor"  => "Jared Grippe",
#           "created_at" => now,
#         }
#       ]
#     })

#     get "/projects/#{encode_origin(origin)}/test_runs/1"
#     response_should_equal({
#       "project_id" => "1",
#       "id"         => "1",
#       "sha"        => "c10cde0d30e79be5c3d427862e9a89852d4f8496",
#       "requestor"  => "Jared Grippe",
#       "created_at" => now,
#     })

#   end

# end
