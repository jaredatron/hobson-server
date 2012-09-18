class Hobson::Server::Presenters::TestRun < Hobson::Server::Presenters::Base

  def jobs
    @jobs ||= super.map{|job| Hobson::Server::Presenters::TestRun::Job.new(job) }
  end

  def tests
    @tests ||= super.map{|test| Hobson::Server::Presenters::TestRun::Test.new(test) }
  end

end

require 'hobson/server/presenters/test_run/job'
require 'hobson/server/presenters/test_run/test'
