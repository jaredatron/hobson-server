module Hobson::Server::Projects
  PROC = proc do

    namespace '/projects' do

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
        # class_eval(&Hobson::Server::Projects::Tests)

      end

    end

  end

end
