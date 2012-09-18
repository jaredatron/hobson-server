$:.unshift File.expand_path('../lib', __FILE__)

require 'hobson/server'
require 'resque/server'

Hobson::Model.redis = Redis.new # TEMP

run Rack::URLMap.new \
  "/" => Hobson::Server.new,
  "/resque" => Resque::Server.new
