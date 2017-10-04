require 'spec_helper'

describe 'AuthorsController' do

  it "displays a list of all authors in the library" do
    get '/authors'
    expect(last_response).to be_ok
    expect(last_response.body).to include('authors/index.erb')
  end


end
