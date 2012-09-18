require 'spec_helper'

describe Hobson::Project do

  it_should_behave_like "a model"

  it "should work" do
    Hobson::Project.all.size.should == 0
    expected_project = Hobson::Project.create(origin: 'git://github.com/soveran/ohm.git')
    Hobson::Project.all.size.should == 1
    project = Hobson::Project[1]
    project.should == expected_project
    project.origin.should_not be_nil
    project.origin.should == expected_project.origin
    project.tests.should be_empty
  end

end


