class RemoveStatusFromTasktable < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :status, :integer
  end
end
