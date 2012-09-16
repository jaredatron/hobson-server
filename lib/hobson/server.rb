require 'sinatra/base'
require 'sinatra/namespace'
require 'json'

module Hobson
end

require 'hobson/model'
require 'hobson/project'


class Hobson::Server < Sinatra::Base

  LOGFILE = File.expand_path('../../../tmp/server.log', __FILE__)

  def self.logger
    @logger ||= Logger.new(LOGFILE)
  end

  register Sinatra::Namespace

  set :logging, true
  enable  :sessions, :logging

  before do
    env['rack.logger'] = Hobson::Server.logger
    logger.info %(#{request.env["REQUEST_METHOD"]} #{request.env["PATH_INFO"]})
    content_type 'application/json'
  end

  error do
    puts "ERRIR"
    logger.error env['sinatra.error'].inspect
  end

  namespace '/projects' do

    # create
    post do
      Hobson::Project.create(params["project"])
      return ""
    end

    # index
    get do
      {projects: Hobson::Project.all.map(&:attributes)}.to_json
    end

    # read
    get '/:origin' do
      project = Hobson::Project.find(origin: params["origin"]).first
      project.attributes.to_json
    end

  end

end
