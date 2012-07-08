class Hobson::TestRun < Hobson::Model

  record_events!

  attribute :sha
  attribute :created_at

  reference :project, :Project

  collection :tests, :Test
  collection :jobs, :Job

end
