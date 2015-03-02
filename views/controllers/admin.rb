require "pry"
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

require_relative "public.rb"



enable :sessions # https://github.com/mjackson/sinatra-session, https://github.com/mjackson/sinatra-session/blob/master/lib/sinatra/session.rb

# before "/admin/*" do                # maybe this will work better?
#   if session[:user] == nil
#     @fail_message = "Oops! Looks like you need to login first."
#     erb :login
#   end
# end



# change user/ to admin/ - save "user" for when actually updating users.

get '/login' do
  erb :"admin/login", :layout => :"/alt_layouts/public_layout" 
end


get "/user_verification" do
  auth = User.user_name_pass_search(params)
  if auth == []
    @fail_message = "We couldn't find you in the system; please try again." 
    erb :"admin/login", :layout => :"/alt_layouts/public_layout"
  else
    session[:user] = auth
    redirect to ("/admin/update_database")
  end
end

get "/admin/update_database" do   
  if session[:user] == nil                                         
    @fail_message = "Oops! Looks like you need to login first."  # seems to work, but cookies keep remembering? 
    erb :"admin/login", :layout => :"/alt_layouts/public_layout" # doesn't actaully work unless i clear my cookies/cache
  else
    @username = "#{session[:user].username}"
    erb :"admin/update_database"
  end
end

["/admin/excerpt", "/admin_excerpt_success"].each do |path|
  before path do
    @person_names_ids = Person.find_specific_fields_hashes("field1"=>"id", "field2"=>"person", "table"=>"persons")
    @excerpt_sources = Excerpt.find_specific_field_array({"field"=>"source", "table"=>"excerpts"})
  end
end

get "/admin/excerpt" do 
  if params["action"] == "new"
    @path = request.path_info
    
    if params["source"].nil? == false
      @text_array = Excerpt.find_specific_value_array({"table"=>"excerpts", "field_known"=>"source", "value"=>"#{params["source"]}", "field_unknown"=>"excerpt"})
      @excerpt_choice = "/admin/excerpt/_sources_for_new_excerpt"
    end
  
  erb :"admin/excerpt/new_excerpt", :locals => {"fail" => ""}
    
  elsif params["action"] == "update"
    @path = request.path_info
    
    if params["source"].nil? == false
      @text_array = Excerpt.find_specific_value_array({"table"=>"excerpts", "field_known"=>"source", "value"=>"#{params["source"]}", "field_unknown"=>"excerpt"})
      
      # ^ This needs become this instead: [{"id"=>5, "excerpt"=>"asjdflaksdjflaskdfjalsdfjasdf"}] ??
      
      @excerpt_choice = "/admin/excerpt/_sources_for_update_excerpt"
      
    elsif params["ex_text"].nil? == false
      
      a = params["ex_text"].gsub('\'','\'\'')
      
      info = Excerpt.find_specific_record_unformatted({"table"=>"excerpts", "field"=>"excerpt", "value"=>"#{a}"})
      @new_ex = Excerpt.new(info[0]) # object culled based on excerpt (includes original id)
      @update_erb = "/admin/excerpt/_changes_for_update_excerpt"
    end
    
    erb :"admin/excerpt/update_excerpt"
  end
end


before "/admin/excerpt/success" do  
  if params["action"] = "new"     
    new_excerpt = Excerpt.new(params)
    if new_excerpt.errors != {"source"=>[], "excerpt"=>[]}
      @fail_message = new_excerpt.format_error_messages
      erb :"admin/excerpt/new_excerpt" 
    end
  end 
end
    

post "/admin/excerpt/success" do #changed from get
  if params["action"] == "new"
    if params["source"] == ""
      params["source"] = params["source1"]
    end
    new_excerpt = Excerpt.new(params)
    new_excerpt.insert
    
    # AUTOMATICALLY TAG KEYWORD, SOURCE, PERSON? 

    person1 = Person.find_specific_value({"table"=>"persons", "field_known"=>"id", "value"=>"#{params["person_id"].to_s}".to_i, "field_unknown"=>"person"})
    
    success_message1 = "Your excerpt was successfully added:"
    
    keywords_message = ""
      
  elsif params["action"] == "update"      #SPLIT UP INTO DIFFERENT ROUTE HANDLERS A LA WAREHOUSE MANAGER
    new_excerpt = Excerpt.new(params)
    
    new_excerpt.save({"table"=>"excerpts", "item_id"=>"#{(params["id"]).to_s}"})
   
    person1 = Person.find_specific_value({"table"=>"persons", "field_known"=>"id", "value"=>"{(new_excerpt.person_id).to_s}".to_i, "field_unknown"=>"person"})
    
    success_message1 = "The excerpt was successfully updated:"
    
    keywords_message = "<h3><em>Thank you!</em></h3><p>Now, <a href='/assign_tag'>add some keywords</a> to describe this excerpt.</p>"
    
  end
  erb :"/public/keyword/_excerpt_formatting", :locals => {"excerpt"=>"#{new_excerpt.excerpt}", "source"=>"#{new_excerpt.source}", "person"=>"#{person1}", "success_message" => "#{success_message1}", "add_keywords"=>"#{keywords_message}"}
  
end








get "/admin/person/new_person" do 
  erb :"admin/person/new_person"
end

get "/admin/person/update_person" do 
  erb :"admin/person/update_person"
end

get "/admin/quote/new_quote" do 
  erb :"admin/quote/new_quote"
end

get "/admin/quote/update_quote" do 
  erb :"admin/quote/update_quote"
end

get "/admin/term/new_term" do 
  erb :"admin/term/new_term"
end

get "/admin/term/update_term" do 
  erb :"admin/term/update_term"
end

get "/admin/tag/new_tag" do 
  erb :"admin/tag/new_tag"
end

get "/admin/tag/assign_tag" do 
  erb :"admin/tag/assign_tag"
end


before "/logout" do 
  session[:user] == nil
end

get "/logout" do
  @logout_message = "You have successfully logged out. Thanks for contributing!"
  erb :"admin/login", :layout => :"/alt_layouts/public_layout"
end
