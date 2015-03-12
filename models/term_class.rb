require_relative "class-module.rb"
require_relative "instance-module.rb"


# Class: Term
#
# Creates different products and gets information about them.
#
# Attributes:
# @id         - Integer: Instance variable representing the term ID (primary key)
# @definition - String: Variable representing the term's definition
# @term       - String: Variable representing the term 
# @phonetic   - String: The phoentic spelling of the term
#
#
# Public Methods:
# #insert
# #self.array_of_term_records
# 
# Private Methods:
# #initialize

class Term < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods
  
  


  # Public: #self.array_of_term_records
  # Creates an array of all items from terms table
  #
  # Parameters:
  # None                    
  #
  # Returns:
  # An array of all terms records
  # 
  # State changes:
  # None
      
  def self.array_of_term_records
    terms_array = DATABASE.execute("SELECT id, term, definition, phonetic FROM terms") # returns array of hashes, each has is a record
    
    delete_secondary_kvpairs(terms_array, :placeholder)
    
    return terms_array #==> terms_array = [{"id"=>"1", "term"=>"femme", "definition"=>"yoyo", "phonetic"=>"hexadecimal unicode baby"}]
 
  end
  
  
  # Public: #self.get_all_specific_term_data
  # Creates an array with a hash containing all term info
  #
  # Parameters:
  # id - id of the record sought                    
  #
  # Returns:
  # An array of a hash representing the record asked for
  # 
  # State changes:
  # None    
    
  def self.get_all_specific_term_data(id)
    Term.array_of_term_records.each do |hash|
      if hash["id"] == id.to_i
        return hash
      end
    end
        
  end
  

    
end