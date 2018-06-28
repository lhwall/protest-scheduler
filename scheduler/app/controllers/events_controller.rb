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
    @event = Event.create(params)
    erb :"events/event_detail"
  else
    direct to "/log_in"
  end
end

end
