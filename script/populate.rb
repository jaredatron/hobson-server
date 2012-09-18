


test_run = Hobson::TestRun.create!(project_origin:'git@github.com/rails/rails', sha:'a', requestor:'me')


%w(spec scenario).each do |type|
  4.times do |job_index|

    job = Factory.create(Hobson::TestRun::Job,
      test_run: test_run,
      index: job_index,
    )

    5.times do
      Factory.create(Hobson::TestRun::Test,
        test_run:  test_run,
        uuid:      "#{type}:#{Faker::Name.title}",
        job_index: job_index
      )
    end

    ['enqueued', 'checking out code', 'preparing', 'running tests', 'tearing down'].each do |description|
      Factory.create(Hobson::TestRun::Job::Event,
        :job => job,
        :description => description,
        :occurred_at => Time.now,
      )
    end



  end
end

puts test_run.as_json['path']
