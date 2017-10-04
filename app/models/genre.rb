class Genre < ActiveRecord::Base
  include Slugify
  extend ClassSlugify

  has_many :book_genres
  has_many :books, through: :book_genres
  has_many :authors, through: :books
  has_many :publishers, through: :books
end
