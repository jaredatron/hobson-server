class Hobson::TestRun < Hobson::Model

  include Hobson::Model::RecordsEvents

  attribute :sha
  attribute :created_at

  reference :project, :Project

  collection :tests, :'Hobson::Project::Test'
  collection :jobs,  :Job


  def schedule_build!
    Resque.enqueue Hobson::TestRun::Builder(id)
  end

end

require 'hobson/test_run/job'
