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


  # Public: #self.array_of_quote_records
  # Creates an array of all items from quotes table
  #
  # Parameters:
  # None                    
  #
  # Returns:
  # An array of all quotes records
  # 
  # State changes:
  # None
    
  def self.array_of_quote_records
    quotes_array = DATABASE.execute("SELECT quotes.id, quotes.quote, people.person FROM quotes JOIN people ON quotes.person_id = people.id") # returns array of hashes, each has is a record
    
    delete_secondary_kvpairs(quotes_array, :placeholder)
    
    return quotes_array #==> quotes_array = [{"id"=>"1", "quote"=>"sldkjflaskdjfaksldjfaklsdfjasdf", "person"=>"Ella Baker"}]
  
  end
  
  
  # Public: #self.get_all_specific_quote_data
  # Creates an array with a hash containing quote text, person name and quote id
  #
  # Parameters:
  # id - id of the record sought                    
  #
  # Returns:
  # An array of a hash representing the records asked for
  # 
  # State changes:
  # None    
    
  def self.get_all_specific_quote_data(id)
    Quote.array_of_quote_records.each do |hash|
      if hash["id"] == id.to_i
        return hash
      end
    end
        
  end
  
end