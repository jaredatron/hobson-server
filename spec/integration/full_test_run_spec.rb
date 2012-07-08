require 'spec_helper'

describe "a full hobson test run" do

  before{
    TestWorkspace.reset!
  }

  it "should work" do

    debugger;1

    # Hobson::Project.create(origin:)

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
