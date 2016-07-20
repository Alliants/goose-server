require "rails_helper"
require "report/weekly"

describe Report::Weekly do
  describe "#pull_request_opened" do
    it "determins the number of prs opened|closed|merged this week" do
      create_pr_event(owner: "user_a", action: "opened", repository: "some/repo1")
      create_pr_event(owner: "user_a", action: "merged", repository: "some/repo2")
      create_pr_event(owner: "user_b", action: "merged", repository: "some/repo1")
      create_pr_event(owner: "user_c", action: "merged", repository: "some/repo3")
      create_pr_event(owner: "user_c", action: "closed", repository: "some/repo1")
      create_pr_event(owner: "user_d", action: "closed", repository: "some/repo1")

      report = described_class.new
      expect(report.pull_request_opened).to eq(1)
      expect(report.pull_request_closed).to eq(2)
      expect(report.pull_request_merged).to eq(3)
    end
  end

  describe "#.as_json" do
    it "turns the report to json" do
      create_pr_event(owner: "user_a", action: "opened", repository: "some/repo1")
      create_pr_event(owner: "user_a", action: "merged", repository: "some/repo2")
      create_pr_event(owner: "user_b", action: "merged", repository: "some/repo1")
      create_pr_event(owner: "user_c", action: "merged", repository: "some/repo3")
      create_pr_event(owner: "user_c", action: "closed", repository: "some/repo1")
      create_pr_event(owner: "user_d", action: "closed", repository: "some/repo1")

      end_date = Time.zone.now.to_date
      start_date = (end_date - 7.days)

      expect(described_class.new.as_json).to eq(pull_request_opened: 1,
                                                pull_request_closed: 2,
                                                pull_request_merged: 3,
                                                start_date: start_date,
                                                end_date: end_date)
    end
  end

  def create_pr_event(owner:, created_at: Time.zone.now, action:, repository:)
    payload = {
      repository: repository,
      owner: owner,
      created_at: created_at
    }

    EventRepository.new.create(
      event_type: "pull_request",
      action: action,
      payload: payload.to_json
    )
  end
end
