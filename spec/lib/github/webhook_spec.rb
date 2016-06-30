require "rails_helper"

describe Github::Webhook do
  describe "when payload is a pull request" do
    describe "and the action is open" do
      it "is handled by pull request handler" do
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

        allow(Github::Webhook::PullRequestHandler).to receive(:new)
          .with(github_pr_data).and_return(double("instance", save: true))

        described_class.create_handler(payload: github_pr_data, type: "pull_request")

        expect(Github::Webhook::PullRequestHandler).to have_received(:new).with(github_pr_data)
      end
    end
  end

  describe "when payload is a pull request comment" do
    describe "and the action is created" do
      it "is handled by pull request handler" do
        github_comment_data = {
          action: "created",
          pull_request: {
            id: 12_345
          }
        }

        allow(Github::Webhook::PullRequestReviewCommentHandler).to receive(:new)
          .with(github_comment_data).and_return(double("instance", save: true))

        described_class.create_handler(
          payload: github_comment_data,
          type: "pull_request_review_comment"
        )

        expect(Github::Webhook::PullRequestReviewCommentHandler)
          .to have_received(:new).with(github_comment_data)
      end
    end
  end

  describe "when payload is a repository" do
    describe "and the action is created" do
      it "is handled by the repository handler" do
        github_repository_data = {
          action: "created",
          repository: {
            full_name: "alliants/new-repository"
          }
        }

        allow(Github::Webhook::RepositoryHandler).to receive(:new)
          .with(github_repository_data).and_return(double("instance", save: true))

        described_class.create_handler(payload: github_repository_data, type: "repository")

        expect(Github::Webhook::RepositoryHandler)
          .to have_received(:new).with(github_repository_data)
      end
    end
  end
end
