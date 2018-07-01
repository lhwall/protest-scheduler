require "rack-flash"

class EventsController < ApplicationController
use Rack::Flash

get "/new_event" do
  #binding.pry
  if logged_in
  erb :"events/new_event"
else
  redirect to "/log_in"
end
end

post "/new_event" do
  if logged_in
    #binding.pry
    if ((params[:category] == "" || !params.has_key?("category")) && (!params.has_key?("new_category") || params[:new_category] == "")) || params[:name] == "" || params[:location] == ""|| params[:date] == ""|| params[:time] == ""
      flash[:message] = "Please include a name, location, date, time, and category for your event"
          redirect to "/new_event"
      else
    @event = Event.create(:name => params[:name], :location => params[:location], :date => params[:date], :time => params[:time], :description => params[:description], :user_id => current_user.id)
    if params[:new_category] != ""
       @category = Category.new(:name => params[:new_category])
       @category.save
       @event.category_id = @category.id
    else
      @event.category_id = params[:category]
      @event.save
      end
    erb :"events/event_detail"
  end
  else
    redirect to "/log_in"
  end
end

get "/events/:id" do
@event = Event.find(params[:id])
erb :"events/event_detail"
end

get "/events/:id/update" do
  if logged_in
    @event = Event.find(params[:id])
    if @event && @event.user == current_user
      erb :'events/update_event'
    else
      redirect to "/"
    end
  else
    redirect to "/log_in"
  end
end

patch "/events/:id/update" do
  #binding.pry
  @event = Event.find(params[:id])
  if @event.user == current_user
    if ((params[:category] == "" || !params.has_key?("category")) && (!params.has_key?("new_category") || params[:new_category] == "")) || params[:name] == "" || params[:location] == ""|| params[:date] == ""|| params[:time] == ""
      flash[:message] = "Please include a name, location, date, time, and category for your event"
          redirect to "/events/#{@event.id}/update"
      else
    @event.update(:name => params[:name], :location => params[:location], :date => params[:date], :time => params[:time], :description => params[:description])
    if params[:new_category] != ""
       @category = Category.new(:name => params[:new_category])
       @category.save
       @event.category_id = @category.id
    else
      @event.category_id = params[:category]
      @event.save
      end
      @event.save
    erb :"events/event_detail"
  end
  else
    redirect to "/user_index"
  end
end

delete "/events/:id/delete" do
  #binding.pry
  if logged_in
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event.delete
    end
    redirect to "/user_index"
  end
  redirect to "log_in"
end

end
