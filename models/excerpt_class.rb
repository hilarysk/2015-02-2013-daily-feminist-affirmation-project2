require_relative "class-module.rb"
require_relative "instance-module.rb"



# Class: Excerpt
#
# Creates different excerpts and gets information about them.
#
# Attributes:
# @excerpt   - String: Text of Excerpt
# @id        - Integer: Excerpt ID, primary key for excerpts table
# @source    - String: Source of excerpt
# @person_id - Integer: Foreign key linked to ID primary key from persons table
#
# attr_reader :id
# attr_accessor :person_id, :source, :excerpt
#
# Public Methods:
# #insert
# #self.array_of_excerpt_records
# 
# Private Methods:
# #initialize

class Excerpt
  extend FeministClassMethods
  include FeministInstanceMethods

  
  attr_reader :id, :errors
  attr_accessor :person_id, :source, :excerpt


  # Private: initialize
  # Starts and then plays the game with the provided players.
  #
  # Parameters:
  # options - Hash
  #           - @excerpt   - String: Text of Excerpt
  #           - @id        - Integer: Excerpt ID, primary key for excerpts table
  #           - @source    - String: Source of excerpt (magazine, book, song, etc.)
  #           - @person_id - Integer: Foreign key linked to ID primary key from persons table
  #          
  # Returns:
  # The object
  #
  # State Changes:
  # Sets instance variables @excerpt, @id, @source, @person_id, @errors
                               
  def initialize(options)
    @id = options["id"].to_i
    @excerpt = options["excerpt"]
    @source = options["source"]
    @person_id = options["person_id"]
    @errors = {"source"=>[], "excerpt"=>[]} #key would be "source", value would be array of error messages depending on specific error
    
    #SOURCE ERRORS
    
    (DATABASE.execute("SELECT source FROM excerpts")).each do |hash|
      if hash["source"] == @source
        @errors["source"] << "That source is already in the system. Please select the existing source from the dropdown menu, instead of typing it in separately."
      end
    end
    
    if @source.is_a?(Integer)
      @source = @source.to_s
    end
    
    # EXCERPT ERRORS
      
    (Excerpt.find_specific_field_array({"table"=>"excerpts", "field"=>"excerpt"})).each do |curr_excerpt| 
      if curr_excerpt.byteslice(0..30) == @excerpt.byteslice(0...30) || curr_excerpt.byteslice(-30..-1) == @excerpt.byteslice(-30..-1)
        @errors["excerpt"] << "An existing excerpt already contains part or all of the text you're trying to add."
      end
    end
    
    
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
  
  def insert  # --> DO THIS FOR ANY INSERT WITH VALUES THAT MIGHT NEED ESCAPING
                    
    DATABASE.execute("INSERT INTO excerpts (excerpt, source, person_id) VALUES   
                     (?, ?, ?)", @excerpt, @source, @person_id)
                    
    @id = DATABASE.last_insert_row_id
  end

  # Public: #self.array_of_excerpt_records
  # Creates an array of all items from excerpts table
  #
  # Parameters:
  # None                    
  #
  # Returns:
  # An array of all excerpts records
  # 
  # State changes:
  # None    
    
  def self.array_of_excerpt_records
    excerpts_array = DATABASE.execute("SELECT excerpts.id, excerpts.excerpt, excerpts.source, persons.person FROM excerpts JOIN persons ON excerpts.person_id = persons.id") # returns array of hashes, each has is a record
    
    delete_secondary_kvpairs(excerpts_array, :placeholder)
    
    return excerpts_array #==> excerpts_array = [{"id"=>"1", "excerpt"=>"sldkjflaskdjfaksldjfaklsdfjasdf", "source"=>"book", "person"=>"Ella Baker"}]
 
  end
  
  # Public: #self.get_all_specific_excerpt_data
  # Creates an array with a hash containing all excerpt info
  #
  # Parameters:
  # id - id of the record sought                    
  #
  # Returns:
  # An array of a hash representing the record asked for
  # 
  # State changes:
  # None    
    
  def self.get_all_specific_excerpt_data(id)
    Excerpt.array_of_excerpt_records.each do |hash|
      if hash["id"] == id.to_i
        return hash
      end
    end
        
  end
    
end