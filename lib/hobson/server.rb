require 'sinatra/base'
require 'sinatra/namespace'
require 'active_support/json'
require 'active_support/core_ext/string/inflections'

module Hobson
end

require 'hobson/model'
require 'hobson/project'
require 'hobson/test_run'

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

  helpers do

    def path_to_url path
      url = URI.parse(request.url)
      url.path = path
      url.to_s
    end

    def encode string
      URI.encode(string).gsub('/', '%2F')
    end

    def project_url project
      path_to_url "/projects/#{encode project.origin}"
    end

  end

end

require 'hobson/server/projects'
require 'hobson/server/test_runs'

