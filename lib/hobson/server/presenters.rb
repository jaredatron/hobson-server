module Hobson::Server::Presenters

  class Base < OpenStruct

    def as_json options=nil
      @table
    end

  end

end

require 'hobson/server/presenters/test'
require 'hobson/server/presenters/project'
require 'hobson/server/presenters/test_run'
