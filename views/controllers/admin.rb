enable :sessions 

# MAKES SURE USER IS LOGGED-IN BEFORE ADMIN PAGE WILL LOAD

before "/admin/*" do
  if session[:user_id] == nil
    redirect to ("/login?error=Oops! Looks like you need to login first.")
  end
end

# WHERE USER LOGS IN

get '/login' do
  @fail_message = params["error"]
  erb :"admin/login", :layout => :"/alt_layouts/public_layout" 
end

# CHECKS TO MAKE SURE USER IS IN SYSTEM; IF NOT, RETURNS THEM TO LOGIN PAGE WITH ERROR MESSAGE

get "/user_verification" do
  # pass = BCrypt::Password.create(params["password"])
  user = User.where(username: "#{params["username"]}").take    
  
  if user.password == params["password"]
    session[:user_id] = user.id
    session[:username] = user.username
    redirect to ("/admin/update_database")
  else 
    redirect to ("/login?error=We couldn't find you in the system; please try again.")    
  end
end

# LOADS PAGE WITH ADMINISTRATIVE ACTIONS

get "/admin/update_database" do
  @username = "#{session[:username]}"
  erb :"admin/update_database"
end

# BEFORE METHOD TO SET UP INSTANCE VARIABLES FOR ADDING AND UPDATING EXCERPTS

["/admin/excerpt/new_excerpt", "/admin/excerpt/update_excerpt", "/admin/excerpt/new_success", "/admin/excerpt/update_success"].each do |path|
  before path do
    @person_names_ids = Person.select("id, person")
    @excerpt_sources = Excerpt.select("source")
    
    # IS THIS CHECK NEEDED? DOES THIS OVERWRITE THE BEFORE METHOD ABOVE?
    
    if session[:user_id] == nil
      redirect to ("/login?error=Oops! Looks like you need to login first.")
    end
  end
end

# LOADS ERB TO CREATE NEW EXCERPT

get "/admin/excerpt/new_excerpt" do 
    @path = request.path_info
    
    if params["source"].nil? == false
      @text_array = Excerpt.find_specific_value_array({"table"=>"excerpts", "field_known"=>"source", "value"=>"#{params["source"]}", "field_unknown"=>"excerpt"})
      @excerpt_choice = "/admin/excerpt/_sources_for_new_excerpt"
    end
  
  erb :"admin/excerpt/new_excerpt"
end
  
# LOADS ERB TO UPDATE EXISTING EXCERPT  
    
post "/admin/excerpt/update_excerpt" do
    @path = request.path_info
    
    if params["source"].nil? == false
      @text_array = Excerpt.find_specific_value_array({"table"=>"excerpts", "field_known"=>"source", "value"=>"#{params["source"]}", "field_unknown"=>"excerpt"})
      
      # ^ This needs become this instead: [{"id"=>5, "excerpt"=>"asjdflaksdjflaskdfjalsdfjasdf"}] ??
      
      @excerpt_choice = "/admin/excerpt/_sources_for_update_excerpt"
      
    elsif params["ex_text"].nil? == false #CAN USE HTML5 required  AND VALIDATIONS TO CHECK FOR ERRORS OUTSIDE ROUTE HANDLER
      a = params["ex_text"].gsub('\'','\'\'') #NEED THIS?
      
      info = Excerpt.find_specific_record_unformatted({"table"=>"excerpts", "field"=>"excerpt", "value"=>"#{a}"})
      @new_ex = Excerpt.new(info[0]) # object culled based on excerpt (includes original id)
      @update_erb = "/admin/excerpt/_changes_for_update_excerpt"
    end
    
    erb :"admin/excerpt/update_excerpt"
end

# NEW EXCERPT SUCCESS - !!!!!!!!!!!!! NEED TO PUT ERRORS HERE !!!!!!!!!!!! / AUTO TAG KEYWORDS

post "/admin/excerpt/new_success" do #changed from get
  if params["source"] == ""
    params["source"] = params["source1"]
  end
  
  new_excerpt = Excerpt.new(params)
  new_excerpt.save
  
  # AUTOMATICALLY TAG KEYWORD, SOURCE, PERSON? 

  person1 = Person.find_specific_value({"table"=>"people", "field_known"=>"id", "value"=>"#{params["person_id"].to_s}".to_i, "field_unknown"=>"person"})
  success_message1 = "Your excerpt was successfully added:"
  keywords_message = ""
  
  erb :"/public/keyword/_excerpt_formatting", :locals => {"excerpt"=>"#{new_excerpt.excerpt}", "source"=>"#{new_excerpt.source}", "person"=>"#{person1}", "success_message" => "#{success_message1}", "add_keywords"=>"#{keywords_message}"}
end
     
# UPDATED EXCERPT SUCCESS - !!!!!!!!!!!!! NEED TO PUT ERRORS HERE !!!!!!!!!!!!     
      
post "/admin/excerpt/update_success" do 
  new_excerpt = Excerpt.new(params)
  
  # ERROR CHECK GOES HERE
  
  new_excerpt.save({"table"=>"excerpts", "item_id"=>"#{(params["id"]).to_s}"})
 
  person1 = Person.find_specific_value({"table"=>"people", "field_known"=>"id", "value"=>"{(new_excerpt.person_id).to_s}".to_i, "field_unknown"=>"person"})
  success_message1 = "The excerpt was successfully updated:"
  keywords_message = "<h3><em>Thank you!</em></h3><p>Now, <a href='/assign_tag'>add some keywords</a> to describe this excerpt.</p>"

  erb :"/public/keyword/_excerpt_formatting", :locals => {"excerpt"=>"#{new_excerpt.excerpt}", "source"=>"#{new_excerpt.source}", "person"=>"#{person1}", "success_message" => "#{success_message1}", "add_keywords"=>"#{keywords_message}"}
end




post "/admin/person/new_person" do 
  erb :"admin/person/new_person"
end

post "/admin/person/update_person" do 
  erb :"admin/person/update_person"
end

post "/admin/quote/new_quote" do 
  erb :"admin/quote/new_quote"
end

post "/admin/quote/update_quote" do 
  erb :"admin/quote/update_quote"
end

post "/admin/term/new_term" do 
  erb :"admin/term/new_term"
end

post "/admin/term/update_term" do 
  erb :"admin/term/update_term"
end

post "/admin/tag/new_tag" do 
  erb :"admin/tag/new_tag"
end

post "/admin/tag/assign_tag" do 
  erb :"admin/tag/assign_tag"
end




# BEFORE LOGOUT TO RESET SESSION

before "/logout" do 
  session[:user_id] = nil
  session[:username] = nil
end

# LOGOUT ROUTE ADDS LOGOUT MESSAGE LOADS LOGIN

get "/logout" do
  @logout_message = "You have successfully logged out. Thanks for contributing!"
  erb :"admin/login", :layout => :"/alt_layouts/public_layout" 
end
