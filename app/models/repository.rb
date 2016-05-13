class Repository
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def self.storage
    RepositoryStorage
  end

  def self.all(cache: true)
    storage_objects = if cache
                        storage.all
                      else
                        GithubRepository.all.map do |repo|
                          storage.create(name: repo.full_name)
                        end
    end

    storage_objects.map { |stored_repo| new(name: stored_repo.name) }
  end

  def ==(other)
    name == other.name
  end
end
