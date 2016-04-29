require 'rails_helper'

describe GithubPullRequest do
  describe ".fetch" do
    it "returns a list of github pull requests from the API" do
      some_date = DateTime.parse("1985/08/06 11:00:00") # May or may not be my birtday
      repository = "Alliants/some-repository"
      octokit_rels = double("octokit_relationships")
      allow(octokit_rels).to receive_message_chain(:[], :get, :data, :count).and_return(1)
      expected_collection = [
        GithubPullRequest.new(link: "http://github.com/org/repo/pr/1",
                        title: "Example",
                        org: "Alliants",
                        repo: "Project Maverick",
                        created_at: some_date,
                        owner: "some_owner",
                        number_of_comments: 1 )
      ]

      github_reponse = [
        OpenStruct.new(title: "Example",
                       _links: OpenStruct.new(html: OpenStruct.new(href: "http://github.com/org/repo/pr/1")),
                       user: OpenStruct.new(login: "some_owner"),
                       rels: octokit_rels,
                       created_at: some_date)
      ]

      expect(Octokit).to receive(:pull_requests).
        with(repository, { state: "open" }).and_return(github_reponse)
      expect(described_class.fetch(repository: repository, status: :open)).
        to eq(expected_collection)
    end
  end

  describe "#to_h" do
    it "transforms the instance information into hash format" do
      some_date = Date.today
      github_pull_request = GithubPullRequest.
        new(link: "http://github.com/org/repo/pr/1",
            title: "Example",
            org: "Alliants",
            repo: "Project Maverick",
            created_at: some_date,
            owner: "some_owner",
            number_of_comments: 1 )

      expect(github_pull_request.to_h).to eq({
        link: "http://github.com/org/repo/pr/1",
        title: "Example",
        org: "Alliants",
        repo: "Project Maverick",
        created_at: some_date,
        owner: "some_owner",
        number_of_comments: 1
      })
    end
  end
end
