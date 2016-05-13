class CreateRepositoryStorages < ActiveRecord::Migration
  def change
    create_table :repository_storages do |t|
      t.string :name
    end
  end
end
