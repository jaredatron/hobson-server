Hobson::Server::Projects::Tests = Hobson::Server::Controller.new do

  get do
    {'tests' => @project.tests.to_a}.to_json
  end

  post do
    params["test"]["project"] = @project
    Hobson::Project::Test.create(params["test"])
    return ""
  end

end
