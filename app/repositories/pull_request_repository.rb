class PullRequestRepository
  DEFAULT_ADAPTER = PullRequestStorage

  attr_reader :store

  def initialize
    @store = DEFAULT_ADAPTER
  end

  def find_open
    parse_many(store.all)
  end

  def count
    store.all.count
  end

  def delete(original_id:)
    store.find_by!(original_id: original_id).delete
  end

  def find_pull_request(original_id:)
    parse_one(store.find_by(original_id: original_id))
  end

  def persist(pull_request)
    instance = store.find_by(original_id: pull_request.original_id)
    instance.update(pull_request.to_h)
  end

  def store_each(github_request)
    github_request.each do |req|
      store.create(req.to_h)
    end
  end

  delegate :destroy_all, :create, to: :store

  private

  def parse_many(store_response)
    store_response.map { |pr| parse_one(pr) }
  end

  def parse_one(store_response_object)
    PullRequest.new(store_response_object.to_h)
  end
end
