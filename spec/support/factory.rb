require "faker"

module Factory

  def self.origin
    "git://github.com/#{Faker::Name.first_name}/#{Faker::Name.first_name}.git"
  end

  def self.test_uuid
    %(#{%w(spec scenario).sample}:#{Faker::Name.title})
  end

  def self.create model, options={}

    case model.name
    when Hobson::Project.name

      options[:origin] ||= Factory.origin
      Hobson::Project.create! options

    when Hobson::Project::Test.name

      options[:project] ||= Factory.create(Hobson::Project)
      options[:uuid] ||= Factory.test_uuid
      Hobson::Project::Test.create! options

    when Hobson::TestRun.name

      options[:project_origin] ||= Factory.origin
      options[:sha] ||= rand(9999999999999999).to_s
      options[:requestor] ||= "#{Faker::Name.first_name} #{Faker::Name.last_name}"
      Hobson::TestRun.create! options

    when Hobson::TestRun::Test.name

      options[:uuid] ||= Factory.test_uuid
      options[:job_index] ||= rand(5)
      Hobson::TestRun::Test.create! options

    when Hobson::TestRun::Job.name

      options[:index] ||= rand(5)
      options[:test_run] ||= Factory.create(Hobson::TestRun)
      Hobson::TestRun::Job.create! options

    when Hobson::TestRun::Job::Event.name
      options[:job] ||=  Factory.create(Hobson::TestRun::Job)
      options[:description] ||= ['enqueued', 'checking out code', 'preparing', 'running tests', 'tearing down'].sample
      options[:occurred_at] ||= Time.now
      event = Hobson::TestRun::Job::Event.create! options
      options[:job].events.add(event)
      event

    else
      raise "factory doesnt know how to create a #{model}"
    end
  end

end

