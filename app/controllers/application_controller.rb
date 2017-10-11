class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if !Helpers.is_logged_in?(session)
      erb :home, :layout => false
    else
      redirect to '/users/home'
    end
  end
end
