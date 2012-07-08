class Hobson::Project < Hobson::Model

  def self.[] origin
    find(origin:origin).first
  end

  autoload :Test, 'hobson/project/test'

  attribute :name
  attribute :origin

  unique :name
  index :origin

  collection :test_runs, :'::Hobson::TestRun'

end
