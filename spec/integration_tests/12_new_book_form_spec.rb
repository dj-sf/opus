require 'spec_helper'

describe "New Book Form" do
  let!(:user_1) {User.create(name: "Jim", email: "jmstricker93@gmail.com", password: 'password')}
  let(:existing_book_name) {"Existing Books"}
  let(:author_1_name) { "Author Man" }
  let(:author_2_name) { "Ms. Authorson"}
  let(:author_3_name) { "Newest Author"}
  let(:existing_author_name) {"Existing Author"}
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
  let!(:existing_book) {Book.create(:name => existing_book_name, user_id: 1)}
  let!(:existing_publisher) {Publisher.create(:name => existing_publisher_name)}
  let!(:existing_author) { Author.create(:name => existing_author_name) }

  describe "/books/new" do
    before do
      visit "/sessions/login"
      fill_in 'login_email', :with => 'jmstricker93@gmail.com'
      fill_in 'login_password', :with => 'password'
      click_on 'Log In'
      visit "/books/new"
    end

    context "given a new book" do
      it "creates a new book in the database on submit" do
        expect {
          fill_in "book_name", with: book_1_name
          fill_in "new_book_author", with: author_3_name
          fill_in "new_publisher_name", with: "Tha Publicationz"
          check genre_2.id
          fill_in "book_year_published", :with => 1993
          click_on "Create New Book"
        }.to change(Book, :count).by(1)
      end
    end


    context "given a new author" do

      it "creates a new book in the database on submit" do
        expect {
          fill_in "book_name", with: book_1_name
          fill_in "new_book_author", with: author_3_name
          check genre_2.id
          fill_in "new_publisher_name", with: "Tha Publicationz"
          click_on "Create New Book"
        }.to change(Book, :count).by(1)
      end

      it "navigates to that book's new page and displays info correctly" do
        fill_in "book_name", with: book_1_name
        fill_in "new_book_author", with: author_3_name
        check genre_2.id
        fill_in "new_publisher_name", with: new_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"
        expect(page).to have_content(book_1_name)
        expect(page).to have_content(author_3_name)
        expect(page).to have_content(genre_2_name)
        # expect(page).to have_content("Successfully created book.")
      end
      it "creates a new author in the database" do
        expect {
          fill_in "book_name", with: book_1_name
          fill_in "new_book_author", with: author_3_name
          click_on "Create New Book"
        }.to change(Author, :count).by(1)
      end
    end


    context "given an existing author typed into the new author field" do
      it "creates a new book in the database on submit" do
        expect {
          fill_in "book_name", with: book_1_name
          fill_in "new_book_author", with: existing_author_name
          fill_in "new_publisher_name", with: "Tha Publicationz"
          click_on "Create New Book"
        }.to change(Book, :count).by(1)
      end

      it "navigates to that book's new page and displays info correctly" do
        fill_in "book_name", with: book_1_name
        fill_in "new_book_author", with: existing_author_name
        fill_in "new_publisher_name", with: new_publisher_name
        check genre_2.id
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(page).to have_content(book_1_name)
        expect(page).to have_content(existing_author_name)
        expect(page).to have_content(genre_2_name)
        # expect(page).to have_content("Successfully created book.")
      end
      it "does not create a new author in the database" do
        expect {
          fill_in "book_name", with: book_1_name
          fill_in "new_book_author", with: existing_author_name
          click_on "Create New Book"
        }.not_to change(Author, :count)
      end
    end

    context "selecting existing author from dropdown" do
      it "creates a new book in the database on submit" do
        expect {
          fill_in "book_name", with: book_1_name
          select existing_author_name, :from => "book_author"
          fill_in "new_publisher_name", with: "Tha Publicationz"
          click_on "Create New Book"
        }.to change(Book, :count).by(1)
      end

      it "navigates to that book's new page and displays info correctly" do
        fill_in "book_name", with: book_1_name
        select existing_author_name, :from => "book_author"
        fill_in "new_publisher_name", with: new_publisher_name
        check genre_2.id
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(page).to have_content(book_1_name)
        expect(page).to have_content(existing_author_name)
        expect(page).to have_content(genre_2_name)
        # expect(page).to have_content("Successfully created book.")
      end
      it "does not create a new author in the database" do
        expect {
          fill_in "book_name", with: book_1_name
          select existing_author_name, :from => "book_author"
          click_on "Create New Book"
        }.not_to change(Author, :count)
      end
    end

    context "given a new publisher" do
      it "navigates to that book's new page and displays publisher correctly" do
        fill_in "book_name", with: book_1_name
        fill_in "new_book_author", with: author_3_name
        check genre_2.id
        fill_in "book_year_published", with: year_published_1
        fill_in "new_publisher_name", with: new_publisher_name
        click_on "Create New Book"

        expect(page).to have_content(new_publisher_name)
      end

      it "creates a new publisher in the database" do
        expect {
          fill_in "book_name", with: book_1_name
          fill_in "new_book_author", with: author_3_name
          fill_in "new_publisher_name", with: new_publisher_name
          click_on "Create New Book"
        }.to change(Publisher, :count).by(1)
      end

    end

    context "type an existing publisher into new publisher field" do
      it "navigates to that book's new page and displays info correctly" do
        fill_in "book_name", with: book_1_name
        fill_in "new_book_author", with: author_3_name
        check genre_2.id
        fill_in "new_publisher_name", with: existing_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(page).to have_content(existing_publisher_name)
      end

      it "does not create a new publisher in the database" do
        expect {
          fill_in "book_name", with: book_1_name
          fill_in "new_book_author", with: author_3_name
          fill_in "new_publisher_name", with: existing_publisher_name
          click_on "Create New Book"
        }.not_to change(Publisher, :count)
        end
      end

      context "selecting existing publisher from dropdown" do
        it "creates a new book in the database on submit" do
          expect {
            fill_in "book_name", with: book_1_name
            fill_in "new_book_author", with: author_3_name
            select existing_publisher_name, :from => "book_publisher"
            click_on "Create New Book"
          }.to change(Book, :count).by(1)
        end

        it "navigates to that book's new page and displays info correctly" do
          fill_in "book_name", with: book_1_name
          select existing_publisher_name, :from => "book_publisher"
          select existing_author_name, :from => "book_author"
          check genre_2.id
          fill_in "book_year_published", with: year_published_1
          click_on "Create New Book"
          expect(page).to have_content(book_1_name)
          expect(page).to have_content(existing_publisher_name)
          expect(page).to have_content(genre_2_name)
          # expect(page).to have_content("Successfully created book.")
        end
        it "does not create a new publisher in the database" do
          expect {
            fill_in "book_name", with: book_1_name
            select existing_publisher_name, :from => "book_publisher"
            click_on "Create New Book"
          }.not_to change(Author, :count)
        end
      end
    context "when selecting genres" do
      it "displays those genres on the book page" do
        fill_in "book_name", with: book_1_name
        fill_in "new_book_author", with: author_3_name
        check genre_2.id
        check genre_1.id
        fill_in "new_genre", with: new_genre_name
        select existing_publisher_name, :from => "book_publisher"
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(page).to have_content(genre_1_name)
        expect(page).to have_content(genre_2_name)
        expect(page).to have_content(new_genre_name)
      end

      it "creates a new genre when the new genre field is filled in" do
        expect{
        fill_in "book_name", with: book_1_name
        check genre_2.id
        check genre_1.id
        fill_in "new_genre", with: new_genre_name
        select existing_publisher_name, :from => "book_publisher"
        select existing_author_name, :from => "book_author"
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"}.to change(Genre, :count).by(1)
      end

      it "does not create a new genre when the new genre field is not filled in" do
        expect{
        fill_in "book_name", with: book_1_name
        check genre_2.id
        check genre_1.id
        select existing_publisher_name, :from => "book_publisher"
        select existing_author_name, :from => "book_author"
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"}.not_to change(Genre, :count)
      end

      it "uses an existing genre if a pre-existing genre name is entered as a new genre" do
        expect{
        fill_in "book_name", with: book_1_name
        check genre_2.id
        check genre_1.id
        fill_in "new_genre", with: genre_2_name
        select existing_publisher_name, :from => "book_publisher"
        select existing_author_name, :from => "book_author"
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"}.not_to change(Genre, :count)
      end
    end


    context "when indicating if read" do
      it "correctly records whether it was read" do
        fill_in "book_name", with: book_1_name
        check genre_2.id
        check genre_1.id
        page.select 'Yes', :from => 'book_has_been_read'
        fill_in "new_genre", with: genre_2_name
        select existing_publisher_name, :from => "book_publisher"
        select existing_author_name, :from => "book_author"
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        the_book = Book.find_by(name: book_1_name)
        expect(the_book.has_been_read).to equal(1)
      end

      it "displays that the book has been read on books/show.erb" do
        fill_in "book_name", with: book_1_name
        check genre_2.id
        check genre_1.id
        page.select 'Yes', :from => 'book_has_been_read'
        fill_in "new_genre", with: genre_2_name
        select existing_publisher_name, :from => "book_publisher"
        select existing_author_name, :from => "book_author"
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(page).to have_content("This book has been read.")
      end

      it "correctly adds the year published" do
        fill_in "book_name", with: book_1_name
        fill_in "new_book_author", with: author_3_name
        check genre_2.id
        fill_in "new_publisher_name", with: new_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(Book.find_by(name: book_1_name).year_published).to eq(year_published_1)
      end

      it "correctly displays the year published on the book's show page" do
        fill_in "book_name", with: book_1_name
        fill_in "new_book_author", with: author_3_name
        check genre_2.id
        fill_in "new_publisher_name", with: new_publisher_name
        fill_in "book_year_published", with: year_published_1
        click_on "Create New Book"

        expect(page).to have_content(year_published_1)

      end
    end
  end
end
