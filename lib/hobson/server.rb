require 'sinatra/base'
require 'sinatra/namespace'
require 'active_support/json'
require 'active_support/core_ext/string/inflections'

module Hobson
  class Hobson::Server < Sinatra::Base
  end
end

require 'hobson/model'
require 'hobson/project'

require 'hobson/server/controller'

require 'hobson/server/projects'
require 'hobson/server/test_runs'


class Hobson::Server < Sinatra::Base

  LOGFILE = File.expand_path('../../../tmp/server.log', __FILE__)

  def self.logger
    @logger ||= Logger.new(LOGFILE)
  end

  register Sinatra::Namespace

  set :raise_errors, true
  set :show_exceptions, true
  enable :sessions, :logging

  before do
    env['rack.logger'] = Hobson::Server.logger
    logger.info %(#{request.env["REQUEST_METHOD"]} #{request.env["PATH_INFO"]})
    content_type 'application/json'
  end

  error do
    puts env['sinatra.error'].inspect
    logger.error env['sinatra.error'].inspect
  end

  namespace '/projects',  &Hobson::Server::Projects
  namespace '/test_runs', &Hobson::Server::TestRuns

  def self.resource name, &block

    # INDEX

    # CREATE

    # READ

    # UPDATE

    # DELETE

  end

  resource :projects do

  end

end
