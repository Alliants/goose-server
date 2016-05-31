class AddUniquenessIndexToPullRequestStorages < ActiveRecord::Migration
  def change
    add_index :pull_request_storages, :original_id, unique: true
    add_index :pull_request_storages, :link, unique: true
  end
end
