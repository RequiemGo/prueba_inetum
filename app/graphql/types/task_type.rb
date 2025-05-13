module Types
  class TaskType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :status, String, null: false
    field :due_date, String, null: false
  end
end
