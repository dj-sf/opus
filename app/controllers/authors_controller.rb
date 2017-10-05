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

  get '/authors/:slug/edit' do
    erb :'authors/edit'
  end

  patch '/authors/:slug' do
    redirect to "/authors/#{params[:slug]}"
  end

  delete '/authors/:slug' do
    redirect to "/authors"
  end

end
