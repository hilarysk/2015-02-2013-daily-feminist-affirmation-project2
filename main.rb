require "pry"
require "sqlite3"
require "sinatra"
require "sinatra/session"

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

#
binding.pry