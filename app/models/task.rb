class Task < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, done: 2 }
  validates :title, :status, :due_date, presence: true
  validates :title, length: { maximum: 255 }
  belongs_to :user
end
