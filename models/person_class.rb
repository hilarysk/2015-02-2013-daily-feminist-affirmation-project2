require_relative "class-module.rb"
require_relative "instance-module.rb"


# Class: Person
#
# Creates different people and gets information about them.
#
# Attributes:
# @person  - String: Name of person
# @id      - Integer: Person ID, primary key for persons table
# @bio     - String: Person's biography
# @state   - String: State where person was born
# @country - String: Country where person was born
# @image   - String: Link to the person's image
# @caption - String: Caption for image
# @source  - String: Source for the biography
#
# attr_reader :id
# attr_accessor :country, :bio, :state, :person, :caption, :image, :source
#
# Public Methods:
# #insert
# #self.array_of_person_records
# 
# Private Methods:
# #initialize

class Person
  extend FeministClassMethods
  include FeministInstanceMethods

  
  attr_reader :id
  attr_accessor :country, :bio, :state, :person, :source, :image, :caption

  # Private: initialize
  # Creates new people
  #
  # Parameters:
  # options - Hash
  #           - @person  - the person's name
  #           - @state   - the person's state
  #           - @bio     - the person's short biography 
  #           - @country - the person's country
  #           - @id      - the person's ID within the table (primary key)
  #           - @image   - a link to the person's image
  #           - @caption - the caption for the image
  #           - @source  - the source of the biography
  #
  # Returns:
  # The object
  #
  # State Changes:
  # Sets instance variables @person, @state, @country, @bio, @id, @image, @caption, @source
                               
  def initialize(options)
    @id = options["id"]
    @person = options["person"]
    @bio = options["bio"]
    @state = options["state"]
    @country = options["country"]
    @image = options["image"]
    @caption = options["caption"]
    @source = options["source"]
    
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
    DATABASE.execute("INSERT INTO persons (person, bio, state, country, image, caption, source) VALUES 
                    ('#{@person}', '#{@bio}', '#{@state}', '#{@country}', '#{@image}', '#{@caption}', '#{@source}')")
    @id = DATABASE.last_insert_row_id
  end
  
  # Public: #self.array_of_person_records
  # Creates an array of all items from persons table
  #
  # Parameters:
  # None                    
  #
  # Returns:
  # An array of all persons records
  # 
  # State changes:
  # None    
  
  def self.array_of_person_records
    persons_array = DATABASE.execute("SELECT id, person, bio, state, country, image, caption, source FROM persons") 
    
    delete_secondary_kvpairs(persons_array, :placeholder)
    
    return persons_array 
 
  end

    
end