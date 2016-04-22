require 'rails_helper'

describe PullRequest do
  describe ".where" do
    it "returns a list of pull requests" do
      some_date = DateTime.parse("1985/08/06 11:00:00") # May or may not be my birtday
      expected_collection = [
        PullRequest.new(link: "http://example.com",
                        title: "Example",
                        org: "Alliants",
                        repo: "Project Maverick",
                        created_at: some_date,
                        owner: "some_owner")
      ]
      allow(GithubPullRequest).to receive(:fetch).
        with(repository: "Alliants/fs-residential", status: :open).
        and_return([
          GithubPullRequest.new(link: "http://example.com", created_at: Time.now)
        ])
      expect(described_class.where(status: :open)).to eq(expected_collection)
    end
  end
end