
# Set Up for the Application and Database. DO NOT CHANGE. #############################
require "sinatra"  
require "sinatra/cookies"                                                             #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "bcrypt"                                                                      #
require "twilio-ruby"                                                                 #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

#Locations Table = Bars, Restaurants, Parks, etc.
locations_table = DB.from(:locations)

#Riki's Table = Reviews
rikis_table = DB.from(:rikis)

#Areas Table = Neighborhoods in Chicago
areas_table = DB.from(:areas)

#Users Table = Users on HotRiki
users_table = DB.from(:users)

get "/" do
    puts "params: #{params}"
    @areas = areas_table.all.to_a
    view "home"
end

get "/areas/:id" do
    @area = areas_table.where(id: params[:id]).to_a[0]
    @locations = locations_table.where(areas_id: @area[:id])
    view "area"
end

get "/locations/:id" do
    puts "params: #{params}"
    @locations = locations_table.all.to_a
    @location = locations_table.where(id: params[:id]).to_a[0]
    view "location"
end

get "/users/new" do
    view "new_user"
end

post "/users/create" do
    puts params
    hashed_password = BCrypt::Password.create(params["password"])
    users_table.insert(name: params["name"], email: params["email"], password: hashed_password)
    view "create_user"
end

get "/logins/new" do
    view "new_login"
end

post "/logins/create" do
    user = users_table.where(email: params["email"]).to_a[0]
    puts BCrypt::Password::new(user[:password])
    if user && BCrypt::Password::new(user[:password]) == params["password"]
        session["user_id"] = user[:id]
        @current_user = user
        view "create_login"
    else
        view "create_login_failed"
    end
end

get "/logout" do
    session["user_id"] = nil
    @current_user = nil
    view "logout"
end