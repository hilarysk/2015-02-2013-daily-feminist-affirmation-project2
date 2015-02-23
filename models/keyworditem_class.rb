require_relative "class-module.rb"
require_relative "instance-module.rb"

# Class: KeywordItem
#
# Creates keyword-item pairs
#
# Attributes:
# @keyword_id    - Integer: ID for the keyword (primary key from the keywords table)
# @item_id       - Integer: ID for the item (primary key ID from corresponding table)
# @item_table_id - Integer: ID for the table where the item resides
#
# attr_accessor :item_id, :keyword_id, :item_table_id
#
# Public Methods:
# #insert
# #self.get_array_keywords_for_item
# 
# Private Methods:
# #initialize

class KeywordItem
  extend FeministClassMethods
  include FeministInstanceMethods

  attr_accessor :item_id, :keyword_id, :item_table_id


  # Private: initialize
  # Grabs information for keyword-value pair
  #
  # Parameters:
  # options - Hash
  #           - @item_id       - Instance variable representing the ID of the particular term
  #           - @keyword_id    - Instance variable representing the ID of the keyword
  #           - @item_table_id - Represents table of item
  # Returns:
  # The object
  #
  # State Changes:
  # Sets instance variables @keyword_id, @item_id, @item_table_id
                               
  def initialize(options)
    @keyword_id = options["keyword_id"]
    @item_id = options["item_id"]
    @item_table_id = options["item_table_id"]
  end
  
  # Public: insert
  # Inserts the information collected in initialize into the proper table
  #
  # Parameters:
  # None
  #
  # Returns:
  # None
  #
  # State Changes:
  # None
  
  def insert
    DATABASE.execute("INSERT INTO keywords_items (keyword_id, item_id, item_table_id) VALUES 
                    (#{@keyword_id}, #{@item_id}, #{@item_table_id})")

  end

  # Public: #self.get_array_keywords_for_item
  # Creates an array of all items from persons table
  #
  # Parameters:
  # Options hash
  #             - id_of_item - id for the item you want keywords for
  #             - table-name - name of the table where the item resides                      
  #
  # Returns:
  # An array of all keywords for a particular item
  # 
  # State changes:
  # None
  
  def self.get_array_keywords_for_item(options)
    id_of_item = options["id_of_item"].to_i
    table_name = options["table"].to_s
    
    keywords_array = DATABASE.execute("select keywords.keyword, item_id, items_tables.table_name FROM keywords_items JOIN keywords ON keywords_items.keyword_id = keywords.id JOIN items_tables ON keywords_items.item_table_id = items_tables.id")
    # ==> [{"keyword"=>"Beloved","item_id"=>1, "table_name"=>"excerpts", 0=>"Beloved", 1=>1, 2=>"excerpts"}, {"keyword"=>"United States", "item_id"=>1,"table_name"=>"excerpts", 0=>"United States", 1=>1, 2=>"excerpts"}]
    
    delete_secondary_kvpairs(keywords_array, :placeholder) # ==>keywords_array = [{"keyword"=>"Beloved","item_id"=>1, "table_name"=>"excerpts"}, {"keyword"=>"United States", "item_id"=>1,"table_name"=>"excerpts""}]
    
    keywords = []
    
    keywords_array.each do |hash|
      if hash["item_id"] == id_of_item && hash["table_name"] == "#{table_name}"
        keywords << hash["keyword"]
      end
    end
  
    
    return keywords  #==> ["Beloved", "United States"]
    
  end
    
end