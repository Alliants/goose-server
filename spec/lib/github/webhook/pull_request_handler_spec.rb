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

  describe "the action is close" do
    it "creates a new pull request" do
      create(:pull_request_storage, original_id: 12_345)

      github_pr_data = {
        action: "closed",
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
      end.to change { PullRequestRepository.new.count }.by(-1)
    end
  end

  describe "other actions" do
    %w(assigned unassigned labeled unlabeled edited reopened synchronize).each do |action|
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

  describe "as_json" do
    specify do
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

      expected_json = {
        link: github_pr_data.dig(:pull_request, :html_url),
        title: github_pr_data.dig(:pull_request, :title),
        organization: github_pr_data.dig(:pull_request, :head, :user, :login),
        repository: github_pr_data.dig(:pull_request, :head, :repo, :full_name),
        owner: github_pr_data.dig(:pull_request, :user, :login),
        original_id: github_pr_data.dig(:pull_request, :id),
        created_at: github_pr_data.dig(:pull_request, :created_at),
        number_of_comments: github_pr_data.dig(:pull_request, :review_comments),
        action: github_pr_data.fetch(:action)
      }

      expect(described_class.new(github_pr_data).as_json).to eq(expected_json)
    end
  end
end
