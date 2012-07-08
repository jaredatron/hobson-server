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

    # TODO make this read a .hobson file to see what to execute
    tests = workspace.execute('hobson list').split("\n")
    tests.map!{ |uid|
      Hobson::Project::Test.find_or_create(uid: uid)
    }

    test.each{|test| test_run.tests.add test }

    debugger;1




          # setup workspace
      # lookup testrun
      # checkout project
      # prepare project
      # ask project for a list of tests
      # create & schedule test_run jobs



    raise "building test run #{test_run.inspect}"

  end

end
