class Hobson::TestRun::Test < Hobson::Model

  reference :test_run, :'Hobson::TestRun'

  attribute :uuid
  attribute :job_index
  attribute :started_at
  attribute :completed_at
  attribute :result
  attribute :tries

  index :uuid

  def job
    test_run.jobs.find(index:job_index).first
  end

  def project_test
    test_run.project.tests.find(uuid: uuid).first or \
    Hobson::Project::Test.create!(project: test_run.project, uuid: uuid)
  end

  def validate
    assert_present :uuid
    assert_present :job_index
    if completed_at.present?
      assert_present :result
      assert_present :tries
    end
  end

  def as_json options=nil
    {
      'uuid'         => uuid,
      'job_index'    => job_index,
      'started_at'   => started_at,
      'completed_at' => completed_at,
      'result'       => result,
      'tries'        => tries,
    }
  end

end
