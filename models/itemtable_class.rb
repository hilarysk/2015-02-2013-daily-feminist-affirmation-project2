require_relative "class-module.rb"
require_relative "instance-module.rb"

# Class: Match
#
# Creates keyword-term pairs
#
# Attributes:
# @table_name - String: Table name     
# @id         - Integer: ID for the record (primary key)
#
# attr_accessor :table_name
# attr_reader :id
#
# Public Methods:
# #insert
# 
# Private Methods:
# #initialize

class ItemTable
  extend FeministClassMethods
  include FeministInstanceMethods

  attr_accessor :table_name
  attr_reader :id


  # Private: initialize
  # Grabs information for table-id pair
  #
  # Parameters:
  # options - Hash
  #           - @table_name - Instance variable representing the name of a table
  #           - @id         - Instance variable representing the ID 
  # Returns:
  # The object
  #
  # State Changes:
  # Sets instance variables @id, @table_name  
                               
  def initialize(options)
    @id = options["id"]
    @table_name = options["table_name"]
  end
  
  # Public: insert
  # Inserts the information collected in initialize into the proper table
  #
  # Parameters:
  # None
  #
  # Returns:
  # Empty array
  #
  # State Changes:
  # None
  
  def insert
    DATABASE.execute("INSERT INTO items_tables (table_name) VALUES 
                    ('#{@table_name}')")
    @id = DATABASE.last_insert_row_id
  end

    
end