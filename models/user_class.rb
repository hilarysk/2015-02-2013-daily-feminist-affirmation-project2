# Class: User
#
# Creates different users.
#
# Attributes:
# @emain    - String: User email
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
    
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end