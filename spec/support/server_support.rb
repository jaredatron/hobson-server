module ServerSupport

  include Rack::Test::Methods

  def app
    Hobson::Server
  end

  def response
    last_response
  end

  def encode_origin origin
    origin.gsub('/', '%2F')
  end

  def project_path project
    "/projects/#{encode_origin(project.origin)}"
  end

end
