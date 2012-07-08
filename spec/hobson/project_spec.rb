require 'spec_helper'

describe Hobson::Project do

  it "should require a uniq name" do
    ->{
      2.times{
        Hobson::Project.create(origin:'git://github.com/rails/rails.git')
      }
    }.should raise_error Ohm::UniqueIndexViolation, 'name is not unique.'
  end

end
