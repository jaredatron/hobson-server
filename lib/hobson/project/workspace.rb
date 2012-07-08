class Hobson::Project::Workspace

  def initialize project
    @project = project
    @path = Hobson.workspace.projects_path + project.name
    @path.parent.mkpath unless @path.parent.exist?
  end
  attr_reader :project, :path

  def cloned?
    path.join('.git').directory?
  end

  def clone!
    `git clone #{project.origin.inspect} #{path.to_s.inspect}`
    $?.success? or raise "unable to clone project"
  end

  def checkout! sha
    clone! unless cloned?
  end

end


 # Hobson.workspace = Hobson::Workspace.new('/tmp/LOVEME')
 # p = Hobson::Project.find(name:'rails').first
 # w =  Hobson::Project::Workspace.new(p)
