class Hobson::Project::TestRun::Test < Hobson::Model

  reference :test_run, :'Hobson::Project::TestRun'

  attribute :uuid       # "#{type}:#{name}"
  attribute :runtime
  attribute :result
  attribute :tries

  index :uuid

  def validate
    assert_present :uuid
  end

  def as_json options=nil
    {
      'uuid'    => self.uuid,
      'runtime' => self.runtime,
      'result'  => self.result,
      'tries'   => self.tries,
    }
    # json = super(options)
    # json.delete('uuid')
    # json['type'] = self.type
    # json['name'] = self.name
    # json
  end

end
