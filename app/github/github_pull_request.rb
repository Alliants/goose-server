class GithubPullRequest
  attr_reader :link, :title, :org, :repo, :created_at, :owner

  def initialize(args)
    @link = args.fetch(:link)
    @title = args.fetch(:title, '')
    @org = args.fetch(:org, '')
    @repo = args.fetch(:repo, '')
    @owner = args.fetch(:owner, '')
    @created_at = args.fetch(:created_at)
  end

  def self.fetch(repository: , status:)
    Octokit.configure do |config|
      config.access_token = ENV["GITHUB_ACCESS_TOKEN"]
    end

    Octokit.pull_requests(repository, state: status.to_s).map do |pull_request|
      new(title: pull_request.title,
          link:  pull_request._links.html.href,
          repo: repository,
          org: repository.split('/').first,
          owner: pull_request.user.login,
          created_at: pull_request.created_at)
    end
  end

  def ==(other_pr)
    self.link == other_pr.link
  end
end
