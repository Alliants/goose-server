module Github
  class Webhook
    class PullRequestHandler
      class OpenAction
        def self.execute(handler)
          PullRequestRepository.new.create(link: handler.link,
                                           title: handler.title,
                                           org: handler.organization,
                                           repo: handler.repository,
                                           owner: handler.owner,
                                           created_at: handler.created_at,
                                           original_id: handler.original_id,
                                           number_of_comments: handler.number_of_comments)
        end
      end

      class CloseAction
        def self.execute(handler)
          PullRequestRepository.new.delete(original_id: handler.original_id)
        end
      end

      class NonExistingAction
        def self.execute(_handler)
          # do nothing
        end
      end

      TRANSITION_MAP = {
        "opened" => OpenAction,
        "closed" => CloseAction
      }.freeze

      def initialize(payload)
        @payload = payload
      end

      def link
        payload[:pull_request][:html_url]
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
        TRANSITION_MAP.fetch(action, NonExistingAction).execute(self)
      end

      private

      attr_reader :payload
    end
  end
end
