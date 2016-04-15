require 'rails_helper'

describe Repository do
  describe ".all" do
    it "returns a list of all repositories" do
      mock_github_repository = OpenStruct.new(full_name: "test")
      allow(GithubRepository).to receive(:all).and_return([mock_github_repository])
      expected_collection = [Repository.new(name: "test")]
      expect(described_class.all).to eq(expected_collection)
    end
  end
end
