require_relative "class-module.rb"
require_relative "instance-module.rb"


# Class: User
#
# Creates different users.
#
# Attributes:
# @username - String: username
# @id       - Integer: user ID, primary key for users table
# @password - String: user's password
# @errors   - Hash: any errors when trying to create a new object
#
# attr_reader :id, :errors
# attr_accessor :password, :username
#
# Public Methods:
# #self.user_name_pass_search
# #insert
# 
# Private Methods:
# #initialize

class User
  extend FeministClassMethods
  include FeministInstanceMethods
  

  
  attr_reader :id, :errors
  attr_accessor :password, :username

  # Private: initialize
  # Gets information to create new users
  #
  # Parameters:
  # options - Hash
  #           - @id       - Instance variable representing the user ID (primary key)
  #           - @password - Instance variable representing the user's password (persons table primary key)
  #           - @username - Instance variable representing the user text
  #           - @errors   - Instance variable representing any errors when trying to create a new object
  #
  # Returns:
  # The object
  #
  # State Changes:
  # Sets instance variables @id, @password, @username, @errors    
                               
  def initialize(options)
    @id = options["id"].to_i
    @username = options["username"]
    @password = options["password"]
    @errors = options["errors"]
    
  end
  
  # Public: insert
  # Inserts the information collected in initialize into the proper table
  #
  # Parameters:
  # None
  #
  # Returns:
  # The object's id number
  #
  # State Changes:
  # Sets @id instance variable
  
  def insert
    DATABASE.execute("INSERT INTO users (username, password) VALUES 
                    (?, ?)", @username, @password)
    @id = DATABASE.last_insert_row_id
  end
  
  
  # Public: self.user_name_pass_search
  # Checks to see if the username and password are correct
  #
  # Parameters:
  # Options hash 
  #             - password - the user's password
  #             - username - the user's username
  #
  # Returns:
  # An instantiation of User class based on information passed in arguments
  #
  # State Changes:
  # None
  
  def self.user_name_pass_search(options)
    password = options["password"]
    username = options["username"]
    
    user = DATABASE.execute("SELECT * FROM users WHERE username = '#{username}' AND password = '#{password}'")
    
    delete_secondary_kvpairs(user, :placeholder)
    
    user = user[0]
      
    if user != nil
      user_info = self.new(user) 
    else
      user_info = []
    end
    
    return user_info
  end
    
end