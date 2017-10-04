require 'spec_helper'

describe "Publisher" do
  before do
    @publisher = Publisher.create(:name => "Viking Press")
    horror = Genre.create(:name => "Horror")
    king = Author.create(:name => "Stephen King")
    it = Book.create(:name => "It")

    it.publisher = @publisher
    it.author = king
    it.genres << horror

    it.save

  end

    it "can be initialized" do
      expect(@publisher).to be_an_instance_of(Publisher)
    end

    it "can have a name" do
      expect(@publisher.name).to eq("Viking Press")
    end

    it "can have many authors" do
      expect(@publisher.authors.count).to eq(1)
    end

    it "can have many book" do
      binding.pry
      expect(@publisher.books.count).to eq(1)
    end

    it "can have many authors" do
      expect(@publisher.authors.count).to eq(1)
    end

    it "can slugify its name" do
      expect(@publisher.slug).to eq("viking-press")
    end

    describe "Class methods" do
      it "given the slug can find an Publisher" do
        slug = "viking-press"
        expect((Publisher.find_by_slug(slug)).name).to eq("viking-press")
      end
    end

end
