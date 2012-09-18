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

  end
end
