class ChangeTypeOfStatusPriority < ActiveRecord::Migration[7.0]
  def change
    change_column(:tasks, :status, :integer)
    change_column(:tasks, :priority, :integer)
  end
end
