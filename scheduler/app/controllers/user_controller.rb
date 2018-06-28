class UsersController < ApplicationController

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect to "/user_index"
    end
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
