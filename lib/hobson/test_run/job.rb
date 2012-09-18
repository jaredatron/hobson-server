class Hobson::TestRun::Job < Hobson::Model

  reference :test_run, :'Hobson::TestRun'

  set :events, :'Hobson::TestRun::Job::Event'

  attribute :index

  index :index

  def track_event! event
    events.add Hobson::TestRun::Job::Event.create!(event)
  end

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

require 'hobson/test_run/job/event'
