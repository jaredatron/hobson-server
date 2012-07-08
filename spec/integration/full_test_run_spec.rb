require 'spec_helper'

describe "a full hobson test run" do

  before{
    TestWorkspace.reset!
  }

  it "should work" do

    test_project_path = HOBSON_ROOT.join('test/projects/simple')
    sha = test_project_path.join('git/refs/heads/master').read.chomp

    # create a project using a local path
    project = Hobson::Project.create(origin: test_project_path.to_s)

    test_run = Hobson::TestRun.new(project: project, sha: sha)

    test_run.schedule_build!

    debugger;1

    # create project
    # create test_run
    # Resque.work!
      # setup workspace
      # lookup testrun
      # checkout project
      # prepare project
      # ask project for a list of tests
      # create & schedule test_run jobs

    # ensure test records were created
    # ensure job records were created
    # ensure jobs were scheduled

    # Resque.work!



  end

end
