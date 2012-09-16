require 'redis'
require 'ohm'
require 'hobson/patches/ohm'

class Hobson::Model < Ohm::Model

  class << self
    attr_accessor :redis
  end

  # patch Ohm to use the same redis (its thread safe now)
  def self.db
    Hobson::Model.redis
  end

  def as_json options=nil
    attributes.merge(:id => @id).as_json(options)
  end

  def new_record?
    @id.nil?
  end

end
