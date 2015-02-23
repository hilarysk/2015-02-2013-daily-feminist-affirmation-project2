require "pry"

# Module: FeministInstanceMethods
#
# Toolbox for use in the Daily Feminist Affirmation program; contains instance methods that could work for multiple classes.
#
# Public Methods:
# #search_table_by_value
# #save


module FeministInstanceMethods
  
 

  # Public: #save
  # Updates a specific record with changes made
  #
  # Parameters:
  # options - Hash
  #           - table   - The table in which the record resides
  #           - item_id - Exisiting ID for the record we want to update
  #             
  # Returns:
  # An empty array                                                               
                                                                                 
  def save(options)                                                              
    table = options["table"]                                            
    item_id = options["item_id"]
    
    attributes = []
                                                                                 
    instance_variables.each do |i|                                               
      attributes << i.to_s.delete("@")                                           
    end                                                                          
                                                                                 
    query_components_array = []                                                  
                                                                                 
    attributes.each do |a|                                                       
      value = self.send(a)                                                       
                                                                                 
      if value.is_a?(Integer)                                                    
        query_components_array << "#{a} = #{value}"                              
      else                                                                       
        query_components_array << "#{a} = '#{value}'"                            
      end                                                                        
    end                                                                
    
    query_components_array.shift
    
    query_string = query_components_array.join(", ")


    DATABASE.execute("UPDATE #{table} SET #{query_string} WHERE id = #{item_id}")
                                                                                 
  end
  
  

  # Public: #search_table_by_value
  # Allows a person to search a specific table column by its value.
  #
  # Parameters:
  # options - Hash
  #           - field      - field: The column where the value in questions resides
  #           - table      - table: The specific database table we're searching
  #           - value      - value: The value that identified the specific record/s
  #           - class_name - class_name: The Class on which the method is being called to create a new instantiation
  #             
  #             
  #
  # Returns:
  # An empty array

  def search_table_by_value(options)
    field = options["field"]
    table = options["table"]
    value = options["value"]
    class_name = options["class_name"]
    
    if value.is_a?(Integer)
       results = DATABASE.execute("SELECT * FROM #{table} WHERE #{field} = #{value}")
     else
       results = DATABASE.execute("SELECT * FROM #{table} WHERE #{field} = '#{value}'")
     end
    
    results_as_objects = []
    
    results.each do |record| 
      results_as_objects << class_name.new(record)
    end
  end
  
  
  
  
end