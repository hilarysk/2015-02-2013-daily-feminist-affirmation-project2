require "sqlite3"
require "sinatra"
require "sinatra/session"

require_relative "../../models/class-module.rb"

require_relative "../../models/instance-module.rb"

require_relative "../../database/database_setup.rb"
require_relative "../../models/keyworditem_class.rb"
require_relative "../../models/itemtable_class.rb"

require_relative "../../models/user_class.rb"
require_relative "../../models/excerpt_class.rb"
require_relative "../../models/person_class.rb"
require_relative "../../models/quote_class.rb"
require_relative "../../models/term_class.rb"
require_relative "../../models/keyword_class.rb"

require_relative "admin.rb"



get "/item" do  ##--> localhost:4546/item?table=quotes&id=4

  if params["table"] == "quotes"
    @item = Quote.get_all_specific_quote_data(params["id"])
    
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"quotes", "id_of_item"=>"#{@item["id"].to_s}"})

    erb :"public/quote", :layout => :"/alt_layouts/public_layout"

  elsif params["table"] == "excerpts"
    @item = Excerpt.get_all_specific_excerpt_data(params["id"])

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"excerpts", "id_of_item"=>"#{@item["id"].to_s}"})

    erb :"public/excerpt", :layout => :"/alt_layouts/layout_excerpt"

  elsif params["table"] == "persons"
    @item = Person.get_all_specific_person_data(params["id"])

    if @item["state"] == ""
      @item["state"] = ""
    else
      @item["state"] = "#{@item["state"]}, "
    end

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"persons", "id_of_item"=>"#{@item["id"].to_s}"})

    erb :"public/person", :layout => :"/alt_layouts/public_layout"

  elsif params["table"] == "terms"
    @item = Term.get_all_specific_term_data(params["id"])

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"terms", "id_of_item"=>"#{@item["id"].to_s}"})

    erb :"public/term", :layout => :"/alt_layouts/public_layout"

  end
  
end

get "/home" do 
  erb :"public/home", :layout => :"alt_layouts/layout_home"
end

get "/yay" do
  
  item = (Quote.array_of_quote_records + Term.array_of_term_records + Excerpt.array_of_excerpt_records + Person.array_of_person_records).sample

  if item.keys[1] == "quote"
    @item = item #==> array of attributes

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"quotes", "id_of_item"=>"#{@item["id"].to_s}"})
    
    erb :"public/quote", :layout => :"/alt_layouts/public_layout"

  elsif item.keys[1] == "excerpt"
    @item = item

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"excerpts", "id_of_item"=>"#{@item["id"].to_s}"})  
    
    erb :"public/excerpt", :layout => :"/alt_layouts/layout_excerpt"

  elsif item.keys[1] == "person"
    @item = item
    
    if item["state"] == ""
      @item["state"] = ""
    else
      @item["state"] = "#{item["state"]}, "
    end
    
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"persons", "id_of_item"=>"#{@item["id"].to_s}"})
    
    erb :"public/person", :layout => :"/alt_layouts/public_layout"

  elsif item.keys[1] == "term"
    @item = item 

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"terms", "id_of_item"=>"#{@item["id"].to_s}"})
    
    erb :"public/term", :layout => :"/alt_layouts/public_layout"
    
  end

end

get "/keyword" do
  @keyword = params["keyword"]
  @results = KeywordItem.get_array_items_for_keyword({"keyword"=>"#{@keyword.to_s}"})
  
  erb :"public/keyword/keyword_partials", :layout => :"/alt_layouts/public_layout"
end

get "/about" do
  erb :"public/about", :layout => :"/alt_layouts/public_layout"
end

get "/search" do
  @keywords = Keyword.get_array_keywords
  erb :"public/search", :layout => :"/alt_layouts/public_layout"
end