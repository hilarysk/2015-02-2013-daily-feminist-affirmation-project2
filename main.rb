require 'rubygems'
require 'bundler/setup'

require "pry"
require "sqlite3"
require "sinatra"
require "sinatra/activerecord"
require "bcrypt"

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

set :database, {adapter: "sqlite3", database: "feminist_affirmation.db"}

#ADD VALIDATION FOR CLASSES
# - DailyFemAff Active Record - more than halfway done
#    - need help with joins for keyword_items_ids table?? - polymorphic association
# - DailyFemAff finish admin stuff 
#      -add so that people of privilege 1 can see contributions by specific contributor
# - DailyFemAff (make more responsive? - take fixed menu and make one where click three bars to see and it appears --> https://github.com/StevenThiesfeld/2015-02-13-fantasy-marvel-league/blob/master/public/css/new-styles.css - nav-trigger class for hiding menu
# - DailyFemAff JS for main page
# - DailyFemAff (let people subscribe to get one in email per day)

# rewatch videos on association and deployment


binding.pry