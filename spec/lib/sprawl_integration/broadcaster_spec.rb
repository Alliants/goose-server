require "rails_helper"
require "sprawl_integration/broadcaster"

describe SprawlIntegration::Broadcaster do
  describe ".fire" do
    it "sends an event to sprawl" do
      request_stub = stub_request(:post, "http://www.example.com/notification")

      described_class.fire(event: double("some_event"))

      expect(request_stub).to have_been_requested
    end
  end
end
