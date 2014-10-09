require 'bundler'
require 'sinatra'
require 'sinatra/activerecord'

set :database, "jdbcsqlite3:///events.db"
set :port, 8999

