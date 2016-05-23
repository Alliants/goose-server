class PullRequestRepository
  DEFAULT_ADAPTER = PullRequestStorage

  attr_reader :store

  def initialize
    @store = DEFAULT_ADAPTER
  end

  def find_open
    parse(store.all)
  end

  def store_each(github_request)
    github_request.each do |req|
      store.create(req.to_h)
    end
  end

  delegate :destroy_all, to: :store

  private

  def parse(store_response)
    store_response.map { |pr| PullRequest.new(pr.to_h) }
  end
end
