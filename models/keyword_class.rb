require_relative "class-module.rb"
require_relative "instance-module.rb"


# Class: Keyword
#
# Creates different keywords and assigns them to an ID
#
# Attributes:
# @keyword - Instance variable representing the actual keyword
# @id      - Instance variable representing the keyword ID within the table (primary key)
# @errors  - Instance variable representing any errors when trying to create a new object
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

class Keyword
  extend FeministClassMethods
  include FeministInstanceMethods

  
  attr_reader :id, :errors
  attr_accessor :keyword


  # Private: initialize
  # Creates new keywords
  #
  # Parameters:
  # options - Hash
  #           - @keyword - Instance variable representing the actual keyword
  #           - @id      - Instance variable representing the keyword ID within the table (primary key)
  #           - @errors  - Instance variable representing any errors when trying to create a new object
  # Returns:
  # The object
  #
  # State Changes:
  # Sets instance variables @keyword, @errors and @id     
                               
  def initialize(options)
    @id = options["id"]
    @keyword = options["keyword"]
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
    DATABASE.execute("INSERT INTO keywords (keyword) VALUES 
                    (?)", @keyword)
    @id = DATABASE.last_insert_row_id
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