Hobson::Server::Projects::TestRuns = Hobson::Server::Controller.new do

  get do
    {'test_runs' => @project.test_runs.to_a}.to_json
  end

  post do
    params["test_run"] ||= {}
    params["test_run"]["project"] = @project
    test_run = Hobson::Project::TestRun.new(params["test_run"])
    if test_run.save
      return nil
    else
      status 406
      {'errors' => test_run.errors}.to_json
    end
  end

end
