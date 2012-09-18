class Hobson::TestRun::Test < Hobson::Model

  reference :test_run, :'Hobson::TestRun'

  attribute :uuid       # "#{type}:#{name}"
  attribute :started_at
  attribute :completed_at
  attribute :result
  attribute :tries

  index :uuid

  def validate
    assert_present :uuid
  end

  def as_json options=nil
    {
      'uuid'         => self.uuid,
      'started_at'   => self.started_at,
      'completed_at' => self.completed_at,
      'result'       => self.result,
      'tries'        => self.tries,
    }
  end

end
