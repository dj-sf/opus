class SessionsController < ApplicationController

  get '/registrations/new-user' do
    erb :'/registrations/new-user'
  end

  post '/registrations' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    @user.save
    binding.pry
    session[:id] = @user.id
    redirect to '/users/home'
  end

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'users/home'
  end


  get '/sessions/login' do
    erb :'sessions/login', :layout =>false
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])

    session[:id] = @user.id

    redirect to '/users/home'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

end
