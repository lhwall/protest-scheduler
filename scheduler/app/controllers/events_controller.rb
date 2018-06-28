class EventsController < ApplicationController

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
    @event = Event.create(:name => params[:name], :location => params[:location], :date => params[:date], :time => params[:time], :description => params[:description])
    if params[:new_category] != ""
       @category = Category.new(:name => params[:new_category])
       @category.save
       @event.category_id = @category.id
    else
      binding.pry
      @event.category_id = params[:category]
      @event.save
      end
    erb :"events/event_detail"
  else
    direct to "/log_in"
  end
end

end
