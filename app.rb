require 'bundler'
require 'sinatra'
require 'sinatra/activerecord'
require './lib/event.rb'

set :database, "jdbcsqlite3:///events.db"
set :port, 8999


#get all the events
  get '/events' do
    @events = Event.all    
  end
  
  # create new event   
 post '/events' do
    @event = Event.new(params[:event])
 end   

  # delete event
  delete '/events/:id' do
    Event.find(params[:id]).destroy
    redirect '/events'  
  end
  
  # delete all events
  delete '/events' do
    Event.destroy_all
  end
  
