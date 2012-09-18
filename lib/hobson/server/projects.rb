class Hobson::Server

  namespace '/projects' do

    # index
    get do
      respond_with :'projects/index', {projects: projects}
    end

    namespace '/:project_origin' do

      get do
        respond_with :'projects/show', {project: project}
      end

    end

  end

end

require 'hobson/server/projects/test_runs'
require 'hobson/server/projects/tests'
