
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

class ItemTable < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods

  

    
end