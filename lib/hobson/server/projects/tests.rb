Hobson::Server::Projects::Tests = proc do

  namespace '/tests' do

    get do
      {'tests' => @project.tests.to_a}.to_json
    end

    post do
      params["test"]["project"] = @project
      test = Hobson::Project::Test.create(params["test"])
      return ""
    end

  end

end
