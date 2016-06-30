class RepositoryRepository
  DEFAULT_ADAPTER = RepositoryStorage

  attr_reader :store

  def initialize
    @store = DEFAULT_ADAPTER
  end

  delegate :destroy_all, :create, :count, :destroy, :find_by, to: :store
end
