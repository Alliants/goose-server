class PullRequestRepository
  DEFAULT_ADAPTER = PullRequestStorage

  def find_open
    parse(store.all)
  end

  private

  def parse(store_response)
    store_response.map { |pr| PullRequest.new(pr.to_h) }
  end

  def store
    DEFAULT_ADAPTER
  end
end
