class Hobson::Project < Hobson::Model

  attribute :origin

  collection :tests, :'::Hobson::Project::Test'

  index :origin

  def test_runs
    Hobson::TestRun.find(project_origin: origin)
  end

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
