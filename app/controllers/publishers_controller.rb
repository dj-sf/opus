class PublishersController < ApplicationController
    get '/publishers' do
      @publishers = Publisher.all
      erb :'publishers/index'
    end

    get '/publishers/:slug' do
      @publishers = Publisher.all
      erb :'publishers/show'
    end

end
