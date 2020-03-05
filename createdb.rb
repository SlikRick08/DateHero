# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
#######################################################################################

# Database Schema - Reflects Domain Model

DB.create_table! :locations do
  primary_key :id
  foreign_key :areas_id
  String :name
  String :description
  String :address
end

DB.create_table! :rikis do
  primary_key :id
  foreign_key :locations_id
  foreign_key :users_id
  Boolean :rating
  String :name
  String :purpose
  String :comments
end

DB.create_table! :areas do
  primary_key :id
  String :name
end

DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Areas Initial (Seed) Data
areas_table = DB.from(:areas)
areas_table.insert(name: "Evanston")
areas_table.insert(name: "Bucktown")
areas_table.insert(name: "Lincoln Park")
areas_table.insert(name: "Logan Square")
areas_table.insert(name: "The Loop")
areas_table.insert(name: "Old Town")
areas_table.insert(name: "River North")
areas_table.insert(name: "Rogers Park")
areas_table.insert(name: "Streeterville")
areas_table.insert(name: "Wicker Park")
areas_table.insert(name: "West Loop")

#Locations Initial (Seed)

locations_table = DB.from(:locations)
locations_table.insert(areas_id: 1,
                    name: "Whiskey Thief", 
                    description: "Dark and Sinister",
                    address: "Kellogg Global Hub")