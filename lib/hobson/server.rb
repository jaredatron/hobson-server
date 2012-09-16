require 'sinatra/base'
require 'sinatra/namespace'
require 'json'

module Hobson
  class Hobson::Server < Sinatra::Base
  end
end

require 'hobson/model'
require 'hobson/project'

require 'hobson/server/controller'


# require 'hobson/server/base'
require 'hobson/server/projects'

# Hobson::Server = Rack::URLMap.new(
#   '/projects' => Hobson::Server::Projects.new,
# )



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
    debugger;1
  end

  # require 'hobson/server/projects'
  # class_eval(&Hobson::Server::Projects::PROC)

  namespace '/projects', &Hobson::Server::Projects

end



