require 'logger'

module ExampleHobsonProject

  extend self

  def root
    @root ||= Pathname.new File.expand_path('../..', __FILE__)
  end

  def logger
    @logger ||= begin
      root.join('log').mkpath
      Logger.new(root.join('log/app.log'))
    end
  end

  def sleep_and_log_for n
    n.to_i.times do
      logger.info "sleeping for 1 second"
      sleep 1
    end
  end

end

sleep 5 # simulate a slow app starting
