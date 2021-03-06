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
        "closed" => CloseAction,
        "merged" => CloseAction
      }.freeze

      def initialize(payload)
        @payload = payload
      end

      def event_type
        "pull_request"
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

      def merged
        payload[:pull_request][:merged].to_s == "true"
      end

      def action
        if payload[:action] == "closed" && merged
          "merged"
        else
          payload[:action]
        end
      end

      def as_json(_options = nil)
        {
          link: link, title: title,
          organization: organization,
          repository: repository,
          owner: owner,
          original_id: original_id,
          created_at: created_at,
          number_of_comments: number_of_comments,
          action: action
        }
      end

      def save
        TRANSITION_MAP.fetch(action, NonExistingAction).execute(self)
      end

      private

      attr_reader :payload
    end
  end
end
