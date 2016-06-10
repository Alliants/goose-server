class EventRepository
  DEFAULT_ADAPTER = EventStorage

  attr_reader :store

  def initialize
    @store = DEFAULT_ADAPTER
  end

  def count
    store.all.count
  end

  delegate :destroy_all, :create, to: :store
end
