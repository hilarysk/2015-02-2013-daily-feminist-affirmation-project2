# Module: FeministInstanceMethods
#
# Toolbox for use in the Daily Feminist Affirmation program; contains instance methods that could work for multiple classes.
#
# Public Methods:
# #search_table_by_value
# #save


module FeministInstanceMethods
  
  def get_keywords
    array = []
    self.keyword_items.each do |object|
      array.push object.keyword.keyword 
    end
    
    return array
  end

end