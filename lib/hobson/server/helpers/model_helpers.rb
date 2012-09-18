module Hobson::Server::Helpers

  def projects
    @projects ||= Hobson::Project.all.to_a
  end

  def project
    @project ||= Hobson::Project.find(origin: params["project_origin"]).first or raise Sinatra::NotFound
  end

  def test_runs
    @test_runs ||= Hobson::TestRun.all.to_a
  end

  def test_run
    @test_run ||= Hobson::TestRun.find(id: params[:test_run_id]).first or raise Sinatra::NotFound
  end

  def project_tests
    @project_tests ||= project.tests.to_a
  end

  def project_test_runs
    @project_test_runs ||= project.test_runs.to_a
  end

end
