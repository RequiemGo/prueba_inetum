# frozen_string_literal: true

module Mutations
  class CreateTask < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true
    argument :status, String, required: true
    argument :due_date, String, required: true

    type Types::TaskType

    def resolve(**args)
      context[:current_user].tasks.create!(args)
    end
  end
end
