require 'rails_helper'

describe Maverick::API do
  describe "resource pull_requests" do
    describe "index" do
      it "returns a list of all the open pull requests in the org" do
        creation_time = DateTime.parse("1985/08/06 11:00:00")
        pull_request = PullRequest.new(link: "http://example.com", created_at: creation_time, number_of_comments: 5)
        repositories = [Repository.new(name: "some/repository")]

        expect(Repository).to receive(:all).and_return(repositories)
        expect(PullRequest).to receive(:where).with(status: :open, repositories: repositories).
          and_return([pull_request])

        expected_response = [{
          "link"=>"http://example.com",
          "title"=>"",
          "org"=>"",
          "repo"=>"",
          "owner"=>"",
          "created_at"=>"1985-08-06T11:00:00.000+00:00",
          "number_of_comments" => 5
        }]

        get "/api/pull-requests"
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to eq(expected_response)
      end
    end
  end

  describe "resource repositories" do
    describe "index" do
      it "returns a list of all the organization repositories" do
        allow(Repository).to receive(:all).and_return([
          Repository.new(name: "some/test")
        ])

        get "/api/repositories"

        parsed_body = JSON.parse(response.body)
        expected_response = [{"name" => "some/test"}]

        expect(parsed_body).to eq(expected_response)
      end
    end
  end
end
