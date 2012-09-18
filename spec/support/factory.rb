require "faker"

module Factory

  def self.create model, options={}

    case model.name
    when Hobson::Project.name

      options[:origin] ||= "git://github.com/#{Faker::Name.first_name}/#{Faker::Name.first_name}.git"
      Hobson::Project.create! options

    when Hobson::Project::Test.name

      options[:project] ||= Factory.create(Hobson::Project)
      options[:type] = %w(spec scenario).sample
      options[:name] =  Faker::Name.title
      Hobson::Project::Test.create! options

    when Hobson::Project::TestRun.name

      options[:project] ||= Factory.create(Hobson::Project)
      options[:sha] = rand(9999999999999999).to_s
      options[:requestor] =  "#{Faker::Name.first_name} #{Faker::Name.last_name}"
      Hobson::Project::TestRun.create! options

    else
      raise "unknown model #{model}"
    end
  end

end

