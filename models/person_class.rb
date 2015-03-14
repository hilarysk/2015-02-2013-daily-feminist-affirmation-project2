require_relative "class-module.rb"
require_relative "instance-module.rb"


# Class: Person
#
# Creates different people and gets information about them.
#
# Attributes:
# @person  - String: Name of person
# @id      - Integer: Person ID, primary key for people table
# @bio     - String: Person's biography
# @state   - String: State where person was born
# @country - String: Country where person was born
# @image   - String: Link to the person's image
# @caption - String: Caption for image
# @source  - String: Source for the biography
# @errors  - Instance variable representing any errors when trying to create a new object
#
# attr_reader :id, :errors
# attr_accessor :country, :bio, :state, :person, :caption, :image, :source
#
# Public Methods:
# #insert
# #self.array_of_person_records
# 
# Private Methods:
# #initialize

class Person < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods

  has_many :excerpts
  has_many :quotes
  belongs_to :user

  has_many :keyword_items, as: :item
  
  
  
  
  
  
  # Public: #self.array_of_person_records
  # Creates an array of all items from people table
  #
  # Parameters:
  # None                    
  #
  # Returns:
  # An array of all people records
  # 
  # State changes:
  # None    
  
  def self.array_of_person_records
    people_array = DATABASE.execute("SELECT id, person, bio, state, country, image, caption, source FROM people") 
    
    delete_secondary_kvpairs(people_array, :placeholder)
    
    return people_array 
 
  end
  
  # Public: #self.get_all_specific_person_data
  # Creates an array with a hash containing all person info
  #
  # Parameters:
  # id - id of the record sought                    
  #
  # Returns:
  # An array of a hash representing the record asked for
  # 
  # State changes:
  # None    
    
  def self.get_all_specific_person_data(id)
    Person.array_of_person_records.each do |hash|
      if hash["id"] == id.to_i
        return hash
      end
    end
        
  end

    
end