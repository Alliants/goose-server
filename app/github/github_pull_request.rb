class GithubPullRequest
  attr_reader :link, :title, :org, :repo, :created_at,
              :owner, :number_of_comments

  def initialize(args)
    @link = args.fetch(:link)
    @title = args.fetch(:title, '')
    @org = args.fetch(:org, '')
    @repo = args.fetch(:repo, '')
    @owner = args.fetch(:owner, '')
    @created_at = args.fetch(:created_at)
    @number_of_comments = args.fetch(:number_of_comments)
  end

  def self.fetch(repository: , status:)
    Octokit.pull_requests(repository, state: status.to_s).map do |pull_request|
      new(title: pull_request.title,
          link:  pull_request._links.html.href,
          repo: repository,
          org: repository.split('/').first,
          owner: pull_request.user.login,
          created_at: pull_request.created_at,
          number_of_comments: pull_request.rels[:review_comments].get.data.count) #this will make another request to the github API
    end
  end

  def ==(other_pr)
    self.link == other_pr.link
  end

  def to_h
    self.instance_variables.inject({}) do |acc,attribute|
      clean_attribute_name = attribute.to_s.gsub(/@/, '').to_sym
      acc[clean_attribute_name] = self.instance_variable_get(attribute)
      acc
    end
  end
end
