require 'spec_helper'

describe "Authors Integration" do
  let!(:user_1) {User.create(name: "Jim", email: "jmstricker93@gmail.com", password: 'password')}
  let!(:author_1) { Author.create(name: "Mark Twain") }
  let!(:author_2) { Author.create(name:"JK Rowling") }
  let(:genre_1_name) { "Historical Fiction" }
  let(:genre_2_name) { "Fantasy" }
  let(:book_1_name) { "The Adventures of Huckleberry Finn"}
  let(:book_2_name) { "Harry Potter and the Sorcerer's Stone"}
  let(:book_3_name) { "Harry Potter and the Chamber of Secrets"}
  let!(:book_1) { Book.create(name: book_1_name, author: author_1, user_id: 1) }
  let!(:book_2) { Book.create(name: book_2_name, author: author_2, user_id: 1) }
  let!(:book_3) { Book.create(name: book_3_name, author: author_2, user_id: 1) }

  context "authors/index.erb" do
    before do
      visit "/sessions/login"
      fill_in 'login_email', :with => 'jmstricker93@gmail.com'
      fill_in 'login_password', :with => 'password'
      click_on 'Log In'
      visit "/authors"
      @authors = Author.all
    end

    it "shows a list of all all authors" do
      expect(page).to have_content(author_1.name)
      expect(page).to have_content(author_2.name)
    end

    it "each link goes to a authors/show.erb - generated page" do
      expect(page).to have_css("a[href='/authors/#{author_1.slug}']")
      expect(page).to have_css("a[href='/authors/#{author_2.slug}']")
    end
  end
  #
  context "authors/show.erb" do

    before do
      visit "/sessions/login"
      fill_in 'login_email', :with => 'jmstricker93@gmail.com'
      fill_in 'login_password', :with => 'password'
      click_on 'Log In'
      visit "/authors/#{author_2.slug}"
      @authors = Author.all
    end

    it "displays an author's name" do
      expect(page).to have_content(author_2.name)
    end

    it "displays an author's books" do
      expect(page).to have_content(book_2_name)
      expect(page).to have_content(book_3_name)
    end
  #
  #   it "book listings are links going to that book's page" do
  #
  #   end
  #
  end
end
