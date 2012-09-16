require 'spec_helper'

describe Hobson::Server do

  include Rack::Test::Methods

  def app
    Hobson::Server
  end

  alias_method :response, :last_response


  context "when there are no projects" do
    describe "get" do
      it "should return an empty set" do
        get '/projects'
        response.headers["Content-Type"].should == 'application/json;charset=utf-8'
        json = JSON.parse response.body
        json.should == {"projects" => []}
      end
    end
  end

  context "when there are 2 projects" do
    before do
      # Project.create()
    end
    describe "get" do
      it "should return those 2 projects" do
        get '/projects'
        response.headers["Content-Type"].should == 'application/json;charset=utf-8'
        json = JSON.parse response.body
        json.should == {"projects" => []}
      end
    end
  end

end
