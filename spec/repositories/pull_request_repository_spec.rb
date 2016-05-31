require "rails_helper"

describe PullRequestRepository do
  describe "#find_open" do
    it "returns a list of stored pull requests" do
      create(:pull_request_storage)
      expect(subject.find_open.size).to be 1
    end
  end

  describe "#store each" do
    it "stores a github pull request" do
      source_data = [build(:github_pull_request)]
      expect { subject.store_each(source_data) }.to change { PullRequestStorage.count }.by 1
    end
  end

  describe "#count" do
    it "stores a github pull request" do
      create(:pull_request_storage)
      expect(subject.count).to be 1
    end
  end
end
