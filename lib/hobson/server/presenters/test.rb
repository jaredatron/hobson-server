class Hobson::Server::Presenters::Test < Hobson::Server::Presenters::Base

  def type
    uuid[/^([^:]+)/, 1]
  end

  def name
    uuid[/^[^:]+:(.+)$/, 1]
  end

end
