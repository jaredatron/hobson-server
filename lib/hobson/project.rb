class Hobson::Project < Hobson::Model

  attribute :origin
  index :origin

  collection :test_runs, :'::Hobson::TestRun'

end
