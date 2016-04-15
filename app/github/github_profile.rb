class GithubProfile

  REQUIRED_KEYS = [:login, :avatar_url, :name]

  def self.fetch(username)
    response = Octokit.user(username).to_hash
    response.select{|k,v| REQUIRED_KEYS.include?(k) }
  end
end
