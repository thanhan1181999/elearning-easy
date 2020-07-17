class RemoveMemoryFromStudy < ActiveRecord::Migration[6.0]
  def change
    remove_column :studies, :memory, :boolean
  end
end
