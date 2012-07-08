module TestWorkspace

  ROOT = Pathname.new File.expand_path('../../../tmp/workspace', __FILE__)

  def self.reset!
    ROOT.rmtree if ROOT.exist?
    ROOT.join('projects').mkpath
  end

end
