require 'spec_helper'

describe Hobson::Project do

  it "should require a uniq name" do
    ->{
      2.times{
        Hobson::Project.create(
          name:  'rails',
          origin:'git://github.com/rails/rails.git'
        )
      }
    }.should raise_error Ohm::UniqueIndexViolation, 'name is not unique.'
  end

  it "should require a name" do
    project = Hobson::Project.new
    project.save.should be_false
    project.errors[:name].should include :not_present
  end

  it "should auto assign name from origin" do
    project = Hobson::Project.new(origin:'git://github.com/rails/rails.git')
    project.name.should == 'rails'

    project = Hobson::Project.new(origin:'/some/local/path/project/foobar')
    project.name.should == 'foobar'
  end

end
