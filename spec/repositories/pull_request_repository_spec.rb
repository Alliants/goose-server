require "rails_helper"

describe PullRequestRepository do
  let(:repository) { PullRequestRepository }

  before do
    create(:pull_request_storage)
  end

  describe "#find_open" do
    it "returns a list of stored pull requests" do
      expect(subject.find_open.size).to be 1
    end
  end
end
