ROOT = Pathname.new File.expand_path('../..', __FILE__)
LIB  = ROOT + 'lib'

ROOT.join('spec/support').children.each{ |support|
  require support.to_s
}

require 'hobson/server'

RSpec.configure do |config|


end
