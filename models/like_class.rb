require_relative "class-module.rb"
require_relative "instance-module.rb"

# Class: Like
#
# Creates different like-item pairs
#
# Attributes:
# @user_ip    - String: User's IP address
# @item_id    - Integer: ID for the item (primary key ID from corresponding table)
# @item_table - String: Name of table which @item_id references 
# @id         - Integer: ID for the record (primary key)
#
# attr_accessor :item_id, :user_ip, :item_table
# arrr_reader :id
#
# Public Methods:
# 
# Private Methods:
# #initialize

class Like
  extend FeministClassMethods
  include FeministInstanceMethods

  attr_accessor :item_id, :user_ip, :item_table
  attr_reader :id


  # Private: initialize
  # Gets information for like-item pair
  #
  # Parameters:
  # options - Hash
  #           - @item_table - Instance variable representing the table where the item lives
  #           - @item_id    - Instance variable representing the ID of the particular item
  #           - @user_ip    - Instance variable representing the IP address of the user
  #           - @id         - Instance variable representing the ID of the record (primary key)
  # Returns:
  # The object
  #
  # State Changes:
  # Sets instance variables @id, @user_ip, @item_id, @item_table
                               
  def initialize(options)
    @id = options["id"]
    @user_ip = options["user_ip"]
    @item_id = options["item_id"]
    @item_table = options["item_table"]
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
    DATABASE.execute("INSERT INTO likes (user_ip, item_id, item_table) VALUES 
                    ('#{@user_ip}', #{@item_id}, '#{@item_table}')")
    @id = DATABASE.last_insert_row_id 
  end

    
end