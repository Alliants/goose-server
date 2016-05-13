class PullRequestStorage < ActiveRecord::Base
  def to_h
    serializable_hash.symbolize_keys
  end
end
