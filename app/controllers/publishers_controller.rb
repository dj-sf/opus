class PublishersController < ApplicationController
  
    get '/publishers' do
      @publishers = Publisher.all
      erb :'publishers/index'
    end

    get '/publishers/:slug' do
      @publishers = Publisher.all
      @publisher = Publisher.find_by_slug(params[:slug])
      erb :'publishers/show'
    end

end
