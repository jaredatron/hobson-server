module TestProjects

  def self.[] name
    TestProject.new name
  end

  class TestProject

    def initialize name
      @name = name
    end

    def path
      HOBSON_ROOT + :test + :projects + @name
    end

  end


end
