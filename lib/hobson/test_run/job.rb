class Hobson::TestRun::Job < Hobson::Model

  record_events!

  reference :test_run, :TestRun
  set :tests, :'Hobson::Project::Test'

end
