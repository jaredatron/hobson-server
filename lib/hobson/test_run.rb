class Hobson::TestRun < Hobson::Model

  attribute :project
  attribute :sha
  attribute :requestor
  attribute :created_at

  collection :tests, :'Hobson::TestRun::Test'
  # collection :jobs,  :Job

  index :id
  index :project

  def created_at
    created_at = @attributes[:created_at]
    return nil if created_at.nil?
    return Time.parse(created_at) if created_at.is_a? String
    created_at
  end

  def validate
    self.created_at = Time.now if new_record?
    assert_present :project
    assert_present :sha
    assert_present :requestor
    assert_present :created_at
  end

  def as_json options={}
    super(options).merge(:tests => tests.to_a.as_json)
  end

  def tests= tests
    tests.each do |data|
      data['uuid'] = "#{data.delete('type')}:#{data.delete('name')}"
      test = self.tests.find(uuid:data['uuid']).first
      test ||= Hobson::TestRun::Test.new(test_run:self)
      test.update(data)
      test.save
    end
  end

end

require 'hobson/test_run/test'
