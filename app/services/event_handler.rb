class EventHandler
  def self.process(handler:)
    EventRepository.new.create(
      event_type: handler.event_type,
      action: handler.action,
      payload: handler.to_json
    )
  end
end
