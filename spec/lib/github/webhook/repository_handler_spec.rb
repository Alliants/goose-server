require "rails_helper"

describe Github::Webhook::RepositoryHandler do
  describe "the action is created" do
    it "creates a new repository" do
      github_repository_data = {
        action: "created",
        repository: {
          full_name: "alliants/new-repository"
        }
      }

      expect do
        described_class.new(github_repository_data).save
      end.to change { RepositoryRepository.new.count }.by(1)
    end
  end

  describe "the action is deleted" do
    it "deletes repository" do
      repo_name = "alliants/repository"
      FactoryGirl.create(:repository_storage, name: repo_name)
      github_repository_data = {
        action: "deleted",
        repository: {
          full_name: repo_name
        }
      }

      expect do
        described_class.new(github_repository_data).save
      end.to change { RepositoryRepository.new.count }.by(-1)
    end
  end

  describe "other actions" do
    %w(publicized privatized).each do |action|
      it "should ignore the event #{action}" do
        github_repository_data = {
          action: action,
          repository: {
            full_name: "alliants/new-repository"
          }
        }

        expect do
          described_class.new(github_repository_data).save
        end.to change { RepositoryRepository.new.count }.by(0)
      end
    end
  end
end
