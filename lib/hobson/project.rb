class Hobson::Project < Hobson::Model

  def self.[] origin
    find(origin:origin).first
  end

  attribute :name
  attribute :origin

  unique :name
  index :origin

  collection :test_runs, :'::Hobson::TestRun'

  # validates_presence_of :name
  def validate
    assert_present :name
  end

  def origin= origin
    @attributes[:origin] = origin
    @attributes[:name] ||= self.class.name_from_origin(origin)
  end

  def self.name_from_origin origin
    origin.scan(%r{/([^/]+?)(?:/|\.git)?$}).try(:first).try(:first) rescue
      raise "unable to parse project name from origin #{origin.inspect}"
  end

end

require 'hobson/project/test'
