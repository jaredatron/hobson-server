class Hobson::Project::Workspace

  def initialize project
    @project = project
    @path = Hobson.workspace.projects_path + project.name
    # @path.mkpath unless @path.exist?
  end

  def cloned?
    path.join('.git').directory?
  end

  def clone!
    `git clone #{project.origin.inspect} #{path.to_s.inspect}"`
    $?.success? or raise "unable to clone project"
  end

  def checkout! sha
    clone! unless cloned?
    execute
  end

end
