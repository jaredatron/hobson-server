class Hobson::Server

  namespace '/projects' do

    # index
    get do
      {projects: Hobson::Project.all.to_a}.to_json
    end

    namespace '/:origin' do

      before do
        @project = Hobson::Project.find(origin: params["origin"]).first
      end

      get do
        {project: @project}.to_json
      end

      namespace '/tests' do

        get do
          {tests: @project.tests.to_a}.to_json
        end

      end
    end

    #   # read
    #   get do
    #     @project.to_json
    #   end

    #   # delete
    #   delete do
    #     if @project.nil?
    #       status 404
    #     else
    #       @project.delete
    #     end
    #     return nil
    #   end

    #   require 'hobson/server/projects/tests'
    #   namespace '/tests', &Hobson::Server::Projects::Tests

    #   require 'hobson/server/projects/test_runs'
    #   namespace '/test_runs', &Hobson::Server::Projects::TestRuns

    # end

  end
end
