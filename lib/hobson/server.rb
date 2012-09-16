require 'sinatra/base'
require 'json'

module Hobson
end

require 'hobson/model'
require 'hobson/project'


class Hobson::Server < Sinatra::Base


  get '/projects' do
    content_type :json
    {
      projects: [

      ]
    }.to_json
  end


end
