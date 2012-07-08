require 'spec_helper'

describe "persistance" do

  it "should work" do

    create_project_and_test_runs!

    project = Hobson::Project['git://github.com/rails/rails.git']
    project.should be_a Hobson::Project

    project.test_runs.size.should == 2

    test_run = project.test_runs.first
    test_run.should be_a Hobson::TestRun
    test_run.tests.size.should == 100
    test_run.jobs.size.should == 10

    job = test_run.jobs.first
    job.should be_a Hobson::TestRun::Job
    job.tests.size.should == 10

    test = job.tests.first
    test.should be_a Hobson::Project::Test
    test.name.should be_a String
    test.est_runtime.should be_a Integer
    test.runtime.should be_a Integer
    test.running.should be_false
    test.result.should == 'PASS'

    test_run.events.map(&:name).to_set.should == %w{
      building
      detecting_tests
      balancing
      enqueued_jobs
    }.to_set

    event = test_run.events.first
    event.should be_a Hobson::Event
    event.name.should be_a String
    event.occurred_at.should be_a Time

    debugger;1
  end

  def create_project_and_test_runs!
    # create project
    project = Hobson::Project.new(origin: 'git://github.com/rails/rails.git')
    project.save or fail("failed to save #{project.inspect}")

    2.times do
      # create a test run
      test_run = Hobson::TestRun.new(project: project)
      test_run.save or fail("failed to save #{test_run.inspect}")

      test_run.record_event :building

      test_run.record_event :detecting_tests

      # create some tests
      100.times do |i|
        test = Hobson::Project::Test.new(
          test_run: test_run,
          name: "spec/#{i}_spec.rb",
          est_runtime: rand,
          running: false,
          result: 'PASS',
          runtime: rand
        )
        test.save or fail("failed to save #{test.inspext}")
      end

      test_run.record_event :balancing

      # create jobs
      10.times do |i|
        job = Hobson::TestRun::Job.new(test_run: test_run)
        job.save or fail("failed to save #{job.inspect}")
      end

      # divide tests up among jobs
      tests = test_run.tests.to_a.dup
      jobs  = test_run.jobs.to_a.dup
      until tests.empty?
        job, test = jobs.shift, tests.shift
        job.tests.add test
        jobs.push job
      end

      test_run.record_event :enqueued_jobs

      test_run.jobs.each do |job|
        job.record_event :created
        job.record_event :enqueued
        job.record_event :checking_out_code
        job.record_event :preparing
        job.record_event :running_tests
        job.record_event :tearing_down
        job.record_event :post_processing
        job.record_event :saving_artifacts
        job.record_event :complete
      end

    end
  end

end
