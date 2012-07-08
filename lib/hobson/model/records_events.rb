module Hobson::Model::RecordsEvents
  def record_event event_name
    events.add(Event.create(name:event_name, occurred_at:Time.now))
  end
end
