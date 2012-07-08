class Hobson::TestRun::Job < Hobson::Model

  record_events!

  attribute :index
  reference :test_run, :TestRun

  set :tests, :'Hobson::Project::Test'

end
