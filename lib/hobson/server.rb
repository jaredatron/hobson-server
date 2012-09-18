require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/respond_with'
require 'sinatra/partial'
require 'active_support/json'
require 'active_support/core_ext/string/inflections'
require 'haml'

module Hobson
  class Hobson::Server < Sinatra::Base
  end
end

require 'hobson/model'
require 'hobson/project'
require 'hobson/test_run'
require 'hobson/server/helpers'

class Hobson::Server

  LOGFILE = File.expand_path('../../../tmp/server.log', __FILE__)

  def self.logger
    @logger ||= Logger.new(LOGFILE)
  end

  use Rack::MethodOverride
  register Sinatra::Namespace
  register Sinatra::RespondWith
  register Sinatra::Partial

  respond_to :html, :json

  root = File.expand_path('..', __FILE__) + '/server'

  set :views,               File.join(root, "views")
  set :public_folder,       File.join(root, "public")
  set :static,              true
  set :partial_underscores, true
  # set :raise_errors,        true
  # set :show_exceptions,     true
  enable :sessions,         :logging

  helpers Hobson::Server::Helpers

  before do
    env['rack.logger'] = Hobson::Server.logger
    logger.info %(#{request.env["REQUEST_METHOD"]} #{request.env["PATH_INFO"]})
  end

  # error do
  #   puts env['sinatra.error'].inspect
  #   logger.error env['sinatra.error'].inspect
  # end

  # not_found do
  #   'This is nowhere to be found.'
  # end

  # FUCKED = Class.new(StandardError)

  # error FUCKED do
  #   "your fucked"
  # end

end

require 'hobson/server/projects'
require 'hobson/server/test_runs'

