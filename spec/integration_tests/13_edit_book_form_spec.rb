require 'spec_helper'

describe "Book edit form" do

  let(:original_book_name) {"The Book"}
  let(:changed_book_name) {"The Changed Book"}
  let(:original_author_name) {"Authorman"}
  let(:changed_author_name) {"Changed Authorman"}
  let(:original_publisher_name) {"Original Publishing"}
  let(:changed_publisher_name) {"Unoriginal Publishing"}
  let(:first_edition_publishing) {1993}
  let(:second_edition_publishing) {1995}

  let!(:original_publisher) {Publisher.create(name: original_publisher_name)}
  let!(:original_author) {Author.create(name: original_author_name)}
  let!(:original_book) {Book.create(name: original_book_name)}
  let!(:genre_1) {Genre.create(name: "Fantasy")}
  let!(:genre_2) {Genre.create(name: "History")}
  let!(:genre_3) {Genre.create(name: "Thriller")}

  before do
    original_book.author = original_author
    original_book.publisher = original_publisher
    original_book.has_been_read = 0
    original_book.year_published = first_edition_publishing
    original_book.genres << genre_1
    original_book.genres << genre_2
    original_book.save
    @book = original_book
    @id = original_book.id
    @authors = Author.all
    visit "/books/#{original_book.slug}/edit"
  end

  context "editing a book name" do
    it "prefills the form with original book's name" do
      expect(find_field('book_name').value).to eq original_book_name
    end

    it "saves changes to the book's name" do
      fill_in 'book_name', :with => changed_book_name
      click_on 'Edit Book'
      expect(Book.find(@id).name).to eq(changed_book_name)
    end

    it "does not create a new book" do
      expect {
        fill_in "book_name", with: changed_book_name
        click_on "Edit Book"
      }.not_to change(Book, :count)
    end
  end

  context "editing a book's author" do
    it "preselects the unchanged book's author" do
      expect(find_field('book_author').value).to eq original_author_name
    end

    it "saves changes to the author's name when new author name is created" do
      fill_in "new_book_author", :with => changed_author_name
      click_on 'Edit Book'
      expect(Book.find(@id).author.name).to eq(changed_author_name)
    end

  end

end
