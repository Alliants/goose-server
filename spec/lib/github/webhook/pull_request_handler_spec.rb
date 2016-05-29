require "rails_helper"

describe Github::Webhook::PullRequestHandler do
  describe "the action is open" do
    it "creates a new pull request" do
      github_pr_data = {
        action: "opened",
        pull_request: {
          html_url: "https://github.com/Alliants/goose-server/pull/9",
          title: "[WIP] Add github-webhooks endpoint",
          created_at: "2016-05-27T15:08:42Z",
          review_comments: 0,
          id: 12_345,
          user: {
            login: "guiman"
          },
          head: {
            user: {
              login: "Alliants"
            },
            repo: {
              full_name: "Alliants/goose-server"
            }
          }
        }
      }

      expect do
        described_class.new(github_pr_data).save
      end.to change { PullRequestRepository.new.count }.by(1)

      stored_pull_request = PullRequestStorage.find_by(original_id: 12_345)
      expect(stored_pull_request.number_of_comments).to eq(0)
    end
  end

  describe "the action is not open" do
    %w(assigned unassigned labeled unlabeled edited closed reopened synchronize).each do |action|
      it "should ignore the event #{action}" do
        github_pr_data = {
          action: action,
          pull_request: {
            html_url: "https://github.com/Alliants/goose-server/pull/9",
            title: "[WIP] Add github-webhooks endpoint",
            created_at: "2016-05-27T15:08:42Z",
            review_comments: 0,
            id: 12_345,
            user: {
              login: "guiman"
            },
            head: {
              user: {
                login: "Alliants"
              },
              repo: {
                full_name: "Alliants/goose-server"
              }
            }
          }
        }

        expect do
          described_class.new(github_pr_data).save
        end.to change { PullRequestRepository.new.count }.by(0)
      end
    end
  end
end
