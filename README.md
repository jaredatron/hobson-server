

    # project = Hobson::Project.create(origin: 'git@github.com/rails/rails')

    test_run = Hobson::TestRun.create!(project:'git@github.com/rails/rails', sha:'a', requestor:'me')
    test = Hobson::TestRun::Test.create!(test_run:test_run, uuid:'spec:ass_spec.rb', job_index:0)


File.open('/tmp/error.html','w'){|f| f.write(response.body) }; `open /tmp/error.html `


/projects
/projects/git@github.com%2Frails%2Frails
/projects/git@github.com%2Frails%2Frails/tests
/projects/git@github.com%2Frails%2Frails/test_runs
/projects/git@github.com%2Frails%2Frails/test_runs/tests


request test run

    POST /projects/git@github.com%2Frails%2Frails/test_runs
      {
        "sha": "12321321321321",
        "requestor": "Jared Grippe",
      }

    GET /projects/git@github.com%2Frails%2Frails/test_runs/1
      {
        "id": 1,
        "sha": "12321321321321",
        "requestor": "Jared Grippe",
      }

build test run

    PUT /projects/git@github.com%2Frails%2Frails/test_runs
      {
        "tests": [
          { "type": "spec", "name": "models/user_spec.rb" },
          { "type": "spec", "name": "models/post_spec.rb" },
          { "type": "scenario", "name": "I should be able to see my first post" },
          { "type": "scenario", "name": "I should be able to delete my first post" },
        ]
      }

    GET /projects/git@github.com%2Frails%2Frails/test_runs/1
      {
        "id": 1,
        "sha": "12321321321321",
        "requestor": "Jared Grippe",
        "tests": [
          { "id": 1, "status": "waiting", type": "spec", "name": "models/user_spec.rb" },
          { "id": 2, "status": "waiting", type": "spec", "name": "models/post_spec.rb" },
          { "id": 3, "status": "waiting", type": "scenario", "name": "I should be able to see my first post" },
          { "id": 4, "status": "waiting", type": "scenario", "name": "I should be able to delete my first post" },
        ]
      }

execute test run

    PUT /projects/git@github.com%2Frails%2Frails/test_runs/1/tests/1
      {
        "started_at": "2012-09-17 18:13:02 -0700",
      }

    PUT /projects/git@github.com%2Frails%2Frails/test_runs/1/tests/1
      {
        "completed_at": "2012-09-17 18:13:04 -0700",
        "result": "PASS",
      }


  PUT /projects/git@github.com%2Frails%2Frails/test_runs


