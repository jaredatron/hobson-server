Hobson::Server::Projects = Hobson::Server::Controller.new do

  # create
  post do
    Hobson::Project.create(params["project"])
    return ""
  end

  # index
  get do
    {projects: Hobson::Project.all.to_a}.to_json
  end

  namespace '/:origin' do

    before do
      @project = Hobson::Project.find(origin: params["origin"]).first
    end

    # read
    get do
      @project.to_json
    end

    # delete

    delete do
      if @project.nil?
        status 404
      else
        @project.delete
      end
      return nil
    end

    require 'hobson/server/projects/tests'
    namespace '/tests', &Hobson::Server::Projects::Tests

    require 'hobson/server/projects/test_runs'
    namespace '/test_runs', &Hobson::Server::Projects::TestRuns

  end

end
