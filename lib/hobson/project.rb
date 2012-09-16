class Hobson::Project < Hobson::Model

  attribute :origin
  require 'hobson/project/test'
  collection :tests, :'::Hobson::Project::Test'

  index :origin

end


