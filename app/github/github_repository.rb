class GithubRepository
  attr_reader :full_name

  def initialize(full_name:)
    @full_name = full_name
  end

  def self.all
    # Given we expect this collection to be relatively small, and also since the
    # docs suggest this mechanism in this situations, we will be using
    # auto_paginate in this case.
    Octokit.auto_paginate = true
    results = Octokit.organization_repositories("Alliants").map do |repo|
      new(full_name: repo.full_name)
    end
    Octokit.auto_paginate = false

    results
  end

  def ==(other)
    full_name == other.full_name
  end
end
