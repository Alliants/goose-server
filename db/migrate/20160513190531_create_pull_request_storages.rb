class CreatePullRequestStorages < ActiveRecord::Migration
  def change
    create_table :pull_request_storages do |t|
      t.string :link
      t.string :title
      t.string :org
      t.string :repo
      t.string :owner
      t.timestamp :created_at
      t.integer :number_of_comments
    end
  end
end
