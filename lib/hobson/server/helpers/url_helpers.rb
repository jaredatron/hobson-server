module Hobson::Server::Helpers

  def projects_path
    '/projects'
  end

  def project_path project_origin
    project_origin = project_origin(project_origin)
    "#{projects_path}/#{encode(project_origin)}"
  end

  def test_runs_path
    '/test_runs'
  end

  def test_run_path test_run
    "#{test_runs_path}/#{test_run['id']}"
  end

  def project_test_runs_path project
    "#{project_path(project)}/test_runs"
  end

  def project_tests_path project
    "#{project_path(project)}/tests"
  end

end
