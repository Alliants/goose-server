class Repository
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def self.storage
    RepositoryStorage
  end

  def self.all(cache: true)
    storage_objects = cache ? cached_storage : new_storage

    storage_objects.map { |stored_repo| new(name: stored_repo.name) }
  end

  def ==(other)
    name == other.name
  end

  def self.cached_storage
    storage.all
  end
  private_class_method :cached_storage

  def self.new_storage
    GithubRepository.all.map do |repo|
      storage.create(name: repo.full_name)
    end
  end
  private_class_method :new_storage
end
