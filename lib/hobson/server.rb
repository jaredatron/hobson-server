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
      {projects: Hobson::Project.all.to_a}.to_json
    end

    namespace '/:origin' do

      before do
        @project = Hobson::Project.find(origin: params["origin"]).first
      end

      # read
      get do
        @project.to_json
      end

      namespace '/tests' do

        get do
          {'tests' => @project.tests.to_a}.to_json
        end

        post do
          params["test"]["project"] = @project
          test = Hobson::Project::Test.create(params["test"])
          return ""
        end

      end

    end

  end

end
