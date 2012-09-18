class Hobson::Server::Presenters::TestRun::Test < Hobson::Server::Presenters::Test

  def status
    result.present?     ? result :
    started_at.present? ? 'running' :
    'waiting'
  end

  def started_at
    @started_at ||= @table[:started_at] && Time.parse(@table[:started_at])
  end

  def completed_at
    @completed_at ||= @table[:completed_at] && Time.parse(@table[:completed_at])
  end

  def runtime
    (completed_at || Time.now) - started_at if started_at.present?
  end

end
