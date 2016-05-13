class Repository
  attr_reader :name

  def initialize(name: )
    @name = name
  end

  def self.storage
    RepositoryStorage
  end

  def self.all(cache: true)
    storage_objects = if cache
      self.storage.all
    else
      GithubRepository.all.map do |repo|
        self.storage.create(name: repo.full_name)
      end
    end

    storage_objects.map { |stored_repo| self.new(name: stored_repo.name) }
  end

  def ==(other)
    self.name == other.name
  end
end
