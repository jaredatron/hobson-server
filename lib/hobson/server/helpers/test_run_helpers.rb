module Hobson::Server::Helpers

  def test_run_test_status test
    test['result'].present? ? test['result'] :
    test['started_at'].present? ? 'running' : 'waiting'
  end

end
