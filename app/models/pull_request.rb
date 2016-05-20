class PullRequest
  attr_reader :link, :title, :org, :repo, :created_at, :owner

  def initialize(args)
    @link = args.fetch(:link)
    @title = args.fetch(:title, "")
    @org = args.fetch(:org, "")
    @repo = args.fetch(:repo, "")
    @owner = args.fetch(:owner, "")
    @created_at = args.fetch(:created_at)
    @number_of_comments = args.fetch(:number_of_comments)
  end

  def self.storage
    PullRequestStorage
  end

  def self.where(status:, repositories:, cache: true)
    # depreciated
    storage_objects = cache ? cached_storage(repositories) : new_storage(repositories, status)

    storage_objects.map(&to_new_pull_request)
  end

  def ==(other)
    # depreciated
    link == other.link
  end

  def self.new_storage(repositories, status)
    # depreciated
    fetch_repositories(repositories, status).map(&to_stored_pull_request)
  end
  private_class_method :new_storage

  def self.cached_storage(repositories)
    # depreciated
    repository_names = repositories.map(&:name)
    storage.where(repo: repository_names)
  end
  private_class_method :cached_storage

  def self.fetch_repositories(repositories, status)
    # depreciated
    repositories.flat_map do |repository|
      GithubPullRequest.fetch(repository: repository.name, status: status)
    end
  end

  def self.to_new_pull_request
    # depreciated
    ->(pr) { new(pr.to_h) }
  end

  def self.to_stored_pull_request
    # depreciated
    ->(pr) { storage.create(pr.to_h) }
  end
end
