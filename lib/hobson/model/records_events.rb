module Hobson::Model::RecordsEvents

  extend ActiveSupport::Concern

  included do
    set :events, :'Hobson::Event'
  end

  def record_event event_name
    events.add(Hobson::Event.create(name:event_name, occurred_at:Time.now))
  end

end
