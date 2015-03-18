# LINK TO SEE SPECIFIC ITEM

get "/item" do  ##--> localhost:4567/item?table=quotes&id=4

  if params["table"] == "quotes"
    @item = Quote.find_by("id = ?", params["id"])
    
    if @item == nil
      redirect to ("/whoops")
    end
    
    @keywords = @item.get_keywords
    
    erb :"public/quote", :layout => :"/alt_layouts/public_layout"

  elsif params["table"] == "excerpts"
    @item = Excerpt.find_by("id = ?", params["id"])
    
    if @item == nil
      redirect to ("/whoops")
    end
    
    @keywords = @item.get_keywords
    
    erb :"public/excerpt", :layout => :"/alt_layouts/layout_excerpt"

  elsif params["table"] == "people"
    @item = Person.find_by("id = ?", params["id"])
    
    if @item == nil
      redirect to ("/whoops")
    end

    if @item.state != ""
      @item.state = "#{@item.state}, "
    end

    @keywords = @item.get_keywords

    erb :"public/person", :layout => :"/alt_layouts/public_layout"

  elsif params["table"] == "terms"
   @item = Term.find_by("id = ?", params["id"])
   
    if @item == nil
      redirect to ("/whoops")
    end
    
    @keywords = @item.get_keywords

    erb :"public/term", :layout => :"/alt_layouts/public_layout"

  end
  
end

# ERROR PAGE

get "/whoops" do 
  erb :whoops, :layout => :"/alt_layouts/public_layout"
end

get "/" do
  redirect to ("/home")
end

# HOME PAGE

get "/home" do 
  erb :"public/home", :layout => :"alt_layouts/layout_home"
end

# PAGE WITH MAIN CONTENT FOR PUBLIC WHEN REFRESHED

get "/yay" do 
    
  item = (Quote.all + Term.all + Excerpt.all + Person.all).sample
  
  if item == nil || item.keywords == nil
    
    redirect to ("/whoops")

  elsif item.class == Quote
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






# XHR REQUEST WHEN HIT REAFFIRM BUTTON

# post "/yay" do
#
#   item = (Quote.all + Term.all + Excerpt.all + Person.all).sample
#
#   if item.class == Quote
#     a = item.as_json
#     a["keywords"] = item.get_keywords
#     a.to_json
#     erb :"public/quote", :layout => :"/alt_layouts/public_layout"
#
#   elsif item.class == Excerpt
#     a = item.as_json
#     a["keywords"] = item.get_keywords
#     a.to_json
#
#     erb :"public/excerpt", :layout => :"/alt_layouts/layout_excerpt"
#
#   elsif item.class == Person
#     if item.state != ""
#       item.state = "#{item.state}, "
#     end
#
#     a = item.as_json
#     a["keywords"] = item.get_keywords
#     a.to_json
#
#     erb :"public/person", :layout => :"/alt_layouts/public_layout"
#
#   elsif item.class == Term
#     a = item.as_json
#     a["keywords"] = item.get_keywords
#     a.to_json
#
#     erb :"public/term", :layout => :"/alt_layouts/public_layout"
#   end
# end