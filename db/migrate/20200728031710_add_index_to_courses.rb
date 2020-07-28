class AddIndexToCourses < ActiveRecord::Migration[6.0]
  def change
    add_index :courses, :name
  end
end
