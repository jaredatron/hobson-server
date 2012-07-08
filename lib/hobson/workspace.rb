class Hobson::Workspace

  def initialize path
    @path = Pathname.new File.expand_path path
    @projects_path = @path + 'projects'
    @projects_path.mkpath unless @projects_path.exist?
  end
  attr_reader :path, :projects_path

end
