module Github
  class Webhook
    class PullRequestReviewCommentHandler
      def initialize(payload)
        @payload = payload
      end

      def original_id
        payload[:pull_request][:id]
      end

      def action
        payload[:action]
      end

      def actor
        payload[:comment][:user][:login]
      end

      def comment_link
        payload[:comment][:html_url]
      end

      def pull_request_link
        payload[:pull_request][:html_url]
      end

      def as_json(_options = nil)
        {
          action: action,
          actor: actor,
          comment_link: comment_link,
          pull_request_link: pull_request_link
        }
      end

      def save
        pr_repository = PullRequestRepository.new
        pr = pr_repository.find_pull_request(original_id: original_id)

        if action == "created"
          pr.number_of_comments += 1
          pr_repository.persist(pr) ? pr : pr.number_of_comments -= 1
        end

        pr
      end

      def event_type
        "pull_request_review_comment"
      end

      private

      attr_reader :payload
    end
  end
end
