ROOT = Pathname.new File.expand_path('../..', __FILE__)
LIB  = ROOT + 'lib'

require 'hobson/server'
require 'rack/test'

ROOT.join('spec/support').children.each{ |support| require support.to_s }

RSpec.configure do |config|

end
