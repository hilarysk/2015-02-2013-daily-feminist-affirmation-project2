require 'rubygems'
require 'bundler/setup'

require "pry"
require "sinatra"
require "sinatra/activerecord"
require "bcrypt"
require "json"

configure :development do
set :database, {adapter: "sqlite3", database: "feminist_affirmation.db"}
require "sqlite3"

end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'])
 ActiveRecord::Base.establish_connection(
 :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
 :host => db.host,
 :username => db.user,
 :password => db.password,
 :database => db.path[1..-1],
 :encoding => 'utf8'
 )
end

require_relative "models/class-module.rb"
require_relative "models/instance-module.rb"
require_relative "models/keyworditem_class.rb"
require_relative "models/itemtable_class.rb"

require_relative "models/user_class.rb"
require_relative "models/excerpt_class.rb"
require_relative "models/person_class.rb"
require_relative "models/quote_class.rb"
require_relative "models/term_class.rb"
require_relative "models/keyword_class.rb"
require_relative "database/database_setup.rb"


require_relative "controllers/admin"
require_relative "controllers/public"




#ADD VALIDATION FOR CLASSES
# - DailyFemAff finish admin stuff 
# - DailyFemAff JS for main page


# - DailyFemAff (let people subscribe to get one in email per day)

# rewatch videos on association and deployment


binding.pry