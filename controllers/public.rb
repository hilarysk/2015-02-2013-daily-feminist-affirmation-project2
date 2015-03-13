# LINK TO SEE SPECIFIC ITEM

get "/item" do  ##--> localhost:4567/item?table=quotes&id=4

  if params["table"] == "quotes"
    @item = Quote.where("id = ?", params["id"])[0]
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"quotes", "id_of_item"=>"#{@item.id.to_s}"})

    erb :"public/quote", :layout => :"/alt_layouts/public_layout"

  elsif params["table"] == "excerpts"
    @item = Excerpt..where("id = ?", params["id"])[0]
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"excerpts", "id_of_item"=>"#{@item.id.to_s}"})

    erb :"public/excerpt", :layout => :"/alt_layouts/layout_excerpt"

  elsif params["table"] == "people"
    @item = Person.where("id = ?", params["id"])[0]

    if @item.state != ""
      @item.state = "#{@item.state}, "
    end

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"people", "id_of_item"=>"#{@item.id.to_s}"})

    erb :"public/person", :layout => :"/alt_layouts/public_layout"

  elsif params["table"] == "terms"
    @item = Term.where("id = ?", params["id"])[0]
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"terms", "id_of_item"=>"#{@item.id.to_s}"})

    erb :"public/term", :layout => :"/alt_layouts/public_layout"

  end
  
end

# HOME PAGE

get "/home" do 
  erb :"public/home", :layout => :"alt_layouts/layout_home"
end

# PAGE WITH MAIN CONTENT FOR PUBLIC

get "/yay" do
    
  item = (Quote.all + Term.all + Excerpt.all + Person.all).sample

  if item.class == Quote
    @item = item #==> object of attributes
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"quotes", "id_of_item"=>"#{@item["id"].to_s}"})
    
    erb :"public/quote", :layout => :"/alt_layouts/public_layout"

  elsif item.class == Excerpt
    @item = item
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"excerpts", "id_of_item"=>"#{@item["id"].to_s}"})  
    
    erb :"public/excerpt", :layout => :"/alt_layouts/layout_excerpt"

  elsif item.class == Person
    if item.state != ""
      item.state = "#{item.state}, "
    end
    
    @item = item
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"people", "id_of_item"=>"#{@item["id"].to_s}"})
    
    erb :"public/person", :layout => :"/alt_layouts/public_layout"

  elsif item.class == Term
    @item = item 
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"terms", "id_of_item"=>"#{@item["id"].to_s}"})
    
    erb :"public/term", :layout => :"/alt_layouts/public_layout"
  end
end

#LOADS KEYWORD PAGE

get "/keyword" do
  @keyword = params["keyword"]
  @results = KeywordItem.get_array_items_for_keyword({"keyword"=>"#{@keyword.to_s}"})
  
  erb :"public/keyword/keyword_partials", :layout => :"/alt_layouts/public_layout"
end

#LOADS ABOUT PAGE

get "/about" do
  erb :"public/about", :layout => :"/alt_layouts/public_layout"
end

#LOADS SEARCH PAGE

get "/search" do
  @keywords = Keyword.select("keyword")
  erb :"public/search", :layout => :"/alt_layouts/public_layout"
end