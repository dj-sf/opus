require 'spec_helper'

describe 'PublishersController' do

  #Read
  it "navigates to a publishers index page" do
    get '/publishers'
    expect(last_response).to be_ok
  end

  it "navigates to an individual publisher's page" do
    sample = Publisher.create(name: "Sample Publisher")
    get '/publishers/sample-publisher'
    expect(last_response).to be_ok
  end

end
