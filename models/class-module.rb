# Module: FeministClassMethods
#
# Toolbox for use in the Daily Feminist Affirmation program; contains class methods that could work for all or most of the classes. 
#
# Public Methods:
# #find_specific_value
# #find_specific_value_array
# #find_specific_field_array
# #find_specific_fields_hashes
# #find_specifc_record_unformatted
# #delete_secondary_kvpairs
# #delete_record
# #exterminate

module FeministClassMethods
  

  
  
  
  
  
  

  # Public: #find_specifc_record_unformatted
  # Pulls a specific row or rows
  #
  # Parameters:
  # options - Hash
  #           - field - the field you want to search
  #           - table - the table you want to search     
  #           - value - The value you want to search                     
  #
  # Returns:
  # An array of hashes representing the records asked for
  # 
  # State changes:
  # None
    
  def find_specific_record_unformatted(options) # NOT FOR KEYWORD TABLES
    table = options["table"]
    field = options["field"]
    value = options["value"] 
    
    if value.is_a?(Array)
        value2 = value.join(" OR #{field} = ") # if looking for all records for specific keyword or user IP
        results = DATABASE.execute("SELECT * FROM #{table} WHERE  #{field} = #{value2}")
        
    else
      if value.is_a?(Integer)
        results = DATABASE.execute("SELECT * FROM #{table} WHERE  #{field} = #{value}")
      else
        results = DATABASE.execute("SELECT * FROM #{table} WHERE  #{field} = '#{value}'")
      end
    end
        
    return results
  end
  
  # Public: #find_specific_fields_hashes
  # Returns specific columns from a given table
  #
  # Parameters:
  # options - Hash
  #           - field1 - the field you want to search
  #           - field2 - the field you want to search
  #           - table - the table you want to search     
  #       
  #
  # Returns:
  # A array of hashes with the key-value pairs for the fields
  #
  # State changes:
  # None
  
  def find_specific_fields_hashes(options)       
    table = options["table"]
    field1 = options["field1"]
    field2 = options["field2"]
    
    
    array = DATABASE.execute("SELECT #{field1}, #{field2} FROM #{table}")
      
    delete_secondary_kvpairs(array, :placeholder)
    
    return array #==> [{"id"=>"1", "person"=>"Toni Morrison"}, {"id"=>"2", "person"=>"Kate Chopin"}]
  end
  
  # Public: #find_specific_field
  # Returns a specific column from a given table
  #
  # Parameters:
  # options - Hash
  #           - field - the field you want to search
  #           - table - the table you want to search     
  #       
  #
  # Returns:
  # A array of values for the field
  #
  # State changes:
  # None
  
  def find_specific_field_array(options)       
    table = options["table"]
    field = options["field"]
    
    array = DATABASE.execute("SELECT #{field} FROM #{table}")
      
    delete_secondary_kvpairs(array, :placeholder)
    
    results = []
    
    array.each do |hash|
      results.push hash["#{field}"]             
    end
    
    return results.uniq # ex: ["The Awakening", "Beloved", "I Am Malala"]
  end
  
  # Public: #find_specific_value
  # Returns a specific value for a given field and table
  #
  # Parameters:
  # options - Hash
  #           - field_known   - the field you want to search
  #           - field_unknown - the field you want the value for
  #           - table         - the table you want to search     
  #           - value         - The value you want to search                
  #       
  #
  # Returns:
  # A specific value
  #
  # State changes:
  # Sets @temp_unknown_value
  
  def find_specific_value(options)       # Could use to find author id for specific quote, then all quotes                                      from that author
    table = options["table"]
    field_known = options["field_known"]
    field_unknown = options["field_unknown"]
    value = options["value"]  
    
    if value.is_a?(Integer)
      array = DATABASE.execute("SELECT #{field_unknown} FROM #{table} WHERE #{field_known} = #{value}")
      
    else 
      array = DATABASE.execute("SELECT #{field_unknown} FROM #{table} WHERE #{field_known} = '#{value}'")
    
    end
      
    if array == []
      return "Sorry, no #{field_unknown} matched your search."
    else
      delete_secondary_kvpairs(array, :placeholder)
      field_unknown_hash = array[0]

      field_unknown_hash.each do |x, y|
        @temp_unknown_value = y
      end

      return @temp_unknown_value
    end
    
  end
  
  # Public: #find_specific_value_array
  # Returns a specific value for a given field and table
  #
  # Parameters:
  # options - Hash
  #           - field_known   - the field you want to search
  #           - field_unknown - the field you want the value for
  #           - table         - the table you want to search     
  #           - value         - The value you want to search                
  #       
  #
  # Returns:
  # A specific value
  #
  # State changes:
  # Sets @temp_unknown_value
  
  def find_specific_value_array(options)       # Could use to find author id for specific quote, then all quotes                                      from that author
    table = options["table"]
    field_known = options["field_known"]
    field_unknown = options["field_unknown"]
    value = options["value"]  
    
    if value.is_a?(Integer)
      array = DATABASE.execute("SELECT #{field_unknown} FROM #{table} WHERE #{field_known} = #{value}")
      
    else 
      array = DATABASE.execute("SELECT #{field_unknown} FROM #{table} WHERE #{field_known} = '#{value}'")
    
    end
    
    value_array = []  
      
    if array == []
      return "Sorry, no #{field_unknown} matched your search."
    else
      delete_secondary_kvpairs(array, :placeholder)
      
      array.each do |hash|
          value_array << hash["#{field_unknown}"]
      end
    end
    
    return value_array
  end
  
    
  # Public: #delete_secondary_kvpairs
  # Gets rid of the safeguard key-value pairs that SQLite auto includes where the key is an integer 
  #
  # Parameters:
  # array_name  - Name of array on which method is being run
  # placeholder - Placeholder text for loop             
  #
  # Returns:
  # The updated array (minus gratuitous key-value pairs)
  
  
  def delete_secondary_kvpairs(array_name, placeholder)    
    array_name.each do |placeholder|
      placeholder.delete_if do |key, value|
        key.is_a?(Integer)
      end
    end
    
    return array_name
    
  end
  

  # Public: #delete_record
  # Deletes record (row) from specific table given specificed id number. We're making them enter id number so that they don't accidentally run it with value stored in @record_id
  #
  # Parameters:
  # options - hash
  #           - table: table where record resides   
  #           - record_id: id number for specific record
  #
  # Returns:
  # Empty array
  
  def delete_record(options)
    table = options["table"]
    record_id = options["record_id"] 
    
    DATABASE.execute("DELETE FROM #{table} WHERE id = #{record_id}")
  end
  
  # Public: #exterminate
  # Permanently deletes a table
  #
  # Parameters:
  # table - name of table to be deleted
  #             
  # Returns:
  # Nil
  
  def exterminate(table)
    DATABASE.execute("DROP TABLE #{table}") 
  end
end
