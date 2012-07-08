module Hobson::TestRun::Builder

  def self.perform test_run_id

    test_run = TestRun[test_run_id]

    raise "building test run"

  end

end
