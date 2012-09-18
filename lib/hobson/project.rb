class Hobson::Project < Hobson::Model

  attribute :origin

  collection :tests,     :'::Hobson::Project::Test'
  collection :test_runs, :'::Hobson::Project::TestRun'

  index :origin

  def validate
    assert_present :origin
  end

end

require 'hobson/project/test'
# require 'hobson/project/test_run'
