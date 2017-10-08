require 'spec_helper'

describe "Book Forms" do

  let(:existing_book_name) {"Existing Books"}
  let(:author_1_name) { "Author Man" }
  let(:author_2_name) { "Ms. Authorson"}
  let(:author_3_name) { "Newest Author"}
  let(:new_publisher_name) {"New Publisher"}
  let(:existing_publisher_name) {"Existing Publisher"}
  let(:genre_1_name) { "Horror" }
  let(:genre_2_name) { "Romance" }
  let(:new_genre_name) {"New Genre"}
  let(:genre_category) {"Fiction"}
  let(:year_published_1) {1997}
  let(:year_published_2) {1998}
  let(:book_1_name) { "That One with the Story" }
  let(:book_2_name) { "No Story in this one"}
  let!(:genre_1) { Genre.create(name: genre_1_name, category: genre_category) }
  let!(:genre_2) { Genre.create(name: genre_2_name, category: genre_category) }
  let!(:author_1) {Author.create(:name => author_1_name)}
  let!(:author_2) {Author.create(:name => author_2_name)}
  let!(:existing_book) {Book.create(:name => existing_book_name)}
  let!(:existing_publisher) {Publisher.create(:name => existing_publisher_name)}

  describe "/books/new" do
    before do
      visit "/books/new"
    end

    context "given a new book" do
      it "creates a new book in the database on submit" do
        expect {
          fill_in "Book Name", with: book_1_name
          fill_in "authorlist", with: author_3_name
          click_on "Create New Book"
        }.to change(Book, :count).by(1)
      end
    end

    context "given an existing book" do
      it "does not create a new book in the database on submit" do
        expect {
          fill_in "Book Name", with: existing_book_name
          fill_in "authorlist", with: author_3_name
          click_on "Create New Book"
        }.not_to change(Book, :count)
      end
      #DO THE BELOW LATER
      # it "navigates to the book's show page" do
      # end
      #
      # it "indicates with a flash message that the book already exists" do
      #
      # end
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

        expect(page).to have_content(book_1_name)
        expect(page).to have_content(author_3_name)
        expect(page).to have_content(genre_2_name)
        # expect(page).to have_content("Successfully created book.")
      end
      it "creates a new author in the database" do
        expect {
          fill_in "Book Name", with: book_1_name
          fill_in "authorlist", with: author_3_name
          click_on "Create New Book"
        }.to change(Author, :count).by(1)
      end
    end


    context "given an existing author" do
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

        expect(page).to have_content(book_1_name)
        expect(page).to have_content(author_3_name)
        expect(page).to have_content(genre_2_name)
        # expect(page).to have_content("Successfully created book.")
      end
      it "does not create a new author in the database" do
        expect {
          fill_in "Book Name", with: book_1_name
          fill_in "authorlist", with: author_1_name
          click_on "Create New Book"
        }.not_to change(Author, :count)
      end
    end

    context "given a new publisher" do
      it "navigates to that book's new page and displays publisher correctly" do
        fill_in "Book Name", with: book_1_name
        fill_in "authorlist", with: author_3_name
        check genre_2.id
        fill_in "book_year_published", with: year_published_1
        fill_in "publisherlist", with: new_publisher_name
        click_on "Create New Book"

        expect(page).to have_content(new_publisher_name)
      end

      it "creates a new publisher in the database" do
        expect {
          fill_in "Book Name", with: book_1_name
          fill_in "authorlist", with: author_3_name
          fill_in "publisherlist", with: new_publisher_name
          click_on "Create New Book"
        }.to change(Publisher, :count).by(1)
      end

    end

    context "given an existing publisher" do
      it "navigates to that book's new page and displays info correctly" do
        fill_in "Book Name", with: book_1_name
        fill_in "authorlist", with: author_3_name
        check genre_2.id
        fill_in "publisherlist", with: existing_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(page).to have_content(existing_publisher_name)
      end

      it "does not create a new publisher in the database" do
        expect {
          fill_in "Book Name", with: book_1_name
          fill_in "authorlist", with: author_3_name
          fill_in "publisherlist", with: existing_publisher_name
          click_on "Create New Book"
        }.not_to change(Publisher, :count)
        end
      end
    context "when selecting genres" do
      it "displays those genres on the book page" do
        fill_in "Book Name", with: book_1_name
        fill_in "authorlist", with: author_3_name
        check genre_2.id
        check genre_1.id
        fill_in "new_genre", with: new_genre_name
        fill_in "publisherlist", with: existing_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(page).to have_content(genre_1_name)
        expect(page).to have_content(genre_2_name)
        expect(page).to have_content(new_genre_name)
      end

      it "creates a new genre when the new genre field is filled in" do
        expect{
        fill_in "Book Name", with: book_1_name
        fill_in "authorlist", with: author_3_name
        check genre_2.id
        check genre_1.id
        fill_in "new_genre", with: new_genre_name
        fill_in "publisherlist", with: existing_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"}.to change(Genre, :count).by(1)
      end

      it "does not create a new genre when the new genre field is not filled in" do
        expect{
        fill_in "Book Name", with: book_1_name
        fill_in "authorlist", with: author_3_name
        check genre_2.id
        check genre_1.id
        fill_in "publisherlist", with: existing_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"}.not_to change(Genre, :count)
      end

      it "uses an existing genre if a pre-existing genre name is entered as a new genre" do
        expect{
        fill_in "Book Name", with: book_1_name
        fill_in "authorlist", with: author_3_name
        check genre_2.id
        check genre_1.id
        fill_in "new_genre", with: genre_2_name
        fill_in "publisherlist", with: existing_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"}.not_to change(Genre, :count)
      end

    end
  end
end
