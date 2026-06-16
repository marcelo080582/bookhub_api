class Book < ApplicationRecord
  belongs_to :author
  has_many :reviews

  validates :title, presence: true
end
