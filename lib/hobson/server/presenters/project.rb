class Hobson::Server::Presenters::Project < Hobson::Server::Presenters::Base

  def test_runs
    @test_runs ||= super.map{|test_run| Hobson::Server::Presenters::TestRun::Job.new(test_run) }
  end

  def tests
    raise self.inspect
    @tests ||= super.map{|test| Hobson::Server::Presenters::Project::Test.new(test) }
  end

end

require 'hobson/server/presenters/project/test'
