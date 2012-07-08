class Hobson::Project < Hobson::Model

  attribute :name
  attribute :origin

  unique :name
  index :name

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
    name = origin[%r{/([^/]+?)(?:/|\.git)?$}, 1] || origin[%r{([^/]+)$}]
    name or raise "unable to parse project name from origin #{origin.inspect}"
  end

end

require 'hobson/project/workspace'
require 'hobson/project/test'
