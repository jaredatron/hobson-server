require 'sinatra/base'
require 'json'

module Hobson
  class Server < Sinatra::Base


    get '/projects' do
      content_type :json
      {
        projects: [

        ]
      }.to_json
    end


  end
end

