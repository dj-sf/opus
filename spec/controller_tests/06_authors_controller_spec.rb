require 'spec_helper'

describe 'AuthorsController' do
  let!(:user1) { User.create(:name => "Jim", :email => "jmstricker93@gmail.com", :password => "password")}

  before do
      visit "/sessions/login"
      fill_in 'login_email', :with => 'jmstricker93@gmail.com'
      fill_in 'login_password', :with => 'password'
      click_on 'Log In'
  end
  #Read
  it "navigates to an authors index page" do
    get '/authors'
    expect(last_response).to be_ok
  end

  it "navigates to an individual author's page" do
    sample = Author.create(name: "Sample Author")
    get '/authors/sample-author'
    expect(last_response).to be_ok
  end

end
