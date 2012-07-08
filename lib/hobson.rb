require 'redis'
require 'ohm'
require 'time'

module Hobson
  autoload :Model,   'hobson/model'
  autoload :Event,   'hobson/event'
  autoload :Project, 'hobson/project'
  autoload :TestRun, 'hobson/test_run'
  autoload :Server,  'hobson/server'
end
