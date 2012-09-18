require 'spec_helper'

describe 'models' do

  it "should work" do
    # project = Hobson::Project.create(origin: 'git@github.com/rails/rails')

    test_run = Hobson::TestRun.create!(
      project_origin: 'git@github.com/rails/rails',
      sha: 'a',
      requestor: 'Jared Grippe',
    )

    project = test_run.project

    test = Hobson::TestRun::Test.create!(
      test_run: test_run,
      uuid: 'spec:ass_spec.rb',
      job_index: 0,
    )

    job = Hobson::TestRun::Job.create!(
      test_run: test_run,
      index: 0,
    )

    job.track_event!(
      description: 'running tests',
      occurred_at: '2012-09-17 18:13:02 -0700',
    )

  end

end
