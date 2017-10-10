class SessionsController < ApplicationController

  get '/registrations/new-user' do
    erb :'/registrations/new-user'
  end

  post '/registrations' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    @user.save
    binding.pry
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/users/home' do

  end

end
