require 'spec_helper'

describe Hobson::Project::Test do

  it "should use it uniq on name and id" do
    project = Hobson::Project.create(origin:'git://github.com/rails/rails.git')
    ->{
      2.times{
        test = Hobson::Project::Test.create(
          project: project,
          uid:    'spec:spec/user_spec.rb'
        )
        test.save
      }
    }.should raise_error Ohm::UniqueIndexViolation, 'uid is not unique.'
  end

end
