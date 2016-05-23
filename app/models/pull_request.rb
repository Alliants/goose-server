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

  def ==(other)
    link == other.link
  end
end
