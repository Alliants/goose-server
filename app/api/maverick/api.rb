module Maverick
  class API < Grape::API
    version 'v1', using: :header, vendor: 'alliants'
    format :json
    prefix :api


    resources :pull_requests do
      desc 'List of all the open pull requests'
      get :list do
        PullRequest.where(status: :open)
      end
    end

    namespace :developer do
      resources :profile do
        desc 'Returns a developers github profile'
        params do
          requires :username, type: String, desc: 'Profile username'
        end
        get :github do
          DeveloperProfile.new(source: "github", username: params[:username]).information
        end
      end
    end
  end
end
