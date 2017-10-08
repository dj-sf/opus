class BooksController < ApplicationController

  get '/books' do
    @books = Book.all
    erb :'books/index'
  end

  get '/books/new' do
    @books = Book.all
    @authors = Author.all
    @publishers = Publisher.all
    @genres = Genre.all
    erb :'books/new'
  end

  post '/books' do
    @books = Book.all

    @book = Book.create(params[:book])

    if Author.all.detect {|a| a.name == params[:author][:name]}
      @book.author = Author.find_by(:name => params[:author][:name])
    else
      @book.author = Author.create(:name => params[:author][:name])
    end

    if Publisher.all.detect {|p| p.name = params[:publisher][:name]}
      @book.publisher = Publisher.find_by(:name => params[:publisher][:name])
    else
      @book.publisher = Publisher.create(:name => params[:publisher][:name])
    end

    if Genre.all.detect {|g| g.name = params[:genre][:name]}
      @book.genre = Genre.find_by(:name => params[:genre][:name])
    else
      @book.genre = Genre.create(:name => params[:genre][:name])
    end

    @book.save
    flash[:message] = "Successfully Created Book"
    redirect to "/books/#{@book.slug}"
  end

  get '/books/:slug' do
    @books = Book.all
    @book = Book.find_by_slug(params[:slug])
    erb :'books/show'
  end

  get '/books/:slug/edit' do
    erb :'books/edit'
  end

  patch '/books/:slug' do
    redirect to "/books/#{params[:slug]}"
  end

  delete '/books/:slug' do
    redirect to "/books"
  end


end
