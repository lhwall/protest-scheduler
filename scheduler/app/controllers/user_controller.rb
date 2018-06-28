class UsersController < ApplicationController

 get "/sign_up" do
   erb :"users/sign_up"
 end

  post "/sign_up" do
    if params[:username] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      erb :user_index
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
  if @user && user.authenticate(params[:password])
    session[:user_id] = user.d
  erb :user_index
  else
    erb :"users/log_in"
end

    get "/user_index" do
      if logged_in
        @user = current_user
        erb :user_index
      else
        erb :"users/log_in"
      end
    end

end
