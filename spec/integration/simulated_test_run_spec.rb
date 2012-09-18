require 'spec_helper'

describe Hobson::Server do

  include ServerSupport

  let!(:now){ Time.at(1347801214) }

  before do
    Time.should_receive(:now).any_number_of_times.and_return{ now }
  end

  it "should be able to support a full test run" do

    # create test run (and project)
    post "/test_runs", {
      "test_run" => {
        "project_origin" => "git@github.com:deadlyicon/hobson-server.git",
        "sha"            => "12321321321321",
        "requestor"      => "Jared Grippe",
      }
    }
    response_data.should == j({
      "test_run" => {
        "path"           => "/test_runs/1",
        "id"             => "1",
        "project_origin" => "git@github.com:deadlyicon/hobson-server.git",
        "sha"            => "12321321321321",
        "requestor"      => "Jared Grippe",
        "created_at"     => now,
        "tests"          => [],
        "jobs"           => [],
      }
    })

    # read test run
    get "/test_runs/1"
    response_data.should == j({
      "test_run" => {
        "path"           => "/test_runs/1",
        "id"             => "1",
        "project_origin" => "git@github.com:deadlyicon/hobson-server.git",
        "sha"            => "12321321321321",
        "requestor"      => "Jared Grippe",
        "created_at"     => now,
        "tests"          => [],
        "jobs"           => [],
      }
    })

    # list projects
    get "/projects"
    response_data.should == j({
      "projects" => [
        {
          "origin" => "git@github.com:deadlyicon/hobson-server.git",
          "path"   => "/projects/git@github.com:deadlyicon%2Fhobson-server.git",
        }
      ]
    })

    # list projects
    get "/projects/#{e 'git@github.com:deadlyicon/hobson-server.git'}"
    response_data.should == j({
      "project" => {
        "origin" => "git@github.com:deadlyicon/hobson-server.git",
        "path"   => "/projects/git@github.com:deadlyicon%2Fhobson-server.git",
      }
    })

    # build test run
    put "/test_runs/1", {
      "test_run" => {
        "jobs" => [
          { "index" => "0" },
          { "index" => "1" },
        ],
        "tests" => [
          { "job_index" => "0", "uuid" => "spec:models/user_spec.rb" },
          { "job_index" => "0", "uuid" => "spec:models/post_spec.rb" },
          { "job_index" => "1", "uuid" => "scenario:I should be able to see my first post" },
          { "job_index" => "1", "uuid" => "scenario:I should be able to delete my first post" },
        ]
      }
    }

    response.status.should == 200

    # execute test run

    get "/test_runs/1"
    response_data.should == j({
      "test_run" => {
        "path"           => "/test_runs/1",
        "id"             => "1",
        "project_origin" => "git@github.com:deadlyicon/hobson-server.git",
        "sha"            => "12321321321321",
        "requestor"      => "Jared Grippe",
        "created_at"     => now,
        "jobs" => [
          {
            "index"  => "0",
            "events" => [],
          },          {
            "index"  => "1",
            "events" => [],
          },
        ],
        "tests" => [
          {
            "uuid"         => "spec:models/user_spec.rb",
            "job_index"    => "0",
            "started_at"   => nil,
            "completed_at" => nil,
            "est_runtime"  => 0.0,
            "result"       => nil,
            "tries"        => 0,
          },{
            "uuid"         => "spec:models/post_spec.rb",
            "job_index"    => "0",
            "started_at"   => nil,
            "completed_at" => nil,
            "est_runtime"  => 0.0,
            "result"       => nil,
            "tries"        => 0,
          },{
            "uuid"         => "scenario:I should be able to see my first post",
            "job_index"    => "1",
            "started_at"   => nil,
            "completed_at" => nil,
            "est_runtime"  => 0.0,
            "result"       => nil,
            "tries"        => 0,
          },{
            "uuid"         => "scenario:I should be able to delete my first post",
            "job_index"    => "1",
            "started_at"   => nil,
            "completed_at" => nil,
            "est_runtime"  => 0.0,
            "result"       => nil,
            "tries"        => 0,
          },
        ]
      }
    })

    # list project tests
    get "/projects/#{e 'git@github.com:deadlyicon/hobson-server.git'}/tests"
    response_data.should == j({
      "tests" => [
        {
          "uuid"        => "spec:models/user_spec.rb",
          "est_runtime" => 0.0,
        },{
          "uuid"        => "spec:models/post_spec.rb",
          "est_runtime" => 0.0,
        },{
          "uuid"        => "scenario:I should be able to see my first post",
          "est_runtime" => 0.0,
        },{
          "uuid"        => "scenario:I should be able to delete my first post",
          "est_runtime" => 0.0,
        },
      ]
    })


    # track an event on job 0
    post "/test_runs/1/jobs/0/events", {
      "event" => {
        "description" => "checking out code",
        "occurred_at" => "2012-09-17 18:13:02 -0700",
      }
    }
    response.status.should == 200

    # confirm changes to job 0
    get "/test_runs/1"
    response_data["test_run"]["jobs"][0].should == j({
      "index" => "0",
      "events" => [
        {
          "description" => "checking out code",
          "occurred_at" => "2012-09-17 18:13:02 -0700",
        }
      ]
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


    # confirm changes to test 0
    get "/test_runs/1"
    response_data["test_run"]["tests"][0].should == j({
      "uuid"         => "spec:models/user_spec.rb",
      "job_index"    => "0",
      "est_runtime"  => 0.0,
      "started_at"   => "2012-09-17 18:13:02 -0700",
      "completed_at" => nil,
      "result"       => nil,
      "tries"        => 0,
    })

    # complete the test
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

    # confirm changes to test 0
    get "/test_runs/1"
    response_data["test_run"]["tests"][0].should == j({
      "uuid"         => "spec:models/user_spec.rb",
      "job_index"    => "0",
      "est_runtime"  => 0.0,
      "started_at"   => "2012-09-17 18:13:02 -0700",
      "completed_at" => "2012-09-17 18:13:04 -0700",
      "result"       => 'PASS',
      "tries"        => "1",
    })

  end

end
