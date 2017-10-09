require_relative '../../config/environment'

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
    if !Book.all.detect{ |b| b.name == params[:book][:name] }
      @book = Book.create(name: params[:book][:name], has_been_read: params[:book][:has_been_read])
    else
      @book = Book.find_by(:name => params[:book][:name])
      #set alternate flash message here LATER
      redirect to "/books/#{@book.slug}"
    end

    #associating book with author

    if !params[:author][:name].empty?
      @book.author = Author.find_or_create_by(:name => params[:author][:name])
    else
      @book.author = Author.find_by(:name => params[:book][:author])
    end


    #associating book with existing publisher
    if !params[:publisher][:name].empty?
      @book.publisher = Publisher.find_or_create_by(:name => params[:publisher][:name])
    else
      @book.publisher = Publisher.find_by(:name => params[:book][:publisher])
    end

    #associating a book with existing genres
    params[:book][:genre_ids].each do |g|
      @book.genres << Genre.find(g)
    end

    #associating book with a new genre
    if !params[:genre][:name].empty?
      if !Genre.all.detect {|g| g.name == params[:genre][:name]}
        @book.genres << Genre.create(:name => params[:genre][:name])

      else
        @book.genres << Genre.find_by(name: params[:genre][:name])

      end
    end

    #saving book
    @book.save

    redirect to "/books/#{@book.slug}"
  end

  get '/books/:slug' do
    @books = Book.all
    @book = Book.find_by_slug(params[:slug])
    erb :'books/show'
  end

  get '/books/:slug/edit' do
    @books = Book.all
    @authors = Author.all
    @publishers = Publisher.all
    @genres = Genre.all
    @book = Book.find_by_slug(params[:slug])
    erb :'books/edit'
  end

  patch '/books/:slug' do
    @book = Book.find_by_slug(params[:slug])
    @books = Book.all

    @book.name = params[:book][:name]


    #associating book with author

    if !params[:author][:name].empty?
      @book.author = Author.find_or_create_by(:name => params[:author][:name])
    else
      @book.author = Author.find_by(:name => params[:book][:author])
    end
    #
    #
    # #associating book with existing publisher
    # if !params[:publisher][:name].empty?
    #   @book.publisher = Publisher.find_or_create_by(:name => params[:publisher][:name])
    # else
    #   @book.publisher = Publisher.find_by(:name => params[:book][:publisher])
    # end
    #
    # #associating a book with existing genres
    # params[:book][:genre_ids].each do |g|
    #   @book.genres << Genre.find(g)
    # end
    #
    # #associating book with a new genre
    # if !params[:genre][:name].empty?
    #   if !Genre.all.detect {|g| g.name == params[:genre][:name]}
    #     @book.genres << Genre.create(:name => params[:genre][:name])
    #   else
    #     @book.genres << Genre.find_by(name: params[:genre][:name])
    #   end
    # end

    #saving book
    @book.save


    redirect to "/books/#{params[:slug]}"
  end

  delete '/books/:slug' do
    redirect to "/books"
  end

  #later add functionality that says if the author has no books, the author instance is deleted

end
