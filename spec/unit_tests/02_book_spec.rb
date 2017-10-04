require 'spec_helper'

describe "Book" do
  before do
    @author = Author.create(:name => "Stephen King")

    @book= Book.create(:name => "It", :author => @author, :year_published => 1986)

    @genre = Genre.create(:name => "Horror")

    @publisher = Publisher.create(:name => "Viking Press")

    @book.genres << @genre
    @publisher.books << @book
    @author.books << @book
  end


    it "can be initialized" do
      expect(@book).to be_an_instance_of(Book)
    end

    it "can have a name" do
      expect(@book.name).to eq("It")
    end

    it "can have an author" do
      expect(@book.author.name).to eq("Stephen King")
    end

    it "can have a year published" do
      expect(@book.year_published).to eq(1986)
    end

    it "can have a publisher" do
      expect(@book.publisher.name).to eq("Viking Press")
    end

    it "can have many genres" do
      expect(@book.genres.count).to eq(1)
    end

    it "can slugify its name" do
      expect(@book.slug).to eq("it")
    end

    describe "Class methods" do
      it "given the slug can find an Book" do
        slug = "it"
        expect((Book.find_by_slug(slug)).name).to eq("It")
      end
    end



end
