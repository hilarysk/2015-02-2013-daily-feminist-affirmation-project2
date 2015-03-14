# LINK TO SEE SPECIFIC ITEM

get "/item" do  ##--> localhost:4567/item?table=quotes&id=4

  if params["table"] == "quotes"
    @item = Quote.find_by("id = ?", params["id"])
    @keywords = @item.get_keywords
    
    erb :"public/quote", :layout => :"/alt_layouts/public_layout"

  elsif params["table"] == "excerpts"
    @item = Excerpt.find_by("id = ?", params["id"])
    @keywords = @item.get_keywords
    
    erb :"public/excerpt", :layout => :"/alt_layouts/layout_excerpt"

  elsif params["table"] == "people"
    @item = Person.find_by("id = ?", params["id"])

    if @item.state != ""
      @item.state = "#{@item.state}, "
    end

    @keywords = @item.get_keywords

    erb :"public/person", :layout => :"/alt_layouts/public_layout"

  elsif params["table"] == "terms"
    @item = Term.find_by("id = ?", params["id"])
    @keywords = @item.get_keywords

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
    @keywords = @item.get_keywords
    
    erb :"public/quote", :layout => :"/alt_layouts/public_layout"

  elsif item.class == Excerpt
    @item = item
    @keywords = @item.get_keywords
    
    erb :"public/excerpt", :layout => :"/alt_layouts/layout_excerpt"

  elsif item.class == Person
    if item.state != ""
      item.state = "#{item.state}, "
    end
    
    @item = item
    @keywords = @item.get_keywords
    
    erb :"public/person", :layout => :"/alt_layouts/public_layout"

  elsif item.class == Term
    @item = item 
    @keywords = @item.get_keywords
    
    erb :"public/term", :layout => :"/alt_layouts/public_layout"
  end
end

#LOADS KEYWORD PAGE

get "/keyword" do
  @keyword = params["keyword"]
  @results = Keyword.find_by("keyword = ?", @keyword).items_array
  
  erb :"public/keyword/keyword_partials", :layout => :"/alt_layouts/public_layout"
end

#LOADS ABOUT PAGE

get "/about" do
  erb :"public/about", :layout => :"/alt_layouts/public_layout"
end

#LOADS SEARCH PAGE

get "/search" do
  @keywords = Keyword.select("keyword").to_a  
  @keywords.delete_if do |object|
    object.keyword == "quote" || object.keyword == "excerpt" || object.keyword == "term" || object.keyword == "person"
  end  
      
  erb :"public/search", :layout => :"/alt_layouts/public_layout"
end