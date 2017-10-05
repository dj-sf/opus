require 'spec_helper'

describe 'BooksController' do

  #Create
  it "navigates to a form to create a new book" do
    get '/books/new'
    expect(last_response).to be_ok
    expect(last_response.body).to include("<form")
  end

  #Read
  it "navigates to an books index page" do
    get '/books'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Books')
  end

  it "navigates to an individual book's page" do
    sample = Book.create(name: "Sample Book")
    get '/books/sample-book'
    expect(last_response).to be_ok
  end

  #Update
  it "navigates to a form to edit an book" do
    sample = Book.create(name: "Sample Book")
    get '/books/sample-book/edit'
    expect(last_response).to be_ok
  end

  it "accepts an edit request and returns to book show page" do
    sample = Book.create(name: "Sample Book")
    get '/books/sample-book/edit'

    patch '/books/sample-book'
    follow_redirect!
    expect(last_response).to be_ok
    expect(last_request.path).to eq('/books/sample-book')

  end

  #Destroy

  it "responds with ok to a delete request and redirects to index" do
    sample = Book.create(name: "Sample Book")
    delete '/books/sample-book'
    follow_redirect!
    expect(last_response).to be_ok
    expect(last_request.path).to eq('/books')

  end

end
