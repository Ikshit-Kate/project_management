class Task < ApplicationRecord
  enum priority: { high_priority: 0, medium_priority: 1, low_priority: 2 }
  enum status: { incomplete: 0, complete: 1 }

  validates :title, :description, :due_date, :priority, presence: true 

 
  has_many :task_assignments, dependent: :destroy
  has_many :users, through: :task_assignments

end



