require 'spec_helper'

describe Hobson::Project do

  it "should work" do
    Hobson::Project.all.size.should == 0
    expected_project = Hobson::Project.create(origin: 'git://github.com/soveran/ohm.git')
    Hobson::Project.all.size.should == 1
    project = Hobson::Project[1]
    project.should == expected_project
    project.origin.should_not be_nil
    project.origin.should == expected_project.origin
    project.tests.should be_empty


    Hobson::Project::Test.create(
      project: project,
      type: 'spec',
      name: 'models/user_spec.rb',
    )

    test = Hobson::Project[1].tests.first
    test.project.should == project
    test.type.should == 'spec'
    test.name.should == 'models/user_spec.rb'
  end

end


