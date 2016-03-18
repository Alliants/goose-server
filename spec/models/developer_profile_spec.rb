require 'rails_helper'

describe DeveloperProfile do
  describe "#information" do
    it "returns the profile information" do
      name = "Christopher Ward"
      username = "wardymate"
      avatar_url = "https://avatars.githubusercontent.com/u/6054003?v=3"
      developer = DeveloperProfile.new(source: "github", username: username)
      expect(developer.information[:login]).to eq username
      expect(developer.information[:name]).to eq name
      expect(developer.information[:avatar_url]).to eq avatar_url
    end
  end
end
