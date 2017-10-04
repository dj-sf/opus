require 'spec_helper'

describe 'AuthorsController' do

  #Create
  it "navigates to a form to create a new author" do
    get '/authors/new'
    expect(last_response).to be_ok
    expect(last_response.body).to include("<form")
  end

  #Read
  it "navigates to an authors index page" do
    get '/authors'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Authors')
  end

  it "navigates to an individual author's page" do
    sample = Author.create(name: "Sample Author")
    get '/authors/sample-author'
    expect(last_response).to be_ok
  end

  #Update

  #Destroy

end
