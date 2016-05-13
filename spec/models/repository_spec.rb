require "rails_helper"

describe Repository do
  describe ".all" do
    context "not using cache" do
      it "returns a list of all repositories" do
        mock_github_repository = OpenStruct.new(full_name: "test")
        allow(GithubRepository).to receive(:all).and_return([mock_github_repository])
        expected_collection = [Repository.new(name: "test")]
        expect(described_class.all(cache: false)).to eq(expected_collection)
        expect(described_class.storage.count).to eq(1)
      end
    end

    context "using cache" do
      it "is using caching by default" do
        described_class.storage.create(name: "test")
        expect(GithubRepository).to_not receive(:all)
        expected_collection = [Repository.new(name: "test")]
        expect(described_class.all).to eq(expected_collection)
      end

      it "returns a list of all repositories" do
        described_class.storage.create(name: "test")
        expect(GithubRepository).to_not receive(:all)
        expected_collection = [Repository.new(name: "test")]
        expect(described_class.all(cache: true)).to eq(expected_collection)
      end
    end
  end
end
