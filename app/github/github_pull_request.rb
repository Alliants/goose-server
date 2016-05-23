class GithubPullRequest
  attr_reader :link, :title, :org, :repo, :created_at,
              :owner, :number_of_comments

  def initialize(args)
    @link = args.fetch(:link)
    @title = args.fetch(:title, "")
    @org = args.fetch(:org, "")
    @repo = args.fetch(:repo, "")
    @owner = args.fetch(:owner, "")
    @created_at = args.fetch(:created_at)
    @number_of_comments = args.fetch(:number_of_comments)
  end

  def self.fetch_all(repositories, status)
    repositories.flat_map do |repository|
      fetch(repository: repository.name, status: status)
    end
  end

  def self.fetch(repository:, status:)
    Octokit.pull_requests(repository, state: status.to_s).map do |pull_request|
      new(title: pull_request.title,
          link:  pull_request._links.html.href,
          repo: repository,
          org: repository.split("/").first,
          owner: pull_request.user.login,
          created_at: pull_request.created_at,
          number_of_comments: number_of_comments(pull_request))
    end
  end

  def ==(other)
    link == other.link
  end

  def to_h
    instance_variables.each_with_object({}) do |attribute, hash|
      clean_attribute_name       = attribute.to_s.gsub(/@/, "").to_sym
      hash[clean_attribute_name] = instance_variable_get(attribute)
    end
  end

  def self.number_of_comments(pull_request)
    # This will make another request to the github API
    pull_request.rels[:review_comments]
      .get
      .data
      .count
  end
end
