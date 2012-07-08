require 'spec_helper'

describe 'C' do

  it "should take 1 second to test" do
    ExampleHobsonProject.sleep_and_log_for 1
  end

end
