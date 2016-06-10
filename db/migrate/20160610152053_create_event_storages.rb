class CreateEventStorages < ActiveRecord::Migration
  def change
    create_table :event_storages do |t|
      t.string :event_type
      t.string :action
      t.json :payload
      t.timestamps
    end
  end
end
