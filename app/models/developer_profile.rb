class DeveloperProfile

  def initialize(args)
    @source = args.fetch(:source)
    @username = args.fetch(:username)
  end

  def information
    return github_information if @source == 'github'
  end

  private

  def github_information
    GithubProfile.fetch(@username)
  end
end
