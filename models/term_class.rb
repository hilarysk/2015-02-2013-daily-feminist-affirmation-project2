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
# attr_reader :id
# attr_accessor :definition, :text
#
# Public Methods:
# #insert
# #self.array_of_term_records
# 
# Private Methods:
# #initialize

class Term
  extend FeministClassMethods
  include FeministInstanceMethods
  

  
  attr_reader :id
  attr_accessor :definition, :term, :phonetic

  # Private: initialize
  # Gets information to create new quotes
  #
  # Parameters:
  # options - Hash
  #           - @id         - the term ID (primary key)
  #           - @definition - the term's definition
  #           - @term       - the term 
  #           - @phonetic   - phonetic spelling of the term
  #           - @used       - holds value 0 for if not used yet; 1 for if used
  #
  # Returns:
  # An object of the class
  #
  # State Changes:
  # Sets instance variables @id, @definition, @term, @phonetic, @used     
                               
  def initialize(options)
    @id = options["id"]
    @term = options["term"]
    @definition = options["definition"]
    @phonetic = options["phonetic"]
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
    DATABASE.execute("INSERT INTO terms (term, definition, phonetic) VALUES 
                    ('#{@term}', '#{@definition}', '#{@phonetic}')")
    @id = DATABASE.last_insert_row_id
  end


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

    
end