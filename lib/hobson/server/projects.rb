class Hobson::Server

  namespace '/projects' do

    # index
    get do
      respond_with :'projects/index', {projects: projects}.as_json
    end

    namespace '/:project_origin' do

      get do
        respond_with :'projects/show', {project: project}.as_json
      end

    end

  end

end

require 'hobson/server/projects/test_runs'
require 'hobson/server/projects/tests'
