class RemoveCourseIdFromStudy < ActiveRecord::Migration[6.0]
  def change
    remove_column :studies, :course_id, :integer
  end
end
