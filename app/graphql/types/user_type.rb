module Types
  class UserType  < BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :name, String, null: false
    field :tasks, [ TaskType ], null: true
  end
end
