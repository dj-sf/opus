require 'spec_helper'

describe 'BooksController' do

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
  let!(:existing_publisher) {Publisher.create(:name => existing_publisher_name)}
  let!(:existing_book) {Book.create(:name => existing_book_name, :author_id => author_1.id, :has_been_read => 0, :publisher_id => existing_publisher.id)}

  #Create
  it "navigates to a form to create a new book" do
    get '/books/new'
    expect(last_response).to be_ok
    expect(last_response.body).to include("<form")
  end

  #Read
  it "navigates to a book's index page" do
    get '/books'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Books')
  end

  it "navigates to an individual book's page" do
    get "/books/#{existing_book.slug}"
    expect(last_response).to be_ok
  end

  #Update
  it "navigates to a form to edit an book" do
    get "/books/#{existing_book.slug}/edit"
    expect(last_response).to be_ok
  end

  #Destroy


end
