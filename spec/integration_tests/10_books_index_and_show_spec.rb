require 'spec_helper'

describe "Books Index" do

  let!(:author_1) { Author.create(name: "Mark Twain") }
  let!(:author_2) { Author.create(name:"JK Rowling") }
  let(:genre_1_name) { "Historical Fiction" }
  let(:genre_2_name) { "Fantasy" }
  let(:book_1_name) { "The Adventures of Huckleberry Finn"}
  let(:book_2_name) { "Harry Potter and the Sorcerer's Stone"}
  let(:book_3_name) { "Harry Potter and the Chamber of Secrets"}
  let!(:book_1) { Book.create(name: book_1_name, author: author_1) }
  let!(:book_2) { Book.create(name: book_2_name, author: author_2) }
  let!(:book_3) { Book.create(name: book_3_name, author: author_2) }

  before do
    visit "/books"
    @books = Book.all
  end

  it "shows a list of all all books" do
    expect(page).to have_content(book_1_name)
    expect(page).to have_content(book_2_name)
    expect(page).to have_content(book_3_name)
  end

#   it "each link goes to a books/show.erb - generated page" do
#
#   end
# end
#
# describe "displaying books/show.erb" do
#   it "displays a book's title" do
#
#   end
#
  it "displays a book's author" do
    expect(page).to have_content(author_1.name)
    expect(page).to have_content(author_2 .name)
  end
#
#   it "author listings are links going to that author's page" do
#
#   end
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
