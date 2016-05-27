module Github
  class Webhook
    class PullRequestHandler
      def self.parse(payload)
        PullRequestStorage.create(
          link: payload[:pull_request][:html_link],
          title: payload[:pull_request][:title],
          org: payload[:pull_request][:head][:user][:login],
          repo: payload[:pull_request][:head][:repo][:full_name],
          owner: payload[:pull_request][:user][:login],
          created_at: payload[:pull_request][:created_at],
          original_id: payload[:pull_request][:id],
          number_of_comments: payload[:pull_request][:review_comments]
        )
      end
    end

    TYPE_MAP = {
      "pull_request" => PullRequestHandler
    }.freeze

    def self.call(payload:, type:)
      handler = TYPE_MAP.fetch(type)

      handler.parse(payload)
    end
  end
end
