class Hobson::TestRun < Hobson::Model

  attribute :project_origin
  attribute :sha
  attribute :requestor
  attribute :created_at

  collection :tests, :'Hobson::TestRun::Test'
  collection :jobs,  :'Hobson::TestRun::Job'

  index :id
  index :project_origin

  def created_at
    created_at = @attributes[:created_at]
    return nil if created_at.nil?
    return Time.parse(created_at) if created_at.is_a? String
    created_at
  end

  def validate
    self.created_at = Time.now if new_record?
    assert_present :project_origin
    assert_present :sha
    assert_present :requestor
    assert_present :created_at
  end

  def as_json options=nil
    {
      'id'             => @id,
      'path'           => "/test_runs/#{id}",
      'project_origin' => project_origin,
      'sha'            => sha,
      'requestor'      => requestor,
      'created_at'     => created_at,
      'tests'          => tests.to_a,
      'jobs'           => jobs.to_a,
    }
  end

  def project
    Hobson::Project.find_or_create!(origin:project_origin)
  end

  def tests= tests
    tests.each do |data|
      # find or create test run test
      test = self.tests.find(uuid:data['uuid']).first
      test ||= Hobson::TestRun::Test.new(test_run:self)
      test.update(data)
      test.save_or_raise_errors!
      test.project_test # ensure project test record exists
    end
    true
  end

  def jobs= jobs
    jobs.each do |data|
      Hobson::TestRun::Job.create! data.merge(test_run: self)
    end
  end

end

require 'hobson/test_run/test'
require 'hobson/test_run/job'
