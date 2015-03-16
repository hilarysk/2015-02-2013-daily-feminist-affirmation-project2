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
  
  belongs_to :user
  
  has_many :keyword_items, as: :item  
      
end