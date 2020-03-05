
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
    @locations = locations_table.where(areas_id: 1)
    view "area"
end