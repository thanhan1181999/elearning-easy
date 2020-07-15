class AddPictureToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :picture, :string
  end
end
