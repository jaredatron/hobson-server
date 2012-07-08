require 'redis'
require 'ohm'
require 'hobson/patches/ohm'
# require 'active_model'

class Hobson::Model < Ohm::Model

  # include ActiveModel::Validations

end

require 'hobson/model/records_events'
