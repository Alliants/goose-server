require "sprawl_integration/broadcaster"

class EventHandler
  def self.process(handler:, broadcast_event: false)
    event = EventRepository.new.create(
      event_type: handler.event_type,
      action: handler.action,
      payload: handler.to_json
    )

    SprawlIntegration::Broadcaster.fire(event: event) if broadcast_event
  end
end
