require 'spec_helper'

describe 'E' do

  it "should take 10 second to test" do
    ExampleHobsonProject.sleep_and_log_for 10
  end

end
