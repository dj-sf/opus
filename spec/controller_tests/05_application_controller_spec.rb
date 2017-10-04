require 'spec_helper'

describe 'ApplicationController' do
  it "navigates to the main page of the site" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Library Organizer')
  end
end
