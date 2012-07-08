require 'redis'
require 'ohm'
require 'hobson/patches/ohm'
# require 'active_model'

class Hobson::Model < Ohm::Model

  def self.db
    Hobson.redis
  end

  def self.find_or_create conditions
    find(conditions).first or create(conditions)
  end

  # include ActiveModel::Validations

end

require 'hobson/model/records_events'
