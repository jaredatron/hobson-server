class Hobson::Project < Hobson::Model

  def self.[] origin
    find(origin:origin).first
  end

  attribute :name
  attribute :origin

  unique :name
  index :origin

  collection :test_runs, :'::Hobson::TestRun'

  def before_save
    self.activation_code ||= "user:#{id}"
  end

end

require 'hobson/project/test'
