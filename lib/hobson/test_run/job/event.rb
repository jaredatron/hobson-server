class Hobson::TestRun::Job::Event < Hobson::Model

  reference :job, :'Hobson::TestRun::Job'

  attribute :description
  attribute :occurred_at

  def validate
    assert_present :description
    assert_present :occurred_at
  end

  def occurred_at
    Time.parse attributes[:occurred_at]
  end

  def as_json options=nil
    {
      'description' => description,
      'occurred_at' => occurred_at,
    }
  end

end
