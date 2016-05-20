module Maverick
  class API < Grape::API
    version "v1", using: :header, vendor: "alliants"
    format :json
    prefix :api

    resources :"pull-requests" do
      desc "List of all the open pull requests"
      get do
        pull_request_source = PullRequestRepository.new

        pull_request_source.find_open
      end
    end

    resources :repositories do
      desc "List of all the organization repositories"
      get do
        Repository.all
      end
    end
  end
end
