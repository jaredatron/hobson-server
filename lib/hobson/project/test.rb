class Hobson::Project::Test < Hobson::Model

  reference :test_run, :'Hobson::TestRun'

  attribute :name
  attribute :est_runtime, ->(x){ Integer(x) if x }
  attribute :running,     ->(x){ x == 1 }
  attribute :result      # PASS|FAIL|PENDING
  attribute :runtime,     ->(x){ Integer(x) if x }

  def running= value
    value ? 1 : nil
  end

end
