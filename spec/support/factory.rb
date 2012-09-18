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

    else
      raise "unknown model #{model}"
    end
  end

end

