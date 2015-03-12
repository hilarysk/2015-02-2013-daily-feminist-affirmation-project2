require_relative "class-module.rb"
require_relative "instance-module.rb"


# Class: Keyword
#
# Creates different keywords and assigns them to an ID
#
# Attributes:
# @keyword - Instance variable representing the actual keyword
# @id      - Instance variable representing the keyword ID within the table (primary key)
#
# attr_reader :id
# attr_accessor :keyword
#
# Public Methods:
# #insert
# #self.get_array_keywords
# 
# Private Methods:
# #initialize

class Keyword < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods

  # Private: initialize
  # Creates new keywords
  #
  # Parameters:
  # options - Hash
  #           - @keyword - Instance variable representing the actual keyword
  #           - @id      - Instance variable representing the keyword ID within the table (primary key)
  # Returns:
  # The object
  #
  # State Changes:
  # Sets instance variables @keyword, @errors and @id     
                               
  def initialize(options)
    @id = options["id"]
    @keyword = options["keyword"]
  end

  # Public: #self.get_array_keywords
  # Creates an array of all keywords
  #
  # Parameters:
  # None                    
  #
  # Returns:
  # An array of all keywords
  # 
  # State changes:
  # None
  
  def self.get_array_keywords
    keywords_array = DATABASE.execute("SELECT keyword FROM keywords")
    
    return keywords_array.shuffle!
       
  end
    
end