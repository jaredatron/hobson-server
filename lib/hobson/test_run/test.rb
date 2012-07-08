class Hobson::TestRun::Test < Hobson::Model

  reference :test_run, :'Hobson::TestRun'
  index :test_run_id

  attribute :type
  attribute :name
  # attribute :uuid # "#{project.name}:#{type}:#{name}"
  attribute :est_runtime, ->(x){ Integer(x) if x }
  attribute :running,     ->(x){ x == 1 }
  attribute :result      # PASS|FAIL|PENDING
  attribute :runtime,     ->(x){ Integer(x) if x }


  def running= value
    value ? 1 : nil
  end

  # def before_save
  #   self.uuid = "#{test_run.project.name}:#{type}:#{name}"
  # end

  # index  :uuid
  # unique :uuid

  # def type
  #   type = tests.match(/^(.+?):(.*)$/).to_a[-2]
  # end

  # def name
  #   name = tests.match(/^(.+?):(.*)$/).to_a[-1]
  # end

end
