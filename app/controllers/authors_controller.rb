class AuthorsController < ApplicationController

  get '/authors' do
    if Helpers.is_logged_in?(session)
      @authors = Author.all
      erb :'authors/index'
    else
      erb :'sessions/authentication_error', :layout => false
    end
  end

  get '/authors/:slug' do
    if Helpers.is_logged_in?(session)
      @authors = Author.all
      @author = Author.find_by_slug(params[:slug])
      erb :'authors/show'
    else
      erb :'sessions/authentication_error', :layout => false
    end
  end

end
