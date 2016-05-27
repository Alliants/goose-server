require "github/webhook/pull_request_handler"

module Github
  class Webhook
    TYPE_MAP = {
      "pull_request" => PullRequestHandler
    }.freeze

    def self.call(payload:, type:)
      handler = TYPE_MAP.fetch(type)

      handler.new(payload).save
    end
  end
end
