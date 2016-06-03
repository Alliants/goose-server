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

  describe "#find_pull_request" do
    it "retrieves the correct pull request using github data" do
      stored_pr = create(:pull_request_storage,
                         original_id: 1,
                         link: "something")
      pull_request = PullRequest.new(stored_pr.to_h)

      github_pr = build(:github_pull_request,
                        original_id: 1, link: "something")

      expect(
        subject.find_pull_request(original_id: github_pr.original_id)
      ).to eq(pull_request)
    end
  end
end
