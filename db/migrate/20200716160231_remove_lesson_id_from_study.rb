class RemoveLessonIdFromStudy < ActiveRecord::Migration[6.0]
  def change
    remove_column :studies, :lesson_id, :integer
  end
end
