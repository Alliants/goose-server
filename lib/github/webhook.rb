require "github/webhook/pull_request_handler"
require "github/webhook/pull_request_review_comment_handler"

module Github
  class Webhook
    TYPE_MAP = {
      "pull_request" => PullRequestHandler,
      "pull_request_review_comment" => PullRequestReviewCommentHandler
    }.freeze

    def self.create_handler(payload:, type:)
      handler = TYPE_MAP.fetch(type)

      handler.new(payload)
    end
  end
end
