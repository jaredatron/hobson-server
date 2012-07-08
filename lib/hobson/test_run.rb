class Hobson::TestRun < Hobson::Model

  record_events!

  attribute :sha
  attribute :created_at

  reference :project, :Project

  collection :tests, :'Hobson::Project::Test'
  collection :jobs,  :Job

end

require 'hobson/test_run/job'
