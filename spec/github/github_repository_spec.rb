require "rails_helper"

describe GithubRepository do
  describe ".all" do
    it "returns a list of all github repositories for alliants" do
      allow(Octokit).to receive(:organization_repositories)
        .with("Alliants", per_page: 100).and_return([
                                                      OpenStruct.new(full_name: "some/test")
                                                    ])

      expect(described_class.all).to eq([
                                          GithubRepository.new(full_name: "some/test")
                                        ])
    end
  end
end
