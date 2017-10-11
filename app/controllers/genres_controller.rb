class GenresController < ApplicationController

  get '/genres' do
    if Helpers.is_logged_in?(session)
      @genres = Genre.all
      erb :'genres/index'
    else
      erb :'sessions/authentication_error', :layout => false
    end
  end

  get '/genres/:slug' do
    if Helpers.is_logged_in?(session)
      @genres = Genre.all
      @genre = Genre.find_by_slug(params[:slug])
      erb :'genres/show'
    else
      erb :'sessions/authentication_error', :layout => false
    end
  end

end
