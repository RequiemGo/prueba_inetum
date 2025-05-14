# frozen_string_literal: true

module Mutations
  class UpdateTask < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :status, String, required: false
    argument :due_date, GraphQL::Types::ISO8601Date, required: false

    type Types::TaskType

    def resolve(id:, **attrs)
      task = Task.find(id)
      task.update!(**attrs.compact_blank)
      task
    end
  end
end
