class PublishersController < ApplicationController

    get '/publishers' do
      if Helpers.is_logged_in?(session)
        @publishers = Publisher.all
        erb :'publishers/index'
      else
        erb :'sessions/authentication_error', :layout => false
      end
    end

    get '/publishers/:slug' do
      if Helpers.is_logged_in?(session)
        @publishers = Publisher.all
        @publisher = Publisher.find_by_slug(params[:slug])
        erb :'publishers/show'
      else
        erb :'sessions/authentication_error', :layout => false
      end
    end

end
