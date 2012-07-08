require 'active_support/time'

module Hobson

  class << self
    def redis
      @redis ||= Redis.current
    end

    attr_writer :redis
  end

  def self.configure config

  end

end

require 'hobson/model'
require 'hobson/event'
require 'hobson/project'
require 'hobson/test_run'
