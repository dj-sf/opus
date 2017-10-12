class SessionsController < ApplicationController

  get '/registrations/new-user' do
    erb :'/registrations/new-user', :layout => false
  end

  post '/registrations' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/users/home'
    else
      redirect to '/registrations/failure'
    end
  end

  get '/registrations/failure' do
    erb :'sessions/signup_error', :layout => false
  end

  get '/users/home' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'users/home'
    else
      erb :'sessions/authentication_error'
    end
  end


  get '/sessions/login' do
    if !Helpers.is_logged_in?(session)
      erb :'sessions/login', :layout =>false
    else
      erb :'sessions/already_logged_in'
    end
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])

    if @user
      session[:user_id] = @user.id
      redirect to '/users/home'
    else
      erb :'sessions/login_error', :layout => false
    end
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end
end
