class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.string :content
      t.integer :receiver_id

      t.timestamps
    end
  end
end
