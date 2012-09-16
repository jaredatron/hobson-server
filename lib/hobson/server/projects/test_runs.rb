Hobson::Server::Projects::TestRuns = Hobson::Server::Controller.new do

  # index
  get do
    {'test_runs' => @project.test_runs.to_a}.to_json
  end

  # create
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

  # read
  get '/:id' do
    test_run = Hobson::Project::TestRun.find(id: params[:id]).first
    if test_run.nil?
      status 404
      return nil
    end
    test_run.to_json
  end

  # delete
  delete '/:id' do
    test_run = Hobson::Project::TestRun.find(id: params[:id]).first
    if test_run.nil?
      status 404
    else
      test_run.delete
    end
    return nil
  end


end
