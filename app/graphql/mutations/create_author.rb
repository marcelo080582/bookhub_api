# frozen_string_literal: true

module Mutations
  class CreateAuthor < BaseMutation
    argument :name, String, required: true
    argument :bio, String, required: false

    field :author, Types::AuthorType, null: true
    field :errors, [String], null: false

    def resolve(name:, bio: nil)
      author = Author.new(
        name: name,
        bio: bio
      )

      if author.save
        {
          author: author,
          errors: []
        }
      else
        {
          author: nil,
          errors: author.errors.full_messages
        }
      end
    end
  end
end
