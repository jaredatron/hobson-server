class Hobson::TestRun::Job < Hobson::Model

  include Hobson::Model::RecordsEvents

  reference :test_run, :TestRun
  set :tests, :'Hobson::Project::Test'

end
