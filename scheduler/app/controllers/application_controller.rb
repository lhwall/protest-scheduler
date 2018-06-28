require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get "/" do
    erb :index
  end

  helpers do

   def logged_in
     session[:user_id] != nil
   end

   def current_user
   if logged_in
     User.find(session[:user_id])
  end
   end

 end

end
