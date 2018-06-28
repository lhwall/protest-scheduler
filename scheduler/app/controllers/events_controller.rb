class EventsController < ApplicationController

get "/new_event" do
  if logged_in
  erb :new_event
else
  redirect to "/log_in"
end
end

post "/new_event" do
  if logged_in
    @event = Event.create(params)
    erb :event_detail
  else
    direct to "/log_in"
  end
end

end
