require 'pry'
require 'minitest/autorun'
require "sqlite3"
require_relative "../database/database_setup"
require_relative '../models/term_class.rb'
require_relative '../models/class-module.rb'
require_relative '../models/instance-module.rb'

class DailyFemAffirm < Minitest::Test
  
  def setup
  end


  def test_insert
    DATABASE.execute("DELETE FROM terms")

    term1 = Term.new({"term"=>"Intersectional feminism", "definition"=>"A key component of third-wave
                        feminism, which attempts to view feminism through a variety of other lenses (such
                        as race, socioeconomic status, etc.) instead of through the vaccuum experience of
                        straight, middle-class, able-bodied white women.", "phonetic"=>"asldkfjskdf"})
    term1.insert

    results = DATABASE.execute("SELECT id FROM terms WHERE term = 'Intersectional feminism'")

    assert_equal(1, results[0]["id"])

  end
  
  def test_save
    DATABASE.execute("DELETE FROM terms")
    
    term1 = Term.new({"term"=>"Intersectional feminism", "definition"=>"A key component of third-wave 
                        feminism, which attempts to view feminism through a variety of other lenses (such                          
                        as race, socioeconomic status, etc.) instead of through the vaccuum experience of                          
                        straight, middle-class, able-bodied white women.", "phonetic"=>"sdfsdf"})
    term1.insert
    
    term3 = Term.new({"term"=>"Intersectional blackjlskdf feminism", "definition"=>"A key component of third-wave 
                        feminism, which attempts to view feminism through a variety of other lenses (such                          
                        as race, socioeconomic status, etc.) instead of through the vaccuum experience of                          
                        straight, middle-class, able-bodied white women.", "phonetic"=>"sdfsdf"})
    term3.insert
    
    term2 = Term.new({"term"=>"Intersectional feminizm", "definition"=>"A key component of third-wave 
                        feminism, which attempts to view feminism through a variety of other lenses (such                          
                        as race, socioeconomic status, etc.) instead of through the vaccuum experience of                          
                        straight, middle-class, able-bodied white women.", "phonetic"=>"sdfsdf"})
    term2.save({"table"=>"terms", "item_id"=>"1"})
    
    results = DATABASE.execute("SELECT id FROM terms WHERE term = 'Intersectional feminizm'")
    
    assert_equal(1, results[0]["id"])
    
  end
  
  def test_find_specific_record_unformatted
    DATABASE.execute("DELETE FROM terms")

    term1 = Term.new({"term"=>"abs", "definition"=>"krs.", "phonetic"=>"sdfsdf"})
    term1.insert
    
    results = Term.find_specific_record_unformatted({"table"=>"terms", "field"=>"id", "value"=>"1"})
    
    assert_equal([{"id"=>1, "term"=>"abs", "definition"=>"krs.", "phonetic"=>"sdfsdf", 0=>1, 1=>"abs", 2=>"krs.", 3=>"sdfsdf"}], results)
    
  end
  
  def test_format_find_specific_record
    DATABASE.execute("DELETE FROM terms")

    term1 = Term.new({"term"=>"abs", "definition"=>"krs.", "phonetic"=>"sdfsdf"})
    term1.insert
    
    results = Term.find_specific_record_unformatted({"table"=>"terms", "field"=>"id", "value"=>"1"})
    
    test = Term.format_find_specific_record(results, "terms")
    
    assert_equal("<strong>What is \"abs\"?</strong><br>krs.<br><br>", test)
  end
    
  
  
end



binding.pry 
  
  # def test_list_all_locations
#     DATABASE.execute("DELETE FROM locations")
#
#     l1 = Location.new({"city" => "Omaha"})
#     l2 = Location.new({"city" => "Lincoln"})
#     l3 = Location.new({"city" => "Kearney"})
#     l1.insert("locations")
#     l2.insert("locations")
#     l3.insert("locations")
#     assert_equal(1, Location.all.length)
#   end
  
 
  
  
 
#
# ### CATEGORY TESTS ###
#
#   def test_list_all_categories
#     DATABASE.execute("DELETE FROM categories")
#
#     l1 = Category.new({"name" => "Movie"})
#     l2 = Category.new({"name" => "Book"})
#     l1.insert("categories")
#     l2.insert("categories")
#     assert_equal(2, Category.all.length)
#   end
#
#   def test_category_creation
#     category = Category.new({"name" => "Movie"})
#     category.insert("categories")
#     results = DATABASE.execute("SELECT name FROM categories WHERE id = #{category.id}")
#
#     added_category = results[0]
#
#     assert_equal(1, results.length)
#     assert_equal("Movie", added_category["name"])
#   end
#
# ### PRODUCT TESTS ###
#
#   def test_product_creation
#     product = Product.new({"serial_number" => 4000, "description" => "Name of Product",
#     "quantity" => 30, "cost" => 15, "location_id" => 2, "category_id" => 2})
#     product.insert("products")
#
#     results = DATABASE.execute("SELECT name FROM product WHERE id = #{id}")
#
#     added_product = results[0]
#
#     assert_equal(1, results.length)
#     assert_equal("Name of Product", added_category["name"])
#   end
#
#   def test_list_all_products
#     DATABASE.execute("DELETE FROM products")
#
#     p1 = Product.new({"serial_number" => 4000, "description" => "First Product",
#     "quantity" => 30, "cost" => 15, "location_id" => 2, "category_id" => 2})
#
#     p2 = Product.new({serial_number} => 5000, "description" => "Second Product",
#     "quantity" => 30, "cost" => 15, "location_id" => 1, "category_id" => 3})
#     p1.insert("products")
#     p2.insert("products")
#     assert_equal(2, Product.all.length)
#   end
#
#   def test_find_method
#     location = Location.new({"city" => "Omaha"})
#     category = Category.new({"name" => "Book"})
#     product = Product.new({"serial_number" => 1, "description" => "Hello",
#                             "quantity" => 5, "cost" => 10, "location_id" => 1,
#                             "category_id" => 3})
#
#     location.insert("locations")
#     category.insert("categories")
#     product.insert("products")
#
#     results1 = Product.find("products", 1)
#     results2 = Location.find("locations", 1)
#     results3 = Category.find("categories", 1)
#
#     assert_equal(10, results1.cost)
#     assert_equal("Omaha", results2.city)
#     assert_equal("Book", results3.name)
#   end
#
#   def test_delete_method
#     product1 = Product.new({"serial_number" => 1, "description" => "Hello",
#                             "quantity" => 5, "cost" => 10, "location_id" => 1,
#                             "category_id" => 3})
#
#     product2 = Product.new({"serial_number" => 2, "description" => "Goodbye",
#                             "quantity" => 8, "cost" => 12, "location_id" => 1,
#                             "category_id" => 2})
#
#     product1.insert("products")
#     product2.insert("products")
#
#     Product.delete("products", 1)
#
#     assert_equal(1, Product.all("products").length)
#   end
#
#   def test_save_method
#     product = Product.new({"serial_number" => 1, "description" => "Hello",
#                             "quantity" => 5, "cost" => 10, "location_id" => 1,
#                             "category_id" => 3})
#
#     product.insert("products")
#
#     product.quantity = 10
#
#     product.save("products")
#
#     assert_equal(10, product.quantity)
#   end
#
#   # def test_product_without_enough_info
#   #   DATABASE.execute("DELETE FROM products")
#   #
#   #   p1 = Product.new({"serial_number" => 4000, "description" => "First Product",
#   #   "cost" => 15, "location_id" => 2, "category_id" => 2})
#   #
#   #   p1.insert
#   #   refute_equal(1, Product.all.length)
#   # end
#
#   def test_product_fetching
#     DATABASE.execute("DELETE FROM products")
#
#     p1 = Product.new({"serial_number" => 4000, "description" => "First Product",
#     "quantity" => 30, "cost" => 15, "location_id" => 2, "category_id" => 2})
#
#     p2 = Product.new({serial_number} => 45000, "description" => "Second Product",
#     "quantity" => 30, "cost" => 15, "location_id" => 1, "category_id" => 3})
#
#     p1.insert("products")
#     p2.insert("products")
#
#
#     assert_equal(1, Product.fetch_by("location_id" => 2).length)
#   end
#
