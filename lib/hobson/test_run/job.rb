class Hobson::TestRun < Hobson::Model

  record_events!

  attribute :index
  reference :test_run, :TestRun

  set :tests,  :Test

end
