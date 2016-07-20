module Report
  class Weekly
    attr_reader :pull_request_opened, :pull_request_closed, :pull_request_merged, :date_range

    def initialize
      today = Time.zone.today.end_of_day
      seven_days_ago = today.beginning_of_day - 7.days

      @date_range = (seven_days_ago..today)
      @pull_request_opened = EventStorage.where(created_at: @date_range, action: "opened",
                                                event_type: "pull_request").count
      @pull_request_closed = EventStorage.where(created_at: @date_range, action: "closed",
                                                event_type: "pull_request").count
      @pull_request_merged = EventStorage.where(created_at: @date_range, action: "merged",
                                                event_type: "pull_request").count
    end

    def as_json
      {
        start_date: date_range.first.to_date,
        end_date: date_range.last.to_date,
        pull_request_opened: pull_request_opened,
        pull_request_closed: pull_request_closed,
        pull_request_merged: pull_request_merged
      }
    end
  end
end
