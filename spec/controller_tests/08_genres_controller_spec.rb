require 'spec_helper'

describe 'GenresController' do

  #Read
  it "navigates to an genres index page" do
    get '/genres'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Genres')
  end

  it "navigates to an individual genre's page" do
    sample = Genre.create(name: "Sample Genre")
    get '/genres/sample-genre'
    expect(last_response).to be_ok
  end

end
