# Class: User
#
# Creates different users.
#
# Attributes:
# @email    - String: User email
# @user_name     - String: User name
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
    
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, :password, presence: true  
  
  has_many :terms
  has_many :excerpts
  has_many :people
  has_many :quotes
    
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  
  def items_array_sorted_descending
    array = []
    self.excerpts.each do |object|
      array.push object
    end
    self.quotes.each do |object|
      array.push object
    end
    self.terms.each do |object|
      array.push object
    end
    self.people.each do |object|
      array.push object
    end
    return array.sort! {|b,a| a.updated_at<=>b.updated_at}
  end
  
  def items_array
    array = []
    self.excerpts.each do |object|
      array.push object
    end
    self.quotes.each do |object|
      array.push object
    end
    self.terms.each do |object|
      array.push object
    end
    self.people.each do |object|
      array.push object
    end
    return array
  end

  
end