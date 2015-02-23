require "pry"
require "sqlite3"
require "sinatra"
#
# require 'zucker/instance_variables_from'
# using Zucker::InstanceVariablesFrom

require_relative "models/class-module.rb"
require_relative "models/instance-module.rb"

require_relative "database/database_setup.rb"
require_relative "models/keyworditem_class.rb"
require_relative "models/itemtable_class.rb"

require_relative "models/user_class.rb"
require_relative "models/excerpt_class.rb"
require_relative "models/person_class.rb"
require_relative "models/quote_class.rb"
require_relative "models/term_class.rb"
require_relative "models/keyword_class.rb"



############################################################
#                     SESSION ROUTES                       #
############################################################

enable :sessions

get '/login' do
  erb :login 
end

get "/user_verification" do
  auth = User.user_name_pass_search(params)
  if auth == nil
    @fail_message = "We couldn't find you in the system; please try again." 
    erb :login
  else
    session[:user] = auth
    redirect to ("/user/update_database")
  end
end

get "/user/update_database" do
  @username = "#{session[:user].username}"
  erb :"user/update_database", :layout => :layout_logged_in
end

get "/user/excerpt/new_excerpt" do 
  erb :"user/excerpt/new_excerpt", :layout => :layout_logged_in
end

get "/user/excerpt/update_excerpt" do 
  erb :"user/excerpt/new_excerpt", :layout => :layout_logged_in
end

get "/user/person/new_person" do 
  erb :"user/person/new_person", :layout => :layout_logged_in
end

get "/user/person/update_person" do 
  erb :"user/person/update_person", :layout => :layout_logged_in
end

get "/user/quote/new_quote" do 
  erb :"user/quote/new_quote", :layout => :layout_logged_in
end

get "/user/quote/update_quote" do 
  erb :"user/quote/update_quote", :layout => :layout_logged_in
end

get "/user/term/new_term" do 
  erb :"user/term/new_term", :layout => :layout_logged_in
end

get "/user/term/update_term" do 
  erb :"user/term/update_term", :layout => :layout_logged_in
end

get "/user/tag/new_tag" do 
  erb :"user/tag/new_tag", :layout => :layout_logged_in
end

get "/user/tag/assign_tag" do 
  erb :"user/tag/assign_tag", :layout => :layout_logged_in
end



get "/logout" do
  session[:user] == nil
  @logout_message = "You have successfully logged out. Thanks for contributing!"
  erb :login 
end





############################################################
#                     NORMAL ROUTES                        #
############################################################

get "/home" do 
  erb :home, :layout => :layout_home
end

get "/yay" do
  quotes = Quote.array_of_quote_records
  terms = Term.array_of_term_records
  excerpts = Excerpt.array_of_excerpt_records
  persons = Person.array_of_person_records

  items = quotes + terms + excerpts + persons
  
  item = items.sample


  if item.keys[1] == "quote"
    
    @quote = item["quote"]
    @person = item["person"]
    item_id = item["id"]

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"quotes", "id_of_item"=>"#{item_id.to_s}"})  # ==> [{"keyword"=>"Beloved","item_id"=>1,                                                                                                                                   "table_name"=>"excerpts"}, {"keyword"=>"United States",                                                                                                              "item_id"=>1,"table_name"=>"excerpts"}]
    erb :quote

  elsif item.keys[1] == "excerpt"
   
    @excerpt = item["excerpt"]
    @source = item["source"]
    item_id = item["id"]
    @person = item["person"]

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"excerpts", "id_of_item"=>"#{item_id.to_s}"})  
    
    erb :excerpt, :layout => :layout_excerpt

  elsif item.keys[1] == "person"
    
    @name = item["person"]
    
    if item["state"] == ""
      
      @state = ""
    else
      @state = "#{item["state"]}, "
    end
    
    @country = item["country"]
    @bio = item["bio"]
    @image = item["image"]
    @caption = item["caption"]
    @source = item["source"]
    item_id = item["id"]

    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"persons", "id_of_item"=>"#{item_id.to_s}"})
    
    erb :person

  elsif item.keys[1] == "term"
    
    @term = item["term"]
    @definition = item["definition"]
    @phonetic = item["phonetic"]
    item_id = item["id"]
    
    @keywords = KeywordItem.get_array_keywords_for_item({"table"=>"terms", "id_of_item"=>"#{item_id.to_s}"})
    
    erb :term
    
  end
end

get "/keyword" do
  @keyword = params["keyword"]
  @results = KeywordItem.get_array_items_for_keyword({"keyword"=>"#{@keyword.to_s}"})
  
  erb :keyword_partials
end

get "/about" do
  erb :about
end

get "/search" do
  @keywords = Keyword.get_array_keywords
  erb :search
end

binding.pry