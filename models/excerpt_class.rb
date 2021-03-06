# Class: Excerpt
#
# Creates different excerpts and gets information about them.
#
# Attributes:
# @excerpt   - String: Text of Excerpt
# @id        - Integer: Excerpt ID, primary key for excerpts table
# @source    - String: Source of excerpt
# @person_id - Integer: Foreign key linked to ID primary key from people table
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

class Excerpt < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods
  
  belongs_to :person
  belongs_to :user
  
  has_many :keyword_items, as: :item

  validates :excerpt, uniqueness: { case_sensitive: false }
  validates :excerpt, :source, presence: true  
    
end