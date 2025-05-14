# frozen_string_literal: true

module Mutations
  class CreateTask < Mutations::BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true
    argument :status, String, required: true
    argument :due_date, GraphQL::Types::ISO8601Date, required: true
    argument :user_id, ID, required: true

    type Types::TaskType

    def resolve(**args)
      user = User.find(args.delete(:user_id))
      user.tasks.create!(**args)
    end
  end
end
