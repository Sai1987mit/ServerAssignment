require 'bundler'
require 'sinatra'
require 'sinatra/activerecord'
require './lib/event.rb'

set :database, "jdbcsqlite3:///events.db"
set :port, 8999


#get all the events
  get '/events' do
    @events = Event.all 
    haml :index   
  end
  
  get '/events/new' do
    @event = Event.new
    haml :new
  end
  
  # create new event   
 post '/events' do
    @event = Event.new(params[:event])
     if @event.save
      status 201
      redirect '/events/' + @event.id.to_s
    else
      status 400
      haml :new
    end
 end   

  # delete event
  delete '/events/:id' do
    Event.find(params[:id]).destroy
    redirect '/events'  
  end
  
  # delete all events
  delete '/events' do
    Event.destroy_all
    redirect '/events'
  end
  
