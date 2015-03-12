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
# #self.get_array_items_for_keyword
# 
# Private Methods:
# #initialize
# #grab_table_item_id_for_specific_keyword
# #grab_items_given_id_table_keyword
# #get_person_name_for_keyword_items

class KeywordItem < ActiveRecord::Base
  extend FeministClassMethods
  include FeministInstanceMethods
  
  #??????????????????

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
    
    keywords_array = DATABASE.execute("select keywords.keyword, item_id, item_tables.table_name FROM keyword_items JOIN keywords ON keyword_items.keyword_id = keywords.id JOIN item_tables ON keyword_items.item_table_id = item_tables.id")
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
  
  # Public: #self.get_array_items_for_keyword
  # Creates an array of all items tagged a specific keyword
  #
  # Parameters:
  # options - Hash
  #           - keyword - the keyword for which you want to see items                     
  #
  # Returns:
  # An array of hashes representing the records asked for
  # 
  # State changes:
  # None    
    
  def self.get_array_items_for_keyword(options) # divide sections into separate private methods like secondary_kv_pairs
    keyword_text = options["keyword"].to_s
    
    keywords_array = DATABASE.execute("SELECT keywords.keyword, item_id, item_tables.table_name FROM keyword_items JOIN keywords ON keyword_items.keyword_id = keywords.id JOIN item_tables ON keyword_items.item_table_id = item_tables.id")
    
    delete_secondary_kvpairs(keywords_array, :placeholder) 
    
    item_info_array = grab_table_item_id_for_specific_keyword(keyword_text, keywords_array)
    
    tagged_items = grab_items_given_id_table_keyword(item_info_array)
    
    get_person_name_for_keyword_items(tagged_items)
    
    return tagged_items
    
  end
  
      

  # Private: #grab_table_item_id_for_specific_keyword
  # Creates an array of all items tagged a specific keyword
  #
  # Parameters:
  # keyword - the keyword for which you want to see items  
  # array   - the array of results from a join that needs to be modified                   
  #
  # Returns:
  # An array hashes with item id and table name for the specified keyword
  # 
  # State changes:
  # None   


  def self.grab_table_item_id_for_specific_keyword(keyword, array)
    
    keywords = []
    
    array.each do |hash|
      if hash["keyword"] == "#{keyword}"
        keywords.push({"id"=>"#{hash["item_id"].to_s}", "table_name"=>"#{hash["table_name"].to_s}"})
      end
    end 
    
    return keywords
    
  end
  
  # Private: #grab_items_given_id_table_keyword
  # Creates an array of all items tagged a specific keyword
  #
  # Parameters:
  # array - the array to which the specific item info must be added                 
  #
  # Returns:
  # An array of hashes with item information and table name for the specified keyword
  # 
  # State changes:
  # None 
  
  
  def self.grab_items_given_id_table_keyword(array)
    tagged_items = []
    
    array.each do |hash|
      table_name = "#{hash["table_name"].to_s}"
      item_id = "#{hash["id"]}"
      tagged_items.push(DATABASE.execute("SELECT * FROM #{table_name} WHERE id = #{item_id}"))
    end   
    
    tagged_items.flatten! 
    
    delete_secondary_kvpairs(tagged_items, :placeholder) 
    
    return tagged_items
  end
  
  
  # Private: #get_person_name_for_keyword_items
  # Puts the person name in place of the person id number value if the item in array is a quote or excerpt
  #
  # Parameters:
  # array   - the array of results which needs to be modified                   
  #
  # Returns:
  # An array hashes with all item information and no remaining integer placeholders
  # 
  # State changes:
  # None   
  
  def self.get_person_name_for_keyword_items(array)
    array.each do |hash|
      if hash.keys[1] == "quote" || hash.keys[1] == "excerpt"
        name = DATABASE.execute("SELECT person FROM persons WHERE id = #{hash["person_id"].to_s}") 
      
        hash["person_id"] = name[0]["person"]      
      end
    end
  
    return array
      
  end
  
  
  
  
    
end