class PullRequest
  attr_reader :link, :title, :org, :repo, :created_at, :owner

  def initialize(args)
    @link = args.fetch(:link)
    @title = args.fetch(:title, '')
    @org = args.fetch(:org, '')
    @repo = args.fetch(:repo, '')
    @owner = args.fetch(:owner, '')
    @created_at = args.fetch(:created_at)
  end

  def self.where(status:)
    GithubPullRequest.fetch(repository: "Alliants/fs-residential", status: status)
  end

  def ==(other_pr)
    self.link == other_pr.link
  end
end
