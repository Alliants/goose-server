require "rails_helper"

describe DataRefresher do
  let(:repositories) { [Repository.new(name: "some/repo")] }
  let(:github_pull_requests) { [FactoryGirl.build(:github_pull_request)] }

  it "updates pull requests" do
    allow(GithubPullRequest).to receive(:fetch_all).with(repositories, :open)
      .and_return(github_pull_requests)

    expect do
      described_class.new(repositories: repositories).refresh_all!
    end.to change { PullRequestStorage.all.count }.by(1)
  end

  it "won't create duplicate entries when executing multiple times" do
    allow(GithubPullRequest).to receive(:fetch_all).with(repositories, :open)
      .and_return(github_pull_requests)

    described_class.new(repositories: repositories).refresh_all!
    described_class.new(repositories: repositories).refresh_all!

    expect(PullRequestRepository.new.count).to eq(1)
  end
end
