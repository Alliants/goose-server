require "rails_helper"

describe Github::Webhook::PullRequestReviewCommentHandler do
  context "a comment is created" do
    it "adds a comment to the existing count of the PR" do
      pull_request = PullRequestStorage.create(original_id: 12_345, number_of_comments: 0)
      github_pr_data = {
        action: "created",
        comment: {
          user: {
            login: "someuser"
          }
        },
        pull_request: {
          id: 12_345
        }
      }

      saved_pr = described_class.new(github_pr_data).save
      expect(saved_pr.number_of_comments).to eq(pull_request.number_of_comments + 1)
    end
  end

  context "other comment events" do
    %w(edited deleted).each do |action|
      it "ignores action #{action}" do
        pull_request = PullRequestStorage.create(original_id: 12_345, number_of_comments: 0)
        github_pr_data = {
          action: action,
          comment: {
            user: {
              login: "someuser"
            }
          },
          pull_request: {
            id: 12_345
          }
        }

        saved_pr = described_class.new(github_pr_data).save
        expect(saved_pr.number_of_comments).to eq(pull_request.number_of_comments)
      end
    end
  end
end
