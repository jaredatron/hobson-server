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
      {'test_run' => test_run}.to_json
    else
      status 406
      {'errors' => test_run.errors}.to_json
    end
  end

  namespace '/:id' do

    before do
      @test_run = Hobson::Project::TestRun.find(id: params[:id]).first
    end

    # read
    get do
      if @test_run.nil?
        status 404
        return nil
      end
      {'test_run' => @test_run}.to_json
    end

    put do
      @test_run.update(params["test_run"])
      if @test_run.save
        status 200
        ""
      else
        status 406
        {'errors' => @test_run.errors}.to_json
      end
    end

    # delete
    delete do
      status @test_run.nil? ? 400 : @test_run.delete ? 200 : 500
      return nil
    end

  end


end
