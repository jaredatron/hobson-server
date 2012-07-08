require 'spec_helper'

describe 'Flakey Spec' do

  it "should fail 60 percent of the time" do
    ExampleHobsonProject.sleep_and_log_for 10
    60.percent_of_the_time{ raise "something mysterious went wrong D=" }
  end

end
