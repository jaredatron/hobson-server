require 'popen4'

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

  def rvm?
    path.join('.rvmrc').exist?
  end

  def bundler?
    path.join('Gemfile').exist?
  end

  def rvm_source_file
    File.expand_path('~/.rvm/scripts/rvm')
  end


  def clone!
    result = system %{git clone #{project.origin.inspect} #{path.to_s.inspect}}
    $?.success? or raise "unable to clone project\n#{result}"
  end

  def checkout! sha
    clone! unless cloned?
    execute "git fetch --all && git checkout --quiet --force #{sha} --"
    bundle_install! if bundler?
  end

  def bundle_install!
    execute 'bundle check || bundle install'
  end




  def execute command
    command = "cd #{path.to_s.inspect} && #{command}"
    command = "source #{rvm_source_file.inspect} && rvm rvmrc trust #{path.to_s.inspect} > /dev/null && #{command}" if rvm?
    command = "bash -lc #{command.inspect}"

    Bundler.with_clean_env{
      output = nil
      errors = nil
      status = POpen4::popen4(command){|stdout, stderr, stdin|
        output = stdout.read
        errors = stderr.read
      }
      # output.split("\n").each{|line| logger.debug line}
      # errors.split("\n").each{|line| logger.error line}
      raise ExecutionError, "COMMAND FAILED TO START\n#{command}" if status.nil?
      raise ExecutionError, "COMMAND EXITED WITH CODE #{$?.exitstatus}\n#{command}\n\n#{errors}" unless $?.success?
      return output
    }
  end

end


 # Hobson.workspace = Hobson::Workspace.new('/tmp/LOVEME')
 # p = Hobson::Project.find(name:'rails').first
 # w =  Hobson::Project::Workspace.new(p)
