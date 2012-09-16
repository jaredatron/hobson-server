require 'spec_helper'

describe '/projects/test_runs' do

  include ServerSupport

  let!(:project){
    Hobson::Project.create(origin: 'git://github.com/soveran/ohm.git')
  }

  # index
  describe "get /projects/test_runs" do

    def get!
      get "#{project_path(project)}/test_runs"
      response.should be_ok
      response.headers["Content-Type"].should == 'application/json;charset=utf-8'
    end

    context "when there are no test_runs" do
      let(:test_runs){ [] }

      it "should return an empty set" do
        get!
        JSON.parse(response.body).should == {"test_runs" => []}
      end
    end

    context "when there are 2 test_runs" do
      let!(:test_runs) do
        [
          Hobson::Project::TestRun.create(project: project, sha: 'a', requestor: 'me'),
          Hobson::Project::TestRun.create(project: project, sha: 'b', requestor: 'you'),
        ]
      end
      it "should return those 2 test_runs" do
        get!
        JSON.parse(response.body).should == {
          "test_runs" => [
            {'id' => '1', 'project_id' => '1', 'sha' => 'a', 'requestor' => 'me',  'created_at' => test_runs[0].created_at.to_s},
            {'id' => '2', 'project_id' => '1', 'sha' => 'b', 'requestor' => 'you', 'created_at' => test_runs[1].created_at.to_s},
          ]
        }
      end
    end

  end

  # create
  describe "post /projects" do
    context "when given a valid post body" do
      it "should work" do
        Hobson::Project::TestRun.all.size.should == 0
        post "#{project_path(project)}/test_runs", {
          "test_run" => {
            'sha' => 'abcd', 'requestor' => 'your mom',
          }
        }
        response.should be_ok
        response.body.should == ''
        Hobson::Project::TestRun.all.size.should == 1
        test_run = Hobson::Project::TestRun[1]
        test_run.sha.should == "abcd"
        test_run.requestor.should == "your mom"
      end
    end

  end

  # read
  describe "get /projects/:origin/test_runs/:id" do
    it "should work" do
      test_run = Hobson::Project::TestRun.create(project: project, sha: 'a', requestor: 'me')
      get "#{project_path(project)}/test_runs/1"
      response.should be_ok
      JSON.parse(response.body).should == {
        "id"=>"1", "project_id"=>"1", "sha"=>"a", "requestor"=>"me", "created_at"=> test_run.created_at.to_s
      }
    end
  end

  # delete
  describe "delete /projects/:origin" do
    it "should work" do
      test_run = Hobson::Project::TestRun.create(project: project, sha: 'a', requestor: 'me')
      get "#{project_path(project)}/test_runs/1"
      response.should be_ok
      delete "#{project_path(project)}/test_runs/1"
      response.should be_ok
      Hobson::Project::TestRun.all.size.should == 0

      delete "#{project_path(project)}/test_runs/1"
      response.should_not be_ok
    end
  end

end
