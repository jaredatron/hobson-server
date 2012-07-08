class Hobson::Project::Test < Hobson::Model

  reference :project, :'Hobson::Project'
  index :test_run_id

  attribute :uid # "#{type}:#{name}"

  index  :uid
  unique :uid

  def type
    type = uid.match(/^(.+?):(.*)$/).to_a[-2]
  end

  def name
    name = uid.match(/^(.+?):(.*)$/).to_a[-1]
  end

end
