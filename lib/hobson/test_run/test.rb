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
    @project_test ||= begin # TODO dont or/create here
      test_run.project.tests.find(uuid: uuid).first or \
      Hobson::Project::Test.create!(project: test_run.project, uuid: uuid)
    end
  end

  def est_runtime
    project_test.est_runtime
  end

  def tries
    attributes[:tries] || 0
  end

  def validate
    assert_present :uuid
    assert_present :job_index
    assert_present :result if completed_at.present?
  end

  def as_json options=nil
    {
      'uuid'         => uuid,
      'job_index'    => job_index,
      'est_runtime'  => est_runtime,
      'started_at'   => started_at,
      'completed_at' => completed_at,
      'result'       => result,
      'tries'        => tries,
    }
  end

end
