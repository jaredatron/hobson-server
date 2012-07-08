
HOBSON_ROOT = Pathname.new File.expand_path('../..', __FILE__)

HOBSON_WORKSPACE_ROOT = HOBSON_ROOT+'tmp/workspace'

HOBSON_ROOT.join('spec/support').children.each{ |support|
  require support.to_s
}

# TODO setup redis
require 'hobson'



require 'resque_unit'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Assert

  config.include ResqueUnit::Assertions

  config.before do
    Hobson.redis.flushdb
    Resque.reset!

    HOBSON_WORKSPACE_ROOT.rmtree if HOBSON_WORKSPACE_ROOT.exist?
    HOBSON_WORKSPACE_ROOT.mkpath
    Hobson.workspace = Hobson::Workspace.new(HOBSON_WORKSPACE_ROOT)

  end
end
