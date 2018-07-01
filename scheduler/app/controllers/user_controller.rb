require "rack-flash"

class UsersController < ApplicationController
use Rack::Flash

 get "/sign_up" do
   erb :"users/sign_up"
 end

  post "/sign_up" do
    if params[:username] == "" || params[:password] == ""
      flash[:message] = "Please enter a username and password"
      redirect to "/sign_up"
    elsif !!User.find_by(username: params[:username])
      flash[:message] = "That user name is taken"
      redirect to "/sign_up"
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      erb :"users/user_index"
    end
  end

  get "/log_in" do
    if !logged_in
      erb :"/users/log_in"
    else
      redirect to "/user_index"
    end
  end

post "/log_in" do
  @user = User.find_by(:username => params[:username])
  if @user && @user.authenticate(params[:password])
    #binding.pry
    session[:user_id] = @user.id
  erb :"users/user_index"
  else
    flash[:message] = "That is not the correct password or that username does not exist"
    erb :"users/log_in"
end
end

    get "/user_index" do
      if logged_in
        @user = current_user
        erb :"users/user_index"
      else
        erb :"users/log_in"
      end
    end

    get "/log_out" do
      session.destroy
      erb :index
    end

end
