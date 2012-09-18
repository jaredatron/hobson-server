class Hobson::Server

  namespace '/test_runs' do

    # index
    get do
      respond_with :'test_runs/index', :test_runs => test_runs.as_json
    end

    # create
    post do
      test_run = Hobson::TestRun.new(params["test_run"])
      if test_run.save && test_run.project
        respond_with :'test_runs/show', :test_run => test_run.as_json
      else
        status 406
        {'errors' => test_run.errors}.to_json
      end
    end

    namespace '/:test_run_id' do

      # read
      get do
        respond_with :'test_runs/show', :test_run => test_run
      end

      # update
      put do
        test_run.update(params["test_run"])
        test_run.save or status 406
        respond_with :'test_runs/show', :test_run => test_run.as_json
      end

      # delete
      delete do
        status test_run.nil? ? 400 : test_run.delete ? 200 : 500
        respond_to do |f|
          f.json { nil }
          f.html { redirect test_runs_path }
        end
      end

    end

  end

end

require 'hobson/server/test_runs/jobs'
