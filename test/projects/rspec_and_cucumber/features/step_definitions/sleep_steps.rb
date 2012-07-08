Then /^this scenario took (\d+) seconds? to run$/ do |n|
  ExampleHobsonProject.sleep_and_log_for n
end
