class Author < ActiveRecord::Base
  include Slugify
  extend ClassSlugify

  has_many :books
  has_many :genres, through: :books
  has_many :publishers, through: :books
end
