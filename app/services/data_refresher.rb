class DataRefresher
  # TODO: This isn't hooked up yet, but it is used to refresh all data
  #
  #   dr = DataRefresher.new
  #   dr.refresh_all!
  #
  # It has implicit knowledge of all models at the minute, but should be
  # modified to inject these or inject the data required.

  attr_reader :source, :target

  def initialize(repositories: Repository.all)
    @source = GithubPullRequest
    @target = PullRequestRepository.new
    @repositories = repositories
  end

  def refresh_all!
    target.destroy_all

    target.store_each(source.fetch_all(@repositories, :open))
  end
end
