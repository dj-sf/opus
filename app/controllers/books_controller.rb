class BooksController < ApplicationController

  get '/books' do
    @books = Book.all
    erb :'books/index'
  end

  get '/books/new' do
    @books = Book.all
    erb :'books/new'
  end

  get '/books/:slug' do
    @books = Book.all
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
