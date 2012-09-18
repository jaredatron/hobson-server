class Hobson::Server

  namespace '/test_runs' do

    # index
    get do
      {'test_runs' => Hobson::TestRun.all.to_a}.to_json
    end

    # create
    post do
      test_run = Hobson::TestRun.new(params["test_run"])
      if test_run.save && test_run.project
        {'test_run' => test_run}.to_json
      else
        status 406
        {'errors' => test_run.errors}.to_json
      end
    end

    namespace '/:id' do

      before do
        @test_run = Hobson::TestRun.find(id: params[:id]).first
      end

      # read
      get do
        if @test_run.nil?
          status 404
          return nil
        end
        test_run = @test_run.as_json
        test_run['url'] = test_run_url(@test_run)
        {'test_run' => test_run}.to_json
      end

      # update
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

end

require 'hobson/server/test_runs/jobs'
