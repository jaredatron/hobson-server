module Hobson::Server::Helpers

  # disable sinatra/json because it's broken
  def json object
    object.to_json
  end

  def encode string
    URI.encode(string).gsub('/','%2F')
  end

  def project_origin project
    return project.project_origin if project.respond_to?(:project_origin)
    return project.origin if project.respond_to?(:origin)
    return project
  end


end

require 'hobson/server/helpers/model_helpers'
require 'hobson/server/helpers/url_helpers'
require 'hobson/server/helpers/link_helpers'
require 'hobson/server/helpers/test_run_helpers'
