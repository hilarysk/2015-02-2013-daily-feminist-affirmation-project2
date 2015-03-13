require_relative "class-module.rb"
require_relative "instance-module.rb"


# Class: Quote
#
# Creates different products and gets information about them.
#
# Attributes:
# @quote     - String: Text of quote
# @id        - Integer: Quote ID, primary key for quotes table
# @person_id - Integer: ID from people table (foreign key)
# @errors    - Hash representing any errors when trying to create a new object

# attr_reader :id, :errors
# attr_accessor :person_id, :quote
#
# Public Methods:
# #insert
# #self.array_of_quote_records
# 
# Private Methods:
# #initialize

class Quote < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods
  
  belongs_to :person

  
end