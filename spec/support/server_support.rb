require 'active_support/concern'

module ServerSupport

  extend ActiveSupport::Concern
  include Rack::Test::Methods

  def app
    Hobson::Server
  end

  def response
    last_response
  end

  def response_data
    raise response.errors if response.errors != ""
    response.body == '' ? nil : JSON.parse(response.body)
  end

  def response_should_equal expected_response
    response.headers["Content-Type"].should == 'application/json;charset=utf-8'

    if expected_response.nil?
      response.body.should be_blank
    else
      response_data.should == JSON.parse(expected_response.to_json)
    end
  end

  def e string
    URI.encode(string).gsub('/', '%2F')
  end

  def j data
    JSON.parse(data.to_json)
  end

  def encode_origin origin
    origin.gsub('/', '%2F')
  end

  def project_path project
    "/projects/#{encode_origin(project.origin)}"
  end

end
