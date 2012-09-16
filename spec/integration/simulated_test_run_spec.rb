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
    raise response.errors if response.errors != ""
    response.body == '' ? nil : JSON.parse(response.body)
  end

  def uri
    "/projects/#{encode_origin(origin)}"
  end

  let!(:now){ Time.at(1347801214) }

  before do
    Time.should_receive(:now).any_number_of_times.and_return{ now }
  end

  it "should be able to support a full test run" do

    get '/projects'
    json.should == {'projects' => []}

    post '/projects', {"project" => {"origin" => origin}}
    json.should == nil

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

    get "/projects/#{encode_origin(origin)}/test_runs"
    json.should == {
      "test_runs" => []
    }

    post "/projects/#{encode_origin(origin)}/test_runs", {
      "test_run" => {
        "sha"       => "c10cde0d30e79be5c3d427862e9a89852d4f8496",
        "requestor" => "Jared Grippe",
      }
    }
    json.should == nil

    get "/projects/#{encode_origin(origin)}/test_runs"
    json.should == {
      "test_runs" => [
        {
          "project_id" => "1",
          "id"         => "1",
          "sha"        => "c10cde0d30e79be5c3d427862e9a89852d4f8496",
          "requestor"  => "Jared Grippe",
          "created_at" => now.to_s,
        }
      ]
    }


  end

end
