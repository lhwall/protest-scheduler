require "rack-flash"

class UsersController < ApplicationController
use Rack::Flash

#retrieves sign up page
 get "/sign_up" do
   erb :"users/sign_up"
 end

#creates new user provided they have submitted a unique username and a password
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

#retrieves login page for user who is not logged in
  get "/log_in" do
    if !logged_in
      erb :"/users/log_in"
    else
      redirect to "/user_index"
    end
  end

#logs in user if they provide the correct username and password and directs them to their personal page
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

#retrieves page with all events created by user
    get "/user_index" do
      if logged_in
        @user = current_user
        erb :"users/user_index"
      else
        erb :"users/log_in"
      end
    end

#logs out a user
    get "/log_out" do
      session.destroy
      redirect to "/"
    end

end
