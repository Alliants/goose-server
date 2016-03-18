require 'rails_helper'

describe Maverick::API do
  describe "resource pull_requests" do
    describe "list" do
      it "returns a list of all the open pull requests in the org" do
        pull_request = PullRequest.new(link: "http://example.com", created_at: Time.now)

        allow(PullRequest).to receive(:where).with(status: :open).
          and_return([pull_request])
        expected_response = JSON.parse([pull_request].to_json)

        get "/api/pull_requests/list"

        expect(parsed_body).to eq(expected_response)
      end
    end
  end
  describe "resource developer" do
    describe "profile" do
      it "returns the developer's profile information" do
        name = "Christopher Ward"
        username = "wardymate"
        avatar_url = "https://avatars.githubusercontent.com/u/6054003?v=3"
        github_user = DeveloperProfile.new(source: "github", username: username)
        expected_response = {
          login: username,
          name: name,
          avatar_url: avatar_url
        }

        allow(github_user).to receive(:information).and_return(expected_response)

        get "/api/developer/profile/github", username: username

        expect(parsed_body).to eq(expected_response.as_json)
      end
    end
  end
end
