class Hobson::Project::TestRun < Hobson::Model

  reference :project, :'Hobson::Project'

  attribute :sha
  attribute :requestor
  attribute :created_at

  collection :tests, :Test
  # collection :jobs,  :Job

  def created_at
    created_at = @attributes[:created_at]
    return nil if created_at.nil?
    return Time.parse(created_at) if created_at.is_a? String
    created_at
  end

  def validate
    self.created_at = Time.now if new_record?
    assert_present :sha
    assert_present :requestor
    assert_present :created_at
  end

end
