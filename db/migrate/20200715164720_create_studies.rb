class CreateStudies < ActiveRecord::Migration[6.0]
  def change
    create_table :studies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.boolean :remember

      t.timestamps
    end
  end
end
