require 'spec_helper'

describe "Books Integration" do

  let!(:author_1) { Author.create(name: "Mark Twain") }
  let!(:author_2) { Author.create(name:"JK Rowling") }
  let!(:publisher_1) {Publisher.create(name: "Random House")}
  let!(:publisher_2) {Publisher.create(name: "Clickbait Publishing")}
  let!(:genre_1) { Genre.create(name:"Historical Fiction") }
  let!(:genre_2) { Genre.create(name: "Fantasy") }
  let(:book_1_name) { "The Adventures of Huckleberry Finn"}
  let(:book_2_name) { "Harry Potter and the Sorcerer's Stone"}
  let(:book_3_name) { "Harry Potter and the Chamber of Secrets"}
  let!(:book_1) { Book.create(name: book_1_name, author_id: 1, publisher_id: 2) }
  let!(:book_2) { Book.create(name: book_2_name, author_id: 2, publisher_id: 1) }
  let!(:book_3) { Book.create(name: book_3_name, author_id: 2, publisher_id: 1) }

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

  describe "books/show.erb"

    context "viewing a book's info" do

      before do
        visit "/books/#{book_2.slug}"
        @book = Book.find_by_slug(book_2.slug)
      end

      it "displays a book's title" do

        expect(page).to have_content(@book.name)
      end
    #
      it "displays a book's author" do
        expect(page).to have_content(author_2.name)
      end
    #
      it "author is displayed as a link going to that author's page" do
        expect(page).to have_css("a[href='/authors/#{author_2.slug}']")
      end

      it "has a button linking to an edit form" do
        expect(page).to have_css("a[href='/books/#{book_2.slug}/edit']")
      end
    end

  context "deleting a book" do

    before do
      visit "/books/#{book_1.slug}"
      @book = Book.find_by_slug(book_1.slug)
    end

    it "has a delete book button" do
      click_on 'Delete Book'
    end

    it "clicking on the button removes a book from the database" do
      click_on 'Delete Book'
      expect(Book.all).not_to include(book_1)
    end

    it "page redirects to the books index page after deleting a book" do
      click_on 'Delete Book'
      expect(page).to have_current_path("/books")
    end

    it "deletes the book's author if that author no longer has books" do
      click_on 'Delete Book'
      expect(Author.all).not_to include(author_1)
    end

    it "deletes the book's genres if those genres no longer have any books" do
      #I KNOW THIS FUNCTION IS WORKING but the test isnt quite right
      @book.genres << genre_1
      @book.save
      genre_1.save
      click_on 'Delete Book'
      expect(Genre.all).not_to include(genre_1)
    end

    it "deletes the book's publisher if that publisher no longer has books" do
      click_on 'Delete Book'
      expect(Publisher.all).not_to include(publisher_2)
    end

    xit "clicking on the button redirects brings up a 'are you sure you want to delete this book' button" do
      #functionality not yet implemented
    end
  end
end
