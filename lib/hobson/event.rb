class Hobson::Event < Hobson::Model

  attribute :name
  attribute :occurred_at #, ->(x){ Time.parse(x) }

end
