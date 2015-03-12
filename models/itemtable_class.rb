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

class ItemTable < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods

  has_many :item_ids, through: :keyword_items #??????

    
end