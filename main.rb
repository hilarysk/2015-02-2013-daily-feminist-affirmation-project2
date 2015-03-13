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

require_relative "views/controllers/admin"
require_relative "views/controllers/public"

set :database, {adapter: "sqlite3", database: "feminist_affirmation.db"}

#ADD VALIDATION FOR CLASSES
# - DailyFemAff Active Record
# - DailyFemAff JS for main page
# - DailyFemAff update forms HTML5, finish admin stuff
# - DailyFemAff (make more responsive? - take fixed menu and make one where click three bars to see and it appears)
# - DailyFemAff (let people subscribe to get one in email per day)

# binding.pry