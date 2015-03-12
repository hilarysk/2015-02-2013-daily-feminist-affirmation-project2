# Class: User
#
# Creates different users.
#
# Attributes:
# @username - String: username
# @id       - Integer: user ID, primary key for users table
# @password - String: user's password
#
# Public Methods:
# #self.user_name_pass_search
# #insert
# 
# Private Methods:
# #initialize

class User < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods
  include BCrypt
  # users.password_hash in the database is a :string
    
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  
  def create(options)
    username = options["username"]
    password = options["password"]
    
    @user = User.new(username)
    @user.password = password
    @user.save! 
  end
  
  # # Public: self.user_name_pass_search
  # # Checks to see if the username and password are correct
  # #
  # # Parameters:
  # # Options hash
  # #             - password - the user's password
  # #             - username - the user's username
  # #
  # # Returns:
  # # An instantiation of User class based on information passed in arguments
  # #
  # # State Changes:
  # # None
  #
  # def self.user_name_pass_search(options)
  #   password = options["password"]
  #   username = options["username"]
  #
  #   user = DATABASE.execute("SELECT * FROM users WHERE username = '#{username}' AND password = '#{password}'")
  #
  #   delete_secondary_kvpairs(user, :placeholder)
  #
  #   user = user[0]
  #
  #   if user != nil
  #     user_info = self.new(user)
  #   else
  #     user_info = []
  #   end
  #
  #   return user_info
  # end
    
end