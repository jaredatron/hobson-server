class Hobson::Server

  namespace '/test_runs/:test_run_id/jobs' do

    namespace '/:job_index' do

      namespace '/events' do

        post do
          @test_run = Hobson::TestRun[params['test_run_id']]
          @job = @test_run.jobs.find(index:params['job_index']).first
          @job.track_event!(params['event']) or status 500
          ''
        end

      end

    end

  end

end
