class Hobson::Project::TestRun::Test < Hobson::Model

  reference :test_run, :'Hobson::Project::TestRun'

  attribute :uuid # "#{type}:#{name}"

  index :uuid

  def type
    uuid[/^([^:]+)/,1]
  end

  def name
    uuid[/^.+:(.+)$/,1]
  end

  def validate
    assert_present :uuid
  end

  def as_json options={}
    json = super(options)
    json.delete('uuid')
    json['type'] = self.type
    json['name'] = self.name
    json
  end

end
