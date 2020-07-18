class RemoveRememberFromStudy < ActiveRecord::Migration[6.0]
  def change
    remove_column :studies, :remember, :boolean
  end
end
