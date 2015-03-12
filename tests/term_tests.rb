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

