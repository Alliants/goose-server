class PullRequestStorage < ActiveRecord::Base
  def to_h
    self.serializable_hash.symbolize_keys
  end
end
