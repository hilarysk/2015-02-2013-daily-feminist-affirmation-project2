# Module: FeministClassMethods
#
# Toolbox for use in the Daily Feminist Affirmation program; contains class methods that could work for all or most of the classes. 
#
# Public Methods:



module FeministClassMethods
  
  

  
  
  
  
  
end

module Example
  
  
  # Public: #select_all_names_table
  # Allows a person to find the names of all the items listed for a specific table.
  #
  # Parameters:
  # table - name of table being searched           
  #       
  #
  # Returns:
  # A formatted display of the products from the table that were requested
  #
  # State changes:
  # Sets the @name_array
  #
  # Example: 
  # If the user wants to see all the people included in the app
  
  def select_all_names_table(table)
    array = DATABASE.execute("SELECT name FROM #{table}")
    @name_array = []
    array.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
      hash.each do |key, value|
        @name_array << value
      end
    end
    
    return @name_array.join(", ")
  end
  
  
  
  # Public: #find_record_id
  # Allows a person to find the id for a specific row/rows
  #
  # Parameters:
  # options - Hash
  #           - field      - field: The column where the value in question resides
  #           - table      - table: The specific database table we're searching
  #           - value      - value: The value that identified the specific record/s             
  #       
  #
  # Returns:
  # The requested id/s
  #
  # State changes:
  # Sets @id_array and @record_id

  def find_record_id(options)
    table = options["table"]
    field = options["field"]
    value = options["value"]
    
    if value.is_a?(Integer)
      @id_array = DATABASE.execute("SELECT id FROM #{table} WHERE #{field} = #{value}")
    else
      @id_array = DATABASE.execute("SELECT id FROM #{table} WHERE #{field} = '#{value}'")
    end
    
    value_array = []

    if @id_array == []
      return "Sorry, no #{table} matched your search."
    else
      if @id_array.length > 1
        @id_array.each do |placeholder|
          placeholder.delete_if do |key, value|
            key.is_a?(Integer)
          end
          placeholder.each do |key, value|
            value_array << value
            @record_id = value_array
          end
        end
      else
        @record_id = @id_array[0][0].to_s
      end
      return @record_id
    end
  end 
  
  # Public: #select_products_for_location
  # Allows a person to find the products in a given location
  #
  # Parameters:
  # record_id            
  #       
  #
  # Returns:
  # A list of the products from that location
  #
  # State changes:
  # Sets @location_value_array
  
  def select_products_for_location(record_id)

    array = DATABASE.execute("SELECT * FROM products WHERE location_id = #{record_id}")
    
    if array == []
      return "Sorry, no products matched your search."
    else
      @location_value_array = []
      array.each do |hash|
        hash.delete_if do |key, value|
          key.is_a?(Integer)
        end
        hash.delete_if do |key, value|
          key.include?("i") || key.include?("t")
        end
        hash.each do |key, value|
          @location_value_array << value
        end
      end
      return @location_value_array.join(", ")
    end
    
  end


  # Public: #select_products_for_category
  # Allows a person to find the products in a given category
  #
  # Parameters:
  # record_id            
  #       
  #
  # Returns:
  # A list of the products from that category
  #
  # State changes:
  # Sets @category_value_array

  def select_products_for_category(record_id)

    array = DATABASE.execute("SELECT * FROM products WHERE category_id = #{record_id}")
    
    if array == []
      return "Sorry, no products matched your search."
    else
      @category_value_array = []
      array.each do |hash|
        hash.delete_if do |key, value|
          key.is_a?(Integer)
        end
        hash.delete_if do |key, value|
          key.include?("i") || key.include?("t")
        end
        hash.each do |key, value|
          @category_value_array << value
        end
      end
      
      return @category_value_array.join(", ")
    end

  end
  
  
  # Public: #locate_all_product_info
  # Pulls the name, description, cost, location and category for all products. 
  #
  # Parameters:
  # None            
  #       
  # Returns:
  # Formatted text containing the information.
  #
  # State changes:
  # Sets info1_array2
  
  def locate_all_product_info_loc_or_cat(options)
    field = options["field"]
    id = options["id"]
    

    info1_array = DATABASE.execute("SELECT * FROM products WHERE #{field} = #{id}")
                      

    @info1_array2 = []

    info1_array.each do |hash|
        hash.delete_if do |key, value|
        key.is_a?(String)
      end
      hash.each do |key, value|
        case
        when key == 0
          @info1_array2 << ("<br><br><strong>ID:</strong> #{value.to_s}")
        when key == 1
          @info1_array2 << ("<strong>Name:</strong> #{value.to_s}")
        when key == 4
          @info1_array2 << ("<strong>Description:</strong> \"#{value.to_s}\"")
        when key == 3
          @info1_array2 << ("<strong>Cost:</strong> $#{(sprintf("%.02f", (value * 0.01))).to_s}")
        when key == 2
          @info1_array2 << ("<strong>Quantity:</strong> #{value.to_s}") 
        when key == 5
          @info1_array2 << ("<strong>Serial Number:</strong> #{value.to_s}")# ----------> 
        end
      end

    end

    return @info1_array2.join(";<br>")
  end
  
              # # Public: #select_all_names_table
             #  # Allows a person to find the names of all the items listed for a specific table.
             #  #
             #  # Parameters:
             #  # table - name of table being searched
             #  #
             #  #
             #  # Returns:
             #  # The products from the table that were requested
             #  #
             #  # State changes:
             #  # Sets the @name_array
             #
             #  def return_all_records_table(table)
             #    array = DATABASE.execute("SELECT * FROM #{table}")
             #    @name_array = []
             #    array.each do |hash|
             #      hash.delete_if do |key, value|
             #        key.is_a?(Integer)
             #      end
             #      hash.each do |key, value|
             #        @name_array << value
             #      end
             #    end
             #
             #    return @name_array.join(", ")
             #  end
             #

  # Public: #return_category
  # Returns the category name for a specific product.
  #
  # Parameters:
  # record_id            
  #       
  #
  # Returns:
  # The category name
  #
  # State changes:
  # Sets @temp_cateory_id name and category_id
  
  
  def return_category_id(record_id=nil)
   
     if record_id == nil# if no option is included for record_id in hash 
       record_id = @record_id
     end
 
     category_id_array = DATABASE.execute("SELECT category_id FROM products WHERE id = #{record_id}") 
     
     if category_id_array.empty?
       return "Sorry, we couldn't find an id that matched that category."
     
     else
       delete_secondary_kvpairs(category_id_array, :placeholder)

       category_id_hash = category_id_array[0]

       category_id_hash.each do |x, y|
         @temp_category_id = y
       end
       return @temp_category_id
     end
  end
 
   # Public: #return_category_name
   # Allows a person to find the name of a category given the category's id
   #
   # Parameters:
   # category_id          
   #       
   #
   # Returns:
   # The category's name
   #
   # State changes:
   # Sets @temp_category_name, @temp_category_id
 
 
   def return_category_name(category_id=nil)
   
     if category_id == nil# if no option is included for category_id
       category_id = @temp_category_id
     end

     category_name_array = DATABASE.execute("SELECT name FROM categories WHERE id = #{category_id}") 
     
     if category_name_array == []
       return "Sorry, no categories matched your search."
     else
       delete_secondary_kvpairs(category_name_array, :placeholder)
       category_name_hash = category_name_array[0]

       category_name_hash.each do |x, y|
         @temp_category_name1 = y
         return @temp_category_name1
       end

       return @temp_category_name1
     end
   
   end
   
   # Public: #return_all_location_names
   # Returns names of all locations
   #
   # Parameters:
   # None
   #
   # Returns:
   # Names of the locations
   #
   # State changes:
   # Sets @temp_location_name
   
   def return_all_location_names
     array = DATABASE.execute("SELECT name FROM locations")
     @temp_location_name = []
     
      array.each do |placeholder|
         placeholder.delete_if do |key, value|
           key.is_a?(Integer)
         end
         placeholder.each do |x, y|
         @temp_location_name << y
         end
       end

       return @temp_location_name.join(", ")
     
   end
   
   # Public: #return_all_location_names_ids
   # Returns names of all locations and their IDs
   #
   # Parameters:
   # None
   #
   # Returns:
   # Names and IDs of the locations
   #
   # State changes:
   # Sets @temp_location_name_id
   
   def return_all_location_names_ids
     array = DATABASE.execute("SELECT name, id FROM locations")
     @temp_location_name_id = []
     
      array.each do |placeholder|
       placeholder.delete_if do |key, value|
         key.is_a?(Integer)
       end
       placeholder.each do |x, y|
         if y.is_a?(String)
           y = "Name: " + %Q["#{y}"] 
         else
           y = ", ID: #{y}; <br>"         # 
         end
         @temp_location_name_id << y
       end
      end
    

      return @temp_location_name_id.join("")
     
   end
   
   
   # Public: #return_all_category_names
   # Returns names of all categories
   #
   # Parameters:
   # None
   #
   # Returns:
   # Names of the categories
   #
   # State changes:
   # Sets @temp_category_name
   
   def return_all_category_names
     array = DATABASE.execute("SELECT name FROM categories")
     category_names = []
      array.each do |placeholder|
         placeholder.delete_if do |key, value|
           key.is_a?(Integer)
         end
         placeholder.each do |x, y|
           y = "Name: " + %Q["#{y}"] + "<br>" 
           category_names << y
         end
       end

       return category_names.join("")
     
   end
  
   def return_all_category_names_unformatted
     array = DATABASE.execute("SELECT name FROM categories")
     category_names = []
      array.each do |placeholder|
         placeholder.delete_if do |key, value|
           key.is_a?(Integer)
         end
         placeholder.each do |x, y| 
           category_names << y
         end
       end

       return category_names
     
   end
   
   def return_all_product_serial_nums_unformatted
     array = DATABASE.execute("SELECT serial_num FROM products")
     product_serial_nums = []
      array.each do |hash|
         hash.delete_if do |key, value|
           key.is_a?(Integer)
         end
         hash.each do |key, value| 
           product_serial_nums << value
         end
       end

       return product_serial_nums
     
   end
   
   def return_all_product_names_unformatted
     array = DATABASE.execute("SELECT name FROM products")
     product_names = []
      array.each do |placeholder|
         placeholder.delete_if do |key, value|
           key.is_a?(Integer)
         end
         placeholder.each do |x, y| 
           product_names << y
         end
       end

       return product_names
     
   end
   
   def return_all_location_names_unformatted
     array = DATABASE.execute("SELECT name FROM locations")
     location_names = []
      array.each do |placeholder|
         placeholder.delete_if do |key, value|
           key.is_a?(Integer)
         end
         placeholder.each do |x, y| 
           location_names << y
         end
       end

       return location_names
     
   end
   # Public: #return_all_category_names_ids
   # Returns names of all categories and their IDs
   #
   # Parameters:
   # None
   #
   # Returns:
   # Names and IDs of the categories
   #
   # State changes:
   # Sets @temp_category_name_id
   
   def return_all_category_names_ids
     array = DATABASE.execute("SELECT name, id FROM categories")
     @temp_category_name_id = []
     
      array.each do |placeholder|
       placeholder.delete_if do |key, value|
         key.is_a?(Integer)
       end
       placeholder.each do |x, y|
         if y.is_a?(String)
           y = "Name: " + %Q["#{y}"] 
         else
           y = ", ID: #{y}; <br>"         # 
         end
         @temp_category_name_id << y
       end
      end
    

      return @temp_category_name_id.join("")
     
   end

  # Public: #return_location_id
  # Returns the location id for a specific product.
  #
  # Parameters:
  # record_id            
  #       
  #
  # Returns:
  # The location id
  #
  # State changes:
  # Sets @temp_location_id
  
  def return_location_id(record_id=nil)
    
    if record_id == nil# if no option is included for record_id in hash 
      record_id = @record_id
    end
  
    location_id_array = DATABASE.execute("SELECT location_id FROM products WHERE id = #{record_id}") 
   
    if location_id_array.empty?
      return "Sorry, no locations matched your search."
    else

      delete_secondary_kvpairs(location_id_array, :placeholder)

      location_id_hash = location_id_array[0]

      location_id_hash.each do |x, y|
        @temp_location_id = y
      end

      return @temp_location_id
    end
  end
  
  # Public: #return_location_name
  # Returns the location name for a specific product.
  #
  # Parameters:
  # category_id            
  #       
  #
  # Returns:
  # The location name
  #
  # State changes:
  # Sets @temp_location_name
  
  def return_location_name(location_id=nil)
    if location_id == nil
      location_id = @temp_location_id
      location_name_array = DATABASE.execute("SELECT name FROM locations WHERE id = #{@temp_location_id}") 
    else 
       location_name_array = DATABASE.execute("SELECT name FROM locations WHERE id = #{location_id}") 
    end
      
    if location_name_array == []
      return "Sorry, no locations matched your search."
    else
      delete_secondary_kvpairs(location_name_array, :placeholder)
      location_name_hash = location_name_array[0]

      location_name_hash.each do |x, y|
        @temp_location_name = y
        return @temp_location_name
      end

      return @temp_location_name
    end
    
  end
  
  # Public: #select_all_value_products
  # Adds the value of each product
  #
  # Parameters:
  # options - hash
  #           - table - table you want information for (wouldn't work unless in options hash)
  #
  # Returns:
  # Array containing table information

  def if_bought_one_of_each_item
    results = DATABASE.execute("SELECT cost FROM products")
    
    @total_value = 0
    
    results.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
      hash.keep_if do |key, value|
        key == "cost"
      end
      hash.each do |key, value|
        @total_value += value
      end
    end
    
    return "$" + sprintf("%.02f", (@total_value * 0.01))
  end
  
  
  
  def select_all_value_products
    results = DATABASE.execute("SELECT cost, quantity FROM products")

    @total_value = 0

    results.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
      hash.keep_if do |key, value|
        key == "cost" || key == "quantity"
      end
    end
    
    results.each do |hash|
      @total_value += (hash["cost"] * hash["quantity"])
    end

    return "$" + sprintf("%.02f", (@total_value * 0.01))
    
    
  end
  
  def select_value_products_table(field, id)
    results = DATABASE.execute("SELECT cost, quantity FROM products WHERE #{field} = #{id}")
    
    @total_value = 0

    results.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
      hash.keep_if do |key, value|
        key == "cost" || key == "quantity"
      end
    end
    
    results.each do |hash|
      @total_value += (hash["cost"] * hash["quantity"])
    end

    return "$" + sprintf("%.02f", (@total_value * 0.01))
    
    
  end
  
  
  def select_cost_for_product_table(field, id)
    results = DATABASE.execute("SELECT cost FROM products WHERE #{field} = #{id}")
    
    @total_value = 0
    
    results.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
      hash.keep_if do |key, value|
        key == "cost"
      end
      hash.each do |key, value|
        @total_value += value
      end
    end
    
    return "$" + sprintf("%.02f", (@total_value * 0.01))
  end
  
  
  # Public: #select_all
  # Selects all data from specified table 
  #
  # Parameters:
  # options - hash
  #           - table - table you want information for (wouldn't work unless in options hash)
  #
  # Returns:
  # Array containing table information

  def select_all(options)
    table = options["table"]
    results = DATABASE.execute("SELECT * FROM #{table}")
    return delete_secondary_kvpairs(results, :placeholder) # delete_secondary_kvpairs(results)
  end
  

  # Public: #find
  # Pulls a specific row or rows given the row's ID (primary key) pulled from #find_record_id or provided by argument
  #
  # Parameters:
  # options - Hash
  #           - record_id - id: the id/s for the item/s in question
  #           - table      - table: The specific database table we're searching             
  #
  # Returns:
  # An array of hashes representing the records asked for
  # 
  # State changes:
  # Sets @better_results2
 
  #need to update in case of multiple IDs
    
  def find(options)    # -------------- find specific record
    table = options["table"]
    record_id = options["record_id"] 
    
    if record_id == nil
    
      if @record_id.is_a?(Array)
        record_id = @record_id.join(" OR id = ")
        results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
      else
        record_id = @record_id
        results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
      end
      
      results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
    
    else
      results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
    end
    
    @better_results2 = []

    results.each do |hash|
        hash.delete_if do |key, value|
        key.is_a?(String)
      end
      hash.each do |key, value|
        case
        when key == 0
          @better_results2 << ("<strong>ID:</strong> #{value.to_s}")
        when key == 1
          @better_results2 << ("<strong>Name:</strong> #{value.to_s}")
        when key == 4
          @better_results2 << ("<strong>Description:</strong> \"#{value.to_s}\"")
        when key == 3
          @better_results2 << ("<strong>Cost:</strong> $#{(sprintf("%.02f", (value * 0.01))).to_s}")
        when key == 2
          @better_results2 << ("<strong>Quantity:</strong> #{value.to_s}") 
        when key == 5
          @better_results2 << ("<strong>Serial Number:</strong> #{value.to_s}")# ----------> 
        end
        
      end

    end

    return @better_results2.join(";<br> ")
    
  end
  
  def find_cat_or_loc(options)    # -------------- find specific record
    table = options["table"]
    record_id = options["record_id"] 
    
    if record_id == nil
    
      if @record_id.is_a?(Array)
        record_id = @record_id.join(" OR id = ")
        results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
      else
        record_id = @record_id
        results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
      end
      
      results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
    
    else
      results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
    end
    
    better_results_array = []

    results.each do |hash|
        hash.delete_if do |key, value|
        key.is_a?(String)
      end
      hash.each do |key, value|
        case
        when key == 1
          better_results_array << ("NAME: \"#{value.to_s}\" <br>")
        when key == 2
          better_results_array << ("DESCRIPTION: \"#{value.to_s}\"")
        end
        
      end

    end

    return better_results_array.join("")
    
  end
  

  def return_array_of_cat_record_hashes
    results = DATABASE.execute("SELECT * FROM categories")
    
    results.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
    end
    
    return results
  end
  
  def return_array_of_loc_record_hashes
    results = DATABASE.execute("SELECT * FROM locations")
    
    results.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
    end
    
    return results
  end
    
  def return_array_of_prod_record_hashes
    results = DATABASE.execute("SELECT * FROM products")
    
    results.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
    end
    
    return results
  end
    
  def get_table_info_hash(table, id)
    array = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{id}")
    
    delete_secondary_kvpairs(array, :placeholder)

    return array[0]
  end


  # Public: #find_results_to_objects
  # Transforms #find results into array of objects
  #
  # Parameters:
  # class_name - Name of class with which to instantiate new object/s     
  #
  # Returns:
  # Array of the object/s
  #
  # State changes:
  # Sets @object


  def find_results_to_objects(class_name, array_name=@better_results)

     object_array = []

    if array_name.length >= 2  # if [{"name"=>"fish", "cost"=>10000}, {"name"=>"dog", "cost"=>10000}]
      array_name.each do |hash|
        object_array.push(class_name.new(hash))
        @object = object_array
      end
    else
      record_details = array_name[0] # Hash of the row's details.
      @object = class_name.new(record_details) # Makes object
    end
   
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
