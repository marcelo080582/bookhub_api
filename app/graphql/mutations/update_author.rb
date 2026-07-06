# frozen_string_literal: true

module Mutations
  class UpdateAuthor < BaseMutation
    argument :id, ID, required: true

    argument :name, String, required: false
    argument :bio, String, required: false

    field :author, Types::AuthorType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, bio: nil)
      attributes = {}
      attributes[:name] = name unless name.nil?
      attributes[:bio] = bio unless bio.nil?

      author = Author.find_by(id: id)

      return {
        author: nil,
        errors: ["Author not found"]
      } unless author

      if author.update(attributes)
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
