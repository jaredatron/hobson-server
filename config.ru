STDOUT.reopen(File.open("tmp/server.out",'w+'))


$:.unshift File.expand_path('../lib', __FILE__)

require 'hobson/server'
require 'resque/server'


Resque.redis = Hobson::Model.redis = Redis.new(
  db: ENV['HOBSON_SERVER_REDIS_DB'].to_i
)

run Rack::URLMap.new \
  "/" => Hobson::Server.new,
  "/resque" => Resque::Server.new
