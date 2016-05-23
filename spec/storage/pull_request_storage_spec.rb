require "rails_helper"

RSpec.describe PullRequestStorage, type: :model do
  let(:pull_request) { create(:pull_request_storage) }

  describe "#to_h" do
    it "creates a hash of the object" do
      expect(pull_request.to_h).to be_a Hash
    end
  end
end
