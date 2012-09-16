require 'spec_helper'

describe Hobson::Server do

  include Rack::Test::Methods

  def app
    Hobson::Server
  end

  alias_method :response, :last_response

  def encode_origin origin
    origin.gsub('/', '%2F')
  end

  let(:origin){ 'git@github.com:deadlyicon/hobson-server.git' }

  def json
    JSON.parse(response.body)
  end

  def uri
    "/projects/#{encode_origin(origin)}"
  end

  it "should be able to support a full test run" do

    get '/projects'
    json.should == {'projects' => []}

    post '/projects', {"project" => {"origin" => origin}}

    get '/projects'
    json.should == {
      'projects' => [
        {"id" => "1", "origin" => origin}
      ]
    }

    get "/projects/#{encode_origin(origin)}"
    json.should == {"id" => "1", "origin" => origin}

    get "/projects/#{encode_origin(origin)}/tests"
    json.should == {
      "tests" => []
    }

    tests = [
      ["1", 'spec', "models/user_spec.rb"],
      ["2", 'spec', "models/post_spec.rb"],
      ["3", 'scenario', "i should be able to see my first post"],
      ["4", 'scenario', "i should be able to delete my first post"],
    ]

    # create 4 tests
    tests.each do |(id, type,name)|
      post "/projects/#{encode_origin(origin)}/tests", {
        "test" => {"type" => type, "name" => name}
      }
    end

    # get project tests
    get "/projects/#{encode_origin(origin)}/tests"
    json.should == {
      "tests" => tests.map{|(id, type,name)|
        {
          "project_id" => "1",
          "id"         => id,
          "type"       => type,
          "name"       => name,
        }
      }
    }

    # get "/projects/#{encode_origin(origin)}/tets_runs"
    # json.should == {
    #   "test_runs" => []
    # }



  end

end
