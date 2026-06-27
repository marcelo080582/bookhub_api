# frozen_string_literal: true

module Resolvers
  class AuthorsResolver < BaseResolver
    type [Types::AuthorType], null: false

    argument :name, String, required: false

    def resolve(name: nil)
      scope = Author.all

      scope = scope.where("name ILIKE ?", "%#{name}%") if name.present?

      scope
    end
  end
end
