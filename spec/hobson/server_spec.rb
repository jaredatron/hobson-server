require 'spec_helper'

describe Hobson::Server do

  include Rack::Test::Methods

  def app
    Hobson::Server
  end

  alias_method :response, :last_response

  it "should" do
    get '/projects'
    response.headers["Content-Type"].should == 'application/json;charset=utf-8'
    json = JSON.parse response.body
    json.should == {"projects" => []}
  end

end
