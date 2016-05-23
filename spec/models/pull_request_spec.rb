require "rails_helper"

describe PullRequest do
  let(:old_request) do
    PullRequest.new(
      link: "identical",
      created_at: Time.zone.now,
      number_of_comments: 0
    )
  end

  let(:new_request) do
    PullRequest.new(
      link: "identical",
      created_at: Time.zone.now,
      number_of_comments: 100
    )
  end

  let(:different_request) do
    PullRequest.new(
      link: "different",
      created_at: Time.zone.now,
      number_of_comments: 100
    )
  end

  describe "equality" do
    it "identifies with the same linked object" do
      expect(old_request).to eq new_request
    end

    it "does not equal an object with a different link" do
      expect(old_request).to_not eq different_request
    end
  end
end
