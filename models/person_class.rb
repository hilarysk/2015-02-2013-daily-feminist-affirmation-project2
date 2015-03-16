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
    
end