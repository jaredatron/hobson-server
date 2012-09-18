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

  class Invalid < StandardError; end

  def self.create! atts = {}
    instance = new(atts)
    instance.save or raise Hobson::Model::Invalid, instance.errors
  end

  def self.find_or_create! atts = {}
    find(atts).first or create!(atts)
  end

  def as_json options=nil
    # attributes.merge(:id => @id).as_json(options)
    attributes.keys.inject(:id => @id){|hash, attribute|
      hash.update(attribute => send(attribute))
    }.as_json(options)
  end

  def new_record?
    @id.nil?
  end

end
