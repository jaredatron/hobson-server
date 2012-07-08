class Hobson::TestRun < Hobson::Model

  autoload :Job, 'hobson/test_run/job'

  record_events!

  attribute :sha
  attribute :created_at

  reference :project, :Project

  collection :tests, :'Hobson::Project::Test'
  collection :jobs,  :Job

end
