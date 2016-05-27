require "rails_helper"

describe Github::Webhook do
  describe "when payload is a pull request" do
    describe "and the action is open" do
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
          described_class.call(payload: github_pr_data, type: "pull_request")
        end.to change { PullRequestRepository.new.count }.by(1)

        stored_pull_request = PullRequestStorage.find_by(original_id: 12_345)
        expect(stored_pull_request.number_of_comments).to eq(0)
      end
    end
  end
end
