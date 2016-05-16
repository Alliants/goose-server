require "rails_helper"

describe PullRequest do
  describe ".where" do
    context "not using cache" do
      it "returns a list of pull requests" do
        some_date = DateTime.parse("1985/08/06 11:00:00").in_time_zone
        available_repositories = [Repository.new(name: "some/repository")]
        expected_collection = [
          PullRequest.new(link: "http://example.com",
                          title: "Example",
                          org: "Alliants",
                          repo: "some/repository",
                          created_at: some_date,
                          owner: "some_owner",
                          number_of_comments: 5)
        ]

        allow(GithubPullRequest).to receive(:fetch)
          .with(repository: "some/repository", status: :open)
          .and_return([
                        GithubPullRequest.new(link: "http://example.com",
                                              created_at: Time.zone.now,
                                              number_of_comments: 5)
                      ])

        expect(described_class
          .where(status: :open,
                 repositories: available_repositories,
                 cache: false))
          .to eq(expected_collection)
        expect(described_class.storage.count).to eq(1)
      end
    end

    context "using cache" do
      it "is using caching by default" do
        some_date = DateTime.parse("1985/08/06 11:00:00").in_time_zone
        available_repositories = [Repository.new(name: "some/repository")]
        PullRequestStorage.create(
          link: "http://example.com",
          title: "Example",
          org: "Alliants",
          repo: "some/repository",
          created_at: some_date,
          owner: "some_owner",
          number_of_comments: 5
        )

        expected_collection = [
          PullRequest.new(link: "http://example.com",
                          title: "Example",
                          org: "Alliants",
                          repo: "Project Maverick",
                          created_at: some_date,
                          owner: "some_owner",
                          number_of_comments: 5)
        ]

        expect(GithubPullRequest).to_not receive(:fetch)
          .with(repository: "some/repository", status: :open)

        expect(described_class
            .where(status: :open,
                   repositories: available_repositories))
          .to eq(expected_collection)
      end

      it "returns a list of pull requests" do
        some_date = DateTime.parse("1985/08/06 11:00:00").in_time_zone
        available_repositories = [Repository.new(name: "some/repository")]
        PullRequestStorage.create(
          link: "http://example.com",
          title: "Example",
          org: "Alliants",
          repo: "some/repository",
          created_at: some_date,
          owner: "some_owner",
          number_of_comments: 5
        )

        expected_collection = [
          PullRequest.new(link: "http://example.com",
                          title: "Example",
                          org: "Alliants",
                          repo: "Project Maverick",
                          created_at: some_date,
                          owner: "some_owner",
                          number_of_comments: 5)
        ]

        expect(GithubPullRequest).to_not receive(:fetch)
          .with(repository: "some/repository", status: :open)

        expect(described_class
            .where(status: :open,
                   repositories: available_repositories,
                   cache: true))
          .to eq(expected_collection)
      end
    end
  end
end
