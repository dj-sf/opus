class AuthorsController < ApplicationController

  get '/authors' do
    @authors = Author.all
    erb :'authors/index'
  end

  get '/authors/new' do
    @authors = Author.all
    erb :'authors/new'
  end

  get '/authors/:slug' do
    @authors = Author.all
    @author = Author.find_by_slug(params[:slug])
    erb :'authors/show'
  end

end
