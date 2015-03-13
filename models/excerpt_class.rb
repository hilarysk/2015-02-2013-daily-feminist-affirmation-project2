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

#     #SOURCE ERRORS
#
#     (DATABASE.execute("SELECT source FROM excerpts")).each do |hash|
#       if hash["source"] == @source
#         @errors["source"] << "That source is already in the system. Please select the existing source from the dropdown menu, instead of typing it in separately."
#       end
#     end
#
#     if @source.is_a?(Integer)
#       @source = @source.to_s
#     end
#
#     # EXCERPT ERRORS
#
#     (Excerpt.find_specific_field_array({"table"=>"excerpts", "field"=>"excerpt"})).each do |curr_excerpt|
#       if curr_excerpt.byteslice(0..30) == @excerpt.byteslice(0...30) || curr_excerpt.byteslice(-30..-1) == @excerpt.byteslice(-30..-1)
#         @errors["excerpt"] << "An existing excerpt already contains part or all of the text you're trying to add."
#       end
#     end
    
    
    
end