require 'report/weekly'

namespace :reports do
  desc "create weekly podio report"
  task :weekly_podio => :environment do |t, args|
    report = Report::Weekly.new

    EventHandler.process(
      type: "weekly_report",
      action: "created",
      payload: report,
      broadcast_event: ENV["BROADCAST_EVENTS"] == "true"
    )
  end
end
