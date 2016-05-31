module Github
  class Webhook
    class PullRequestHandler
      def initialize(payload)
        @payload = payload.symbolize_keys
      end

      def link
        payload[:pull_request][:html_link]
      end

      def title
        payload[:pull_request][:title]
      end

      def organization
        payload[:pull_request][:head][:user][:login]
      end

      def repository
        payload[:pull_request][:head][:repo][:full_name]
      end

      def owner
        payload[:pull_request][:user][:login]
      end

      def created_at
        payload[:pull_request][:created_at]
      end

      def original_id
        payload[:pull_request][:id]
      end

      def number_of_comments
        payload[:pull_request][:review_comments]
      end

      def action
        payload[:action]
      end

      def save
        if action == "opened"
          PullRequestStorage.create(link: link, title: title, org: organization,
                                    repo: repository,
                                    owner: owner,
                                    created_at: created_at,
                                    original_id: original_id,
                                    number_of_comments: number_of_comments)
        end
      end

      private

      attr_reader :payload
    end
  end
end
