Hobson::Server::TestRuns = Hobson::Server::Controller.new do

  # index
  get do
    {'test_runs' => Hobson::Project::TestRun.all.to_a}.to_json
  end

end
