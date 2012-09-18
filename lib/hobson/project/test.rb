class Hobson::Project::Test < Hobson::Model

  reference :project, :'Hobson::Project'

  attribute :uuid
  attribute :runtimes

  index :uuid

  def est_runtime
    0.0
  end

  def as_json options=nil
    {
      'uuid'        => uuid,
      'est_runtime' => est_runtime,
    }
  end

end
