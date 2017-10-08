require 'spec_helper'

let(:author_name) { "Author Man" }
let(:genre_1_name) { "Horror" }
let(:genre_2_name) { "Romance" }
let(:genre_category) {"Fiction"}
let(:book_name) { "That One with the Story" }
let!(:genre_1) { Genre.create(name: genre_1_name, category: genre_category) }
let!(:genre_2) { Genre.create(name: genre_2_name, category: genre_category) }
