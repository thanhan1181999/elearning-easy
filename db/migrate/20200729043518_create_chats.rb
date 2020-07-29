class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.text :message
      t.string :username

      t.timestamps
    end
  end
end
