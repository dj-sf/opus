class Book < ActiveRecord::Base
  include Slugify
  extend ClassSlugify

  validates_presence_of :name, :author_id, :publisher_id

  belongs_to :author
  belongs_to :publisher
  belongs_to :user
  has_many :book_genres
  has_many :genres, through: :book_genres
end
