class Hobson::Server::Presenters::TestRun::Job < Hobson::Server::Presenters::Base

  def events
    @events ||= super.map{|event| Hobson::Server::Presenters::TestRun::Job::Event.new(event) }
  end

end

require 'hobson/server/presenters/test_run/job/event'
