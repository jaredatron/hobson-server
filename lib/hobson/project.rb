class Hobson::Project < Hobson::Model

  attribute :origin

  collection :tests,     :'::Hobson::Project::Test'
  collection :test_runs, :'::Hobson::Project::TestRun'

  index :origin

  def validate
    assert_present :origin
  end

  def as_json options=nil
    {
      'origin' => origin,
      'path'   => "/projects/#{URI.encode(origin).gsub('/','%2F')}",
    }
  end

end

require 'hobson/project/test'
# require 'hobson/project/test_run'
