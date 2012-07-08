require 'active_support/time'

module Hobson

  def redis
    @redis ||= Redis.current
  end

  attr_writer :redis

end

require 'hobson/model'
require 'hobson/event'
require 'hobson/project'
require 'hobson/test_run'
