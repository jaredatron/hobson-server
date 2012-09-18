$:.unshift File.expand_path('../lib', __FILE__)

require 'hobson/server'

Hobson::Model.redis = Redis.new # TEMP

run Hobson::Server
