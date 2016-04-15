module Maverick
  class API < Grape::API
    version 'v1', using: :header, vendor: 'alliants'
    format :json
    prefix :api


    resources :pull_requests do
      desc 'List of all the open pull requests'
      get do
        PullRequest.where(status: :open)
      end
    end
  end
end
