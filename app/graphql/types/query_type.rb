# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :authors, [Types::AuthorType], null: false do
      argument :name, String, required: false
    end

    def authors(name: nil)
      scope = Author.all

      scope = scope.where("name ILIKE ?", "%#{name}%") if name.present?

      scope
    end

    field :author, Types::AuthorType, null: true do
      argument :id, ID, required: true
    end

    def author(id:)
      Author.find_by(id: id)
    end

    field :books, [Types::BookType], null: false

    def books
      Book.all
    end

    field :reviews, [Types::ReviewType], null: false

    def reviews
      Review.all
    end
  end
end
