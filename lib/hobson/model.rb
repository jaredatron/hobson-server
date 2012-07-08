require 'redis'
require 'ohm'
require 'hobson/patches/ohm'
# require 'active_model'

class Hobson::Model < Ohm::Model

  def self.db
    Hobson.redis
  end

  # include ActiveModel::Validations

end

require 'hobson/model/records_events'
