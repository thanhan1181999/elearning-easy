class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :course_category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :courses, [:user_id, :course_category_id, :created_at]
  end
end
