ROOT = Pathname.new File.expand_path('../..', __FILE__)
LIB  = ROOT + 'lib'

require 'hobson/server'

Hobson::Model.redis = Redis.new(db: 8)

require 'rack/test'

ROOT.join('spec/support').children.each{ |support| require support.to_s }

RSpec.configure do |config|

  config.before do
    Hobson::Model.redis.flushdb
  end

end
