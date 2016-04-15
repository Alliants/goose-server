class GithubRepository
  attr_reader :full_name

  def initialize(full_name:)
    @full_name = full_name
  end

  def self.all
    # TODO: Right now the limit of 100 per page allow us to retrieve all the
    # repositories we have. I think a more elegant way embracing pagination
    # needs to be implemented.
    Octokit.organization_repositories("Alliants", per_page: 100).map do |repo|
      new(full_name: repo.full_name)
    end
  end

  def ==(other)
    self.full_name == other.full_name
  end
end
