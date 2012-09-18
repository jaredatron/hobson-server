


test_run = Hobson::TestRun.create!(project_origin:'git@github.com/rails/rails', sha:'a', requestor:'me')


%w(spec scenario).each do |type|
  2.times do |job_index|
    10.times do
      Factory.create(Hobson::TestRun::Test,
        test_run:  test_run,
        uuid:      "#{type}:#{Faker::Name.title}",
        job_index: job_index
      )
    end
  end
end

puts test_run.as_json['path']
