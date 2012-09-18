class Hobson::TestRun::Job < Hobson::Model

  reference :test_run, :'Hobson::TestRun'

  attribute :index

  index :index

  def tests
    test_run.find(:job => index)
  end

  def validate
    assert_present :index
  end

  def as_json options=nil
    {
      'index' => self.index,
    }
  end

end
