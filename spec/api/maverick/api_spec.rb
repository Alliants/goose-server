require 'rails_helper'

describe Maverick::API do
  describe "resource pull_requests" do
    describe "list" do
      it "returns a list of all the open pull requests in the org" do
        pull_request = PullRequest.new(link: "http://example.com", created_at: Time.now)

        allow(PullRequest).to receive(:where).with(status: :open).
          and_return([pull_request])
        expected_response = JSON.parse([pull_request].to_json)

        get "/api/pull_requests/list"
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to eq(expected_response)
      end
    end
  end
end
