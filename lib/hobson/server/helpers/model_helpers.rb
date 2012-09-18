module Hobson::Server::Helpers

  def find_project
    Hobson::Project.find(origin: params["project_origin"]).first or raise Sinatra::NotFound
  end

  def find_test_run
    Hobson::TestRun.find(id: params["test_run_id"]).first or raise Sinatra::NotFound
  end

  def find_test_run_test
    test_run.tests.find(index:params['test_id']).first or raise Sinatra::NotFound
  end


  def projects
    @projects ||= Hobson::Project.all.to_a.map{|project|
      Hobson::Server::Presenters::Project.new(project.as_json)
    }
  end

  def project
    # @project ||= Hobson::Project.find(origin: params["project_origin"]).first or raise Sinatra::NotFound
    @project ||= Hobson::Server::Presenters::Project.new(find_project.as_json)
  end

  def test_runs
    @test_runs ||= Hobson::TestRun.all.to_a.map{|test_run|
      Hobson::Server::Presenters::TestRun.new(test_run.as_json)
    }
  end

  def test_run
    @test_run ||= Hobson::Server::Presenters::TestRun.new(find_test_run.as_json)
  end

  def project_tests
    @project_tests ||= find_project.tests.to_a.map{|test|
      Hobson::Server::Presenters::Project::Test.new(test.as_json)
    }
  end

  def project_test_runs
    @project_test_runs ||= find_project.test_runs.to_a.map{|test_run|
      Hobson::Server::Presenters::TestRun.new(test_run.as_json)
    }
  end

end
