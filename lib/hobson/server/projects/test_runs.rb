Hobson::Server::Projects::TestRuns = Hobson::Server::Controller.new do

  # index
  get do
    test_runs = Hobson::Project::TestRun.find(project:params["project"]).to_a
    {'test_runs' => test_runs}.to_json
  end

end
