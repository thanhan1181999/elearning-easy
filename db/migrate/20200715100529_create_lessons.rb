class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :picture
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
    add_index :lessons, [:course_id, :created_at]
  end
end
