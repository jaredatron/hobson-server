Hobson::Server::Projects = Hobson::Server::Controller.new do
# namespace '/projects' do

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

    require 'hobson/server/projects/tests'
    # include Hobson::Server::Projects::Tests
    namespace '/tests', &Hobson::Server::Projects::Tests


  end

end

# }
# end
