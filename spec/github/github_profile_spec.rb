require 'rails_helper'

describe GithubProfile do
  describe ".fetch" do
    it "returns attributes for a github User" do
      name = "Christopher Ward"
      username = "wardymate"
      avatar_url = "https://avatars.githubusercontent.com/u/6054003?v=3"
      expected_response = {
        login: username,
        name: name,
        avatar_url: avatar_url
      }
      github_response = double("Sawyer::Resource", to_hash: expected_response)

      expect(Octokit).to receive(:user).with(username).and_return(github_response)
      expect(GithubProfile.fetch(username)).
        to eq(expected_response)
    end
  end
end
