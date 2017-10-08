require 'spec_helper'

describe "Books Integration" do

  let!(:author_1) { Author.create(name: "Mark Twain") }
  let!(:author_2) { Author.create(name:"JK Rowling") }
  let!(:publisher_1) {Publisher.create(name: "Random House")}
  let!(:genre_1) { Genre.create(name:"Historical Fiction") }
  let!(:genre_2) { Genre.create(name: "Fantasy") }
  let(:book_1_name) { "The Adventures of Huckleberry Finn"}
  let(:book_2_name) { "Harry Potter and the Sorcerer's Stone"}
  let(:book_3_name) { "Harry Potter and the Chamber of Secrets"}
  let!(:book_1) { Book.create(name: book_1_name, author: author_1) }
  let!(:book_2) { Book.create(name: book_2_name, author: author_2) }
  let!(:book_3) { Book.create(name: book_3_name, author: author_2) }

  context "books/index.erb" do
    before do
      visit "/books"
      @books = Book.all
    end

    it "shows a list of all all books" do
      expect(page).to have_content(book_1_name)
      expect(page).to have_content(book_2_name)
      expect(page).to have_content(book_3_name)
    end

    it "each link goes to a books/show.erb - generated page" do
        expect(page).to have_css("a[href='/books/#{book_1.slug}']")
        expect(page).to have_css("a[href='/books/#{book_2.slug}']")
    end

    it "author listings are links going to that author's page" do
      expect(page).to have_css("a[href='/authors/#{author_1.slug}']")
      expect(page).to have_css("a[href='/authors/#{author_2.slug}']")

    end
  end
#
context "books/show.erb" do

  before do
    visit "/books/#{book_1.slug}"
    @book = Book.find_by_slug(book_1.slug)
    @book.publisher = publisher_1
  end

  it "displays a book's title" do
    expect(page).to have_content(@book.name)
  end
#
  it "displays a book's author" do
    expect(page).to have_content(author_1.name)
  end
#
  it "author is displayed as a link going to that author's page" do
    expect(page).to have_css("a[href='/authors/#{author_1.slug}']")
  end
#
#
#   it "links each genre listing to that genre's page" do
#
#   end
#
#   it "displays a book's publisher" do
#
#   end
#
#   it "publisher listings are links going to that publisher's page" do
#
#   end
#
#   it "displays a book's publication year" do
#
#   end
#
#   it "indicates whether the book has been read or not" do
#
#   end
  end
end
