class Hobson::Server

  namespace '/test_runs/:test_run_id/tests' do

    # create
    post do
      params['test']['test_run_id'] = params['test_run_id']
      test = Hobson::TestRun::Test.new(params['test'])
      test.save or status 406
      respond_with :'test_runs/tests/show', :test => test.as_json
    end

    namespace '/:test_id' do

      # update
      post do
        test = find_test_run_test
        test.update(params[:test])
        test.save or status 500
        respond_with :'test_runs/tests/show', :test => test.as_json
      end

    end

  end

end
