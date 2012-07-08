class Hobson::Project::Test < Hobson::Model

  reference :test_run, :'Hobson::TestRun'
  attribute :name        # string
  attribute :est_runtime # seconds
  attribute :running     # boolean
  attribute :result      # PASS|FAIL|PENDING
  attribute :runtime     # seconds

end
