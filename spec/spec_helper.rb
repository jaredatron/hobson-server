
HOBSON_ROOT = Pathname.new File.expand_path('../..', __FILE__)

HOBSON_ROOT.join('spec/support').children.each{ |support|
  require support.to_s
}

# TODO setup redis
require 'hobson'
require 'resque-unit'


RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before do
    Hobson.redis.flushdb
    Resque.reset!
  end
end
