require 'spec_helper'

describe "Book Forms" do

  let(:author_1_name) { "Author Man" }
  let(:author_2_name) { "Ms. Authorson"}
  let(:author_3_name) { "Newest Author"}
  let(:genre_1_name) { "Horror" }
  let(:genre_2_name) { "Romance" }
  let(:genre_category) {"Fiction"}
  let(:year_published_1) {1997}
  let(:year_published_2) {1998}
  let(:book_1_name) { "That One with the Story" }
  let(:book_2_name) { "No Story in this one"}
  let!(:genre_1) { Genre.create(name: genre_1_name, category: genre_category) }
  let!(:genre_2) { Genre.create(name: genre_2_name, category: genre_category) }
  let!(:author_1) {Author.create(:name => author_1_name)}
  let!(:author_2) {Author.create(:name => author_2_name)}

  describe "/books/new" do
    before do
      visit "/books/new"
    end

    context "given a new author" do

    it "creates a new book in the database on submit" do
      expect {
        fill_in "Book Name", with: book_1_name
        fill_in "authorlist", with: author_3_name
        click_on "Create New Book"
      }.to change(Book, :count).by(1)
    end

    it "navigates to that book's new page and displays info correctly" do
      fill_in "Book Name", with: book_1_name
      fill_in "authorlist", with: author_3_name
      check genre_2.id
      fill_in "book_year_published", with: year_published_1
      click_on "Create New Book"

      binding.pry
      expect(page).to have_content(book_1_name)
      expect(page).to have_content(author_3_name)
      expect(page).to have_content(genre_2_name)
      # expect(page).to have_content("Successfully created book.")
    end

    context "given a new author" do
      it "creates a new author in the databse" do
        expect {
          fill_in "Book Name", with: book_1_name
          fill_in "authorlist", with: author_3_name
          click_on "Create New Book"
        }.to change(Author, :count).by(1)
      end

    end

    context "given an existing author" do

    end

    context "given a new publisher" do

    end

    context "given an existing publisher" do

    end




  end
end
end
