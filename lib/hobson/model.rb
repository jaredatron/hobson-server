class Hobson::Model < Ohm::Model

  def self.record_events!
    set :events, :'Hobson::Event'
    include Hobson::Model::RecordsEvents
  end

end

require 'hobson/model/records_events'

# patching Ohms way of getting constants
module Ohm::Utils
  def self.const(parent, name)
    return name unless Symbol === name

    names = name.to_s.split('::')
    if names.first.empty?
      names.shift
      parent = Object
    end

    names.each do |name|
      parent = parent.const_defined?(name) ? parent.const_get(name) : parent.const_missing(name)
    end
    parent
  end
end
