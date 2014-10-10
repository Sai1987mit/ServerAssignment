##Server Assignment

The Server Assignment deals with usage of Jruby,Sinatra and Puma server to illustrate REST services.

####VM set up

1) Download Virtualbox from https://www.virtualbox.org/wiki/Downloads

2) Add a new system (ubuntu) with following specifications
Base Memory : 1 GB RAM
Fixed size VDI : 25 GB
General > Advanced [Consider Bidirectional for Clipboard]

3) Download the latest version of Ubuntu at http://www.ubuntu.com/download

4) Placing the .iso Ubuntu file 
In Storage > Under Controller [Click on the CD symbol] > In the Attributes > CD symbol > Add the .iso file

5) Start the machine and install the Ubuntu, this could take a while

##Application Setup
####RVM and Ruby installation


1)Install RVM, ruby and jruby
  curl -L https://get.rvm.io | bash -s stable --ruby
  rvm install ruby-1.9.3
  rvm install jruby-1.7.13

2)Check the versions installed and already present:
  rvm list 

3)Check the version being used:
  ruby  -v    should be jruby 1.7.13
  jruby -v    should be jruby 1.7.13

4)If version is different consider the jruby 1.7.13
  rvm use jruby-1.7.13

5)We can clone the code at from git at https://github.com/Sai1987mit/ServerAssignment.git
  Bundle Install 
  if bundler is not present 
  sudo gem install bundler
  rake db:migrate  [would create the database: events.db]

####Starting the application and testing
1)Start the server using 
  jruby app.rb
  We find the below output
  ```
  sai@sai-VirtualBox:~/projects/ServerAssignment$ jruby app.rb
  Puma 2.9.1 starting...
  * Min threads: 0, max threads: 16
  * Environment: development
  * Listening on tcp://localhost:8999
  == Sinatra/1.4.5 has taken the stage on 8999 for development with backup from Puma
  ```
  This means that the application is ready to be used.

2)Once the server is running.The application can be tested from terminal as well as from browser:
  1)Testing from terminal:
    Open a new tab
    1) curl "http://localhost:8999/events"   - to get all events[the events could be empty thus create the events first]
    2) curl "http://localhost:8999/events/2" - to get a particular event
    3) curl -X POST "http://localhost:8999/events" -H "Content-Type: application/json" -d '{"data":"sample"}' - to add an event
    4) curl -X PUT "http://localhost:8999/events" -H "Content-Type: application/json" -d '{"data":"NAME is now at LATITUDE/LONGITUDE"}'  -to edit an event
    5) curl -X DELETE "http://localhost:8999/events" -to delete all event
    6) curl -X DELETE "http://localhost:8999/events/2"  - to delete a particular event
  
  2)Testing from browser
    Go to the address http://localhost:8999/events
    1) Here we can create a new event or browse all the events already created
    2) Along with events we have edit and delete event actions
    3) On click of edit, we can either update or cancel action
    4) Similarily on click of delete, we can either delete or cancel the action