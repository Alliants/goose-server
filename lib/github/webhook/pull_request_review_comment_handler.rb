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

      def save
        pr_repository = PullRequestRepository.new
        pr = pr_repository.find_pull_request(original_id: original_id)

        if action == "created"
          pr.number_of_comments += 1
          pr_repository.persist(pr) ? pr : pr.number_of_comments -= 1
        end

        pr
      end

      private

      attr_reader :payload
    end
  end
end