class Repository
  attr_reader :name

  def initialize(name: )
    @name = name
  end

  def self.all
    GithubRepository.all.map do |repo|
      new(name: repo.full_name)
    end
  end

  def ==(other)
    self.name == other.name
  end
end
