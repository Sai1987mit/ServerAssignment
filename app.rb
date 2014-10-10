require 'bundler'
require 'sinatra'
require 'sinatra/activerecord'
require './lib/event.rb'
require 'json'

set :database, "jdbcsqlite3:///events.db"
set :port, 8999

# All REST processes

# Get all the events
  get '/events' do
    @events = Event.all 
    haml :index   
  end

# Get the newly created event   
  get '/events/new' do
    @event = Event.new
    haml :new
  end

# Show a single event on click
  get '/events/:id' do
    @event = Event.find(params[:id])
    haml :show
  end

# Edit event
  get '/events/edit/:id' do
    @event = Event.find(params[:id])
    haml :edit
  end

# Create a new event   
  post '/events' do
    if params[:event]
      @event = Event.new(params[:event])
    else
      data  = JSON.parse(request.body.read)
      @event = Event.new(data)
    end
    if @event.save
      status 201
      redirect '/events/' + @event.id.to_s
    else
      status 400
      haml :new
    end
  end   

# Update the event 
  put '/events/:id' do
    @event = Event.find(params[:id])
    if params[:event]
      if @event.update(params[:event])
        status 201
        redirect '/events/' + params[:id]
      else
        status 
        haml :edit  
      end
    else      
      data  = JSON.parse(request.body.read)
      if @event.update(data)
        status 201
        redirect '/events/' + params[:id]
      else
        status 400
        haml :edit  
      end
    end
  end

# Delete the event 
  delete '/events/:id' do
    Event.find(params[:id]).destroy
    redirect '/events'  
  end
  
# Delete all events
  delete '/events' do
    Event.destroy_all
    redirect '/events'
  end
  
# Delete event confirmation
  get '/events/delete/:id' do
    @event = Event.find(params[:id])
    haml :delete
  end
