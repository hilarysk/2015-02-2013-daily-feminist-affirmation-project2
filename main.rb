require 'rubygems'
require 'bundler/setup'

require "pry"
require "sqlite3"
require "sinatra"
require "sinatra/activerecord"
require "bcrypt"
require "json"

require_relative "models/class-module.rb"
require_relative "models/instance-module.rb"

require_relative "database/database_setup.rb"
require_relative "models/keyworditem_class.rb"
require_relative "models/itemtable_class.rb"

require_relative "models/user_class.rb"
require_relative "models/excerpt_class.rb"
require_relative "models/person_class.rb"
require_relative "models/quote_class.rb"
require_relative "models/term_class.rb"
require_relative "models/keyword_class.rb"

require_relative "controllers/admin"
require_relative "controllers/public"

configure :development do
set :database, {adapter: "sqlite3", database: "feminist_affirmation.db"}
end


#ADD VALIDATION FOR CLASSES
# - DailyFemAff finish admin stuff 
# - DailyFemAff JS for main page


# - DailyFemAff (let people subscribe to get one in email per day)

# rewatch videos on association and deployment


# binding.pry