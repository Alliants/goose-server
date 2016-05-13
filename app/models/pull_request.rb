class PullRequest
  attr_reader :link, :title, :org, :repo, :created_at, :owner

  def initialize(args)
    @link = args.fetch(:link)
    @title = args.fetch(:title, '')
    @org = args.fetch(:org, '')
    @repo = args.fetch(:repo, '')
    @owner = args.fetch(:owner, '')
    @created_at = args.fetch(:created_at)
    @number_of_comments = args.fetch(:number_of_comments)
  end

  def self.storage
    PullRequestStorage
  end

  def self.where(status:, repositories:, cache: true)
    storage_objects = if cache
      repository_names = repositories.map(&:name)
      self.storage.where(repo: repository_names)
    else
      repositories.map do |repository|
        GithubPullRequest.fetch(repository: repository.name, status: status)
      end.flatten.map { |github_pr| self.storage.create(github_pr.to_h) }
    end

    storage_objects.map { |stored_pr| to_pull_request(stored_pr) }
  end

  def self.to_pull_request(data)
    new(data.to_h)
  end

  def ==(other_pr)
    self.link == other_pr.link
  end
end
