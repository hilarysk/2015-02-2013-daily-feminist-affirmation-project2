# Class: Keyword
#
# Creates different keywords and assigns them to an ID
#
# Attributes:
# @keyword - Instance variable representing the actual keyword
# @id      - Instance variable representing the keyword ID within the table (primary key)
#
# attr_reader :id
# attr_accessor :keyword
#
# Public Methods:
# #insert
# #self.get_array_keywords
# 
# Private Methods:
# #initialize

class Keyword < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods

  has_many :keyword_items
  
  has_many :excerpts, :through => :keyword_items, source_type: "Excerpt", source: :item
  has_many :quotes, :through => :keyword_items, source_type: "Quote", source: :item
  has_many :people, :through => :keyword_items, source_type: "Person", source: :item
  has_many :terms, :through => :keyword_items, source_type: "Term", source: :item
  
  def items_array
    array = []
    self.excerpts.each do |object|
      array.push object
    end
    self.quotes.each do |object|
      array.push object
    end
    self.terms.each do |object|
      array.push object
    end
    self.people.each do |object|
      array.push object
    end
    return array
  end
    
end