module Hobson::Server::Controller

  def self.new &block
    controller = Module.new
    controller.define_singleton_method(:to_proc){ block }
    return controller
  end

end
