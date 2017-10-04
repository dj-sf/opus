require 'spec_helper'

describe "Author" do
  before do
    @author = Author.create(:name => "Stephen King")

    it = Book.create(:name => "It", :author => @author)

    horror = Genre.create(:name => "Horror")

    viking = Publisher.create(:name => "Viking Press")

    it.genres << horror
    it.publisher_id = viking.id
    it.author_id = @author.id
  end

  it "can be initialized" do
    expect(@author).to be_an_instance_of(Author)
  end

  it "can have a name" do
    expect(@author.name).to eq("Stephen King")
  end

  it "can have many books" do
    expect(@author.books.count).to eq(1)
  end

  it "can have many genres" do
    expect(@author.genres.count).to eq(1)
  end

  it "can slugify its name" do
    expect(@author.slug).to eq("stephen-king")
  end

  describe "Class methods" do
    it "given the slug can find an Author" do
      slug = "stephen-king"
      expect((Author.find_by_slug(slug)).name).to eq("Stephen King")
    end
  end

end
