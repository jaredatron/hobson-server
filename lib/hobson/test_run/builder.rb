class Hobson::TestRun::Builder

  @queue = :hobson

  def self.perform test_run_id
    new test_run_id
  end

  delegate :workspace, :to => Hobson

  def initialize test_run_id
    test_run = Hobson::TestRun[test_run_id]
    workspace = Hobson::Project::Workspace.new test_run.project

    test_run.record_event :building!

    workspace.checkout! test_run.sha


    pp workspace.execute 'hobson list'


          # setup workspace
      # lookup testrun
      # checkout project
      # prepare project
      # ask project for a list of tests
      # create & schedule test_run jobs

    debugger;1

    raise "building test run #{test_run.inspect}"

  end

end
