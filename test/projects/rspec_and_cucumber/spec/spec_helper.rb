require 'example_hobson_project'


class Fixnum
  def percent_of_the_time
    yield if rand(100) <= self
  end
end
