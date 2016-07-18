module SprawlIntegration
  class Broadcaster
    def self.host_url
      YAML.load_file(
        File.join(
          Rails.root,
          "config",
          "sprawl.#{ENV['RAILS_ENV']}.yml"
        )
      ).fetch("host")
    end

    def self.fire(event:)
      conn = Faraday.new(url: host_url) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end

      conn.post "/notification", payload: event.to_json
    end
  end
end
