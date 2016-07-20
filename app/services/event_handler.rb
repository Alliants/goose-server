require "sprawl_integration/broadcaster"

class EventHandler
  def self.process(type:, action:, payload:, broadcast_event: false)
    event = EventRepository.new.create(
      event_type: type,
      action: action,
      payload: payload.to_json
    )

    SprawlIntegration::Broadcaster.fire(event: event) if broadcast_event
  end
end
