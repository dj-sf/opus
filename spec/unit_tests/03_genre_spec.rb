require 'spec_helper'

describe "Genre" do
  before do
    @genre = Genre.create(:name => "Horror")
    king = Author.create(:name => "Stephen King")
    viking = Publisher.create(:name => "Viking Press")
    it= Book.create(:name => "It")

    it.publisher = viking
    it.author = king
    it.genres << @genre

    it.save

  end

    it "can be initialized" do
      expect(@genre).to be_an_instance_of(Genre)
    end

    it "can have a name" do
      expect(@genre.name).to eq("Horror")
    end

    it "can have many authors" do
      expect(@genre.authors.count).to eq(1)
    end

    it "can have many publishers" do
      expect(@genre.publishers.count).to eq(1)
    end

    it "can have many authors" do
      expect(@genre.authors.count).to eq(1)
    end

    it "can slugify its name" do
      expect(@genre.slug).to eq("horror")
    end

    describe "Class methods" do
      it "given the slug can find a Genre" do
        slug = "horror"
        expect((Genre.find_by_slug(slug)).name).to eq("Horror")
      end
    end



end
