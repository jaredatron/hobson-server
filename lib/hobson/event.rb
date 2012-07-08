class Hobson::Event < Hobson::Model

  attribute :name
  attribute :occurred_at, ->(x){ Time === x ? x : Time.parse(x) }

end
