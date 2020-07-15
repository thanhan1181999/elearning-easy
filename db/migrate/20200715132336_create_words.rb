class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :word
      t.string :meaning
      t.string :picture

      t.timestamps
    end
  end
end
