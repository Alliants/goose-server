require "rails_helper"

describe EventHandler do
  describe ".process" do
    it "creates an Event" do
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
      handler = Github::Webhook::PullRequestHandler.new(github_pr_data)

      expect do
        described_class.process(handler: handler)
      end.to change { EventRepository.new.count }.by(1)
    end
  end
end
