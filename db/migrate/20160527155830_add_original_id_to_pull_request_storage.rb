class AddOriginalIdToPullRequestStorage < ActiveRecord::Migration
  def change
    add_column :pull_request_storages, :original_id, :integer
  end
end
