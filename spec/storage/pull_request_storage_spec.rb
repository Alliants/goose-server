require "rails_helper"

RSpec.describe PullRequestStorage, type: :model do
  let(:pull_request) { create(:pull_request_storage) }

  describe "#to_h" do
    it "creates a hash of the object" do
      expect(pull_request.to_h).to be_a Hash
    end
  end

  describe "uniqueness" do
    it "can't create two pull requests with equal original_id" do
      create(:pull_request_storage, original_id: 1)
      expect do
        create(:pull_request_storage, original_id: 1)
      end.to raise_exception(ActiveRecord::RecordNotUnique)
    end

    it "can't create two pull requests with equal link" do
      create(:pull_request_storage, link: "http://some.link")
      expect do
        create(:pull_request_storage, link: "http://some.link")
      end.to raise_exception(ActiveRecord::RecordNotUnique)
    end
  end
end
