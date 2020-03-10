# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
#######################################################################################

# Database Schema - Reflects Domain Model

#Locations Table
DB.create_table! :locations do
  primary_key :id
  foreign_key :areas_id
  String :name
  String :description
  String :address
end

#Riki's Table
DB.create_table! :rikis do
  primary_key :id
  foreign_key :locations_id
  foreign_key :users_id
  Integer :rating
  String :purpose
  String :comments
end

#Areas Table
DB.create_table! :areas do
  primary_key :id
  String :name
end

#Users Table
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Areas Initial (Seed) Data
areas_table = DB.from(:areas)
areas_table.insert(name: "Evanston")
areas_table.insert(name: "Lincoln Park")
areas_table.insert(name: "Old Town")
areas_table.insert(name: "River North")
areas_table.insert(name: "West Loop")
areas_table.insert(name: "Wicker Park")

#Locations Initial (Seed) - Evanston

locations_table = DB.from(:locations)
locations_table.insert(name: "Whiskey Thief", 
                    description: "Dark and Sinister",
                    address: "616 Davis St, Evanston, IL 60201",
                    areas_id: 1)

locations_table = DB.from(:locations)
locations_table.insert(name: "Smylie Brothers", 
                    description: "Great BBQ & Brew",
                    address: "1615 Oak Ave, Evanston, IL 60201",
                    areas_id: 1)

#Locations Initial (Seed) - Lincoln Park

locations_table = DB.from(:locations)
locations_table.insert(name: "Delilah's Chicago", 
                    description: "300 Varieties of Whiskey",
                    address: "2771 N Lincoln Ave, Chicago, IL 60614",
                    areas_id: 2)

locations_table = DB.from(:locations)
locations_table.insert(name: "Alinea", 
                    description: "Save It For The One...",
                    address: "1723 N Halsted St, Chicago, IL 60614",
                    areas_id: 2)    

#Locations Initial (Seed) - Old Town

locations_table = DB.from(:locations)
locations_table.insert(name: "The VIG Chicago", 
                    description: "Warehouse + Gastropub Feel",
                    address: "1527 N Wells St, Chicago, IL 60610",
                    areas_id: 3)

locations_table = DB.from(:locations)
locations_table.insert(name: "Old Town Ale House", 
                    description: "Cash-Only",
                    address: "219 W North Ave, Chicago, IL 60610",
                    areas_id: 3)    

#Locations Initial (Seed) - River North

locations_table = DB.from(:locations)
locations_table.insert(name: "Untitled", 
                    description: "Huge Bar! A Kellogg Staple...",
                    address: "111 W Kinzie St, Chicago, IL 60654",
                    areas_id: 4)

locations_table = DB.from(:locations)
locations_table.insert(name: "Bub City", 
                    description: "Live Country Music!",
                    address: "435 N Clark St, Chicago, IL 60654",
                    areas_id: 4)    

#Locations Initial (Seed) - West Loop

locations_table = DB.from(:locations)
locations_table.insert(name: "Moneygun", 
                    description: "Loud Rap Music!",
                    address: "660 W Lake St",
                    areas_id: 5)

locations_table = DB.from(:locations)
locations_table.insert(name: "The Aviary", 
                    description: "Over-the-Top Cocktails",
                    address: "955 W Fulton Market, Chicago, IL 60607",
                    areas_id: 5)  

#Locations Initial (Seed) - Wicker Park

locations_table = DB.from(:locations)
locations_table.insert(name: "The Violet Hour", 
                    description: "Chic Speakeasy",
                    address: "1520 N Damen Ave, Chicago, IL 60622",
                    areas_id: 6)

locations_table = DB.from(:locations)
locations_table.insert(name: "The Revel Room", 
                    description: "Vintage Furnishings and Walls of Books",
                    address: "1566 N Milwaukee Ave, Chicago, IL 60622",
                    areas_id: 6)    

#Users (Seed)

users_table = DB.from(:users)

users_table.insert(name: "Riki",
                email: "rikinder.mahal@gmail.com", 
                password: "Dog")

users_table.insert(name: "Christian",
                email: "falcoca@gmail.com", 
                password: "Riki")

users_table.insert(name: "Ben",
                email: "ben.scott@kellogg.northwestern.edu", 
                password: "Meow")

#Riki's (Seed)

rikis_table = DB.from(:rikis)

rikis_table.insert(locations_id: 1,
                users_id: 1, 
                rating: 5,
                purpose: "Eat",
                comments: "The best late-night cheeseburger + fries combo in Evanston")

rikis_table.insert(locations_id: 1,
                users_id: 2, 
                rating: 4,
                purpose: "Eat",
                comments: "I'd recommend eating by the library book stacks in the back!")

rikis_table.insert(locations_id: 2,
                users_id: 2, 
                rating: 4,
                purpose: "Eat",
                comments: "Brisket sandwich + beers with the boys last Thursday")

rikis_table.insert(locations_id: 2,
                users_id: 3, 
                rating: 3,
                purpose: "Drink",
                comments: "Closes at ~10PM... Classic Evanston")

rikis_table.insert(locations_id: 3,
                users_id: 3, 
                rating: 3,
                purpose: "Drink",
                comments: "Great deals on Fireball, but not much else")

rikis_table.insert(locations_id: 3,
                users_id: 1, 
                rating: 2,
                purpose: "Drink",
                comments: "A bit too dark and depressing for my taste")

rikis_table.insert(locations_id: 4,
                users_id: 1, 
                rating: 5,
                purpose: "Drink",
                comments: "The food is amazing and the ambiance puts it over the top!")

rikis_table.insert(locations_id: 4,
                users_id: 2, 
                rating: 4,
                purpose: "Drink",
                comments: "An amazing deal even at $350+ a head...")

rikis_table.insert(locations_id: 5,
                users_id: 2, 
                rating: 4,
                purpose: "Eat",
                comments: "Caught the Cubs here with some buddies last week!")

rikis_table.insert(locations_id: 5,
                users_id: 3, 
                rating: 5,
                purpose: "Drink",
                comments: "Bottomless mimosas on Saturday was a blast!")

rikis_table.insert(locations_id: 6,
                users_id: 3, 
                rating: 1,
                purpose: "Drink",
                comments: "Drinks are wayyy watered-down. Tastes like water...")

rikis_table.insert(locations_id: 6,
                users_id: 1, 
                rating: 3,
                purpose: "Drink",
                comments: "You get what you pay for...")