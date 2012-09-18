class Hobson::Server

  namespace '/projects/:project_origin/test_runs' do

    # index
    get do
      respond_with :'projects/test_runs/index', :test_runs => project_test_runs.as_json
    end

  end

end
