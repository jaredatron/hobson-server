class Hobson::Server::Presenters::TestRun < Hobson::Server::Presenters::Base

  def self.[] id
    test_run = Hobson::TestRun.find(id: id).first or raise Sinatra::NotFound
    new test_run.as_json
  end

  def tests
    @tests ||= super.map{|test| Hobson::Server::Presenters::TestRun::Test.new(test) }
  end

end

require 'hobson/server/presenters/test_run/test'
