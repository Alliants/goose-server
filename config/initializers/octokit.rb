Octokit.configure do |config|
  config.access_token = ENV["GITHUB_ACCESS_TOKEN"]
end

stack = Faraday::RackBuilder.new do |builder|
  builder.use Faraday::HttpCache, store: Rails.cache, serializer: Marshal
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end

Octokit.middleware = stack
