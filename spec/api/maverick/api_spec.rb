require "rails_helper"

describe Maverick::API do
  describe "resource pull_requests" do
    let(:creation_time) { Time.zone.parse("1985/08/06 11:00:00") }
    let(:pull_request)  { create(:pull_request_storage, created_at: creation_time) }

    let(:expected_response) do
      [{
        "link" => "http://example.com",
        "original_id" => 12_345,
        "title" => "Example",
        "org" => "Alliants",
        "repo" => "some/repository",
        "owner" => "some_owner",
        "created_at" => "1985-08-06T11:00:00.000Z",
        "number_of_comments" => 5
      }]
    end

    describe "#index" do
      it "returns a list of all the open pull requests in the org" do
        pull_request

        get "/api/pull-requests"

        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to eq(expected_response)
      end
    end
  end

  describe "resource repositories" do
    describe "index" do
      it "returns a list of all the organization repositories" do
        allow(Repository)
          .to receive(:all)
          .and_return([Repository.new(name: "some/test")])

        get "/api/repositories"

        parsed_body = JSON.parse(response.body)
        expected_response = [{ "name" => "some/test" }]

        expect(parsed_body).to eq(expected_response)
      end
    end
  end

  describe "Github Webhook updates" do
    describe "post" do
      it "recieves an update from github" do
        webhook_handler = double("Webhook Handler")
        event_information = {
          foo: "bar"
        }

        allow(Github::Webhook).to receive(:create_handler)
          .with(payload: event_information, type: "pull_request").and_return(webhook_handler)
        expect(webhook_handler).to receive(:save)

        post "/api/github-webhook", event_information, "X-Github-Event" => "pull_request"
      end

      it "triggers an event" do
        webhook_handler = double("Webhook Handler")
        event_information = {
          foo: "bar"
        }

        allow(Github::Webhook).to receive(:create_handler)
          .with(payload: event_information, type: "pull_request").and_return(webhook_handler)
        allow(webhook_handler).to receive(:save).and_return(true)
        expect(EventHandler).to receive(:process).with(handler: webhook_handler)

        post "/api/github-webhook", event_information, "X-Github-Event" => "pull_request"
      end
    end
  end
end
