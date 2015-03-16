enable :sessions 

# MAKES SURE USER IS LOGGED-IN BEFORE ADMIN PAGE WILL LOAD

# before "/admin/*" do
  if session[:user_id] == nil
    redirect to ("/login?error=Oops! Looks like you need to login first.")
  end
end

# WHERE USER LOGS IN

get '/login' do
  @fail_message = params["error"]
  erb :"admin/login", :layout => :"/alt_layouts/public_layout" 
end

#FOR WHEN USING RAILS - SENDS EMAIL IF USER FORGETS PASSWORD - NOT VALID YET BC NOT USING RAILS

before "/login-forgot" do
  user = User.find_by(email: params[:email])
  random_password = Array.new(10).map { (65 + rand(58)).chr }.join
  user.password = random_password
  user.save!
  Mailer.create_and_deliver_password_change(user, random_password)
  @message = "Your new, temporary password has been emailed to you."
  erb :"admin/login", :layout => :"/alt_layouts/public_layout"
end

# CHECKS TO MAKE SURE USER IS IN SYSTEM; IF NOT, RETURNS THEM TO LOGIN PAGE WITH ERROR MESSAGE

get "/user_verification" do
  user = User.find_by(email: params["email"])    
  if BCrypt::Password.new(user.password) == params["password"].to_s
    session[:user_id] = user.id
    session[:email] = user.email
    session[:privilege] = user.privilege
    session[:name] = user.user_name
    redirect to ("/admin/update_database")
  else 
    redirect to ("/login?error=We couldn't find you in the system; please try again.")    
  end
end

# BEFORE CREATE NEW USER PAGE LOADS, MAKES SURE PERSON LOGGED IN HAS ENOUGH PRIVILEGE

# ["/admin/create", "/admin/contrib"].each do |path|
#   before path do
#     if session[:privilege].to_i > 1
#       redirect to ("/admin/update_database?error=Looks like you might need to check your privilege; you don't seem to have permission to do that. :(")
#     end
#
#   end
# end

# CREATE NEW USER

get "/admin/create" do
  erb :"/admin/create"
end

# POST CREATE NEW USER - CHECKS FOR ERRORS, SAVES NEW USER

#################################### test that updated_at gets saved

post "/admin/create" do
  new_user = User.new(params)
  new_user.password = params[:password]
  
  if new_user.create
    new_user.updated_at = new_user.created_at #makes so updated_at isn't null
    new_user.save                             #seems like should be better way ....
    redirect to ("/admin/update_database?message=New user successfully created:<br><strong>Name:</strong> #{new_user.user_name}<br><strong>Email:</strong> #{new_user.email}<br><strong>ID:</strong> #{new_user.id}<br><strong>Privilege Level:</strong> #{new_user.privilege}")
  
  else 
    @error_messages = new_user.errors.to_a
    erb :"/admin/create"
  end
end

# LOADS PAGE WITH ADMINISTRATIVE ACTIONS

get "/admin/update_database" do
  if session[:privilege] == 1
    @create_option = "<li><a href='/admin/create'>Add new administrator</a></li>"
    @contrib_option = "<li><a href='/admin/contrib'>See administrator's contributions</a></li>"
  end
  @error = params["error"]
  @message = params["message"]
  @name = "#{session[:name]}"
  erb :"admin/update_database"
end

# SEE LIST OF WHO CONTRIBUTED WHAT

get "/admin/contrib" do 
  @all_admins = User.all
  @path = request.path_info
  
  if params["id"].nil? == false
    @user = User.find_by("id = ?", params["id"])
    @items = @user.items_array_sorted_descending
    @specific_contrib = "/admin/contrib_partial"
  end
  
  erb :"/admin/contrib"
end
  

# BEFORE METHOD TO SET UP INSTANCE VARIABLES FOR ADDING AND UPDATING EXCERPTS

["/admin/excerpt/new_excerpt", "/admin/excerpt/update_excerpt", "/admin/excerpt/new_success", "/admin/excerpt/update_success"].each do |path|
  before path do
    @person_names_ids = Person.select("id, person")
    @excerpt_sources = Excerpt.uniq.pluck("source")
    
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
      @text_array = Excerpt.where("source = ?", params["source"])
      @excerpt_choice = "/admin/excerpt/_sources_for_new_excerpt"
    end
  
  erb :"admin/excerpt/new_excerpt"
end
  
# LOADS ERB TO UPDATE EXISTING EXCERPT 
############################################ test    
get "/admin/excerpt/update_excerpt" do
    @path = request.path_info
    
    if params["source"].nil? == false
      @text_array = Excerpt.where("source = ?", params["source"])
      @excerpt_choice = "/admin/excerpt/_sources_for_update_excerpt"
      
    elsif params["id"].nil? == false #CAN USE HTML5 required  AND VALIDATIONS TO CHECK FOR ERRORS 
      
      info = Excerpt.find_by("id = ?", params["id"])
      @new_ex = Excerpt.new(info)
      @update_erb = "/admin/excerpt/_changes_for_update_excerpt"
    end
    
    erb :"admin/excerpt/update_excerpt"
end

# NEW EXCERPT SUCCESS
########################### can refactor ######################## need to test

post "/admin/excerpt/new_success" do
  if params["source"] == ""
    params["source"] = params["source1"]
  end
  
  params["user_id"] = session[:id]
  
  new_excerpt = Excerpt.new(params)
  
  if new_excerpt.create
    new_excerpt.updated_at = new_excerpt.created_at #seeds updated_at so that not null for comparison
    new_excerpt.save   
    person1 = Person.find_by("id = ?", params["person_id"]).person
    success_message1 = "Your excerpt was successfully added:"
    
    ################### PULL OUT INTO SELF METHOD FOR EACH CLASS ###########################
    
    @source_keyword = Keyword.find_by("keyword = ?", params["source"])
    # If source for the new excerpt isn't already a keyword, it makes a  new one
    if @source_keyword == nil
      @source_keyword = Keyword.create({"keyword" => "#{params["source"]}"})
    end
    # Tags excerpt with source
    KeywordItem.create({"keyword_id"=>@source_keyword.id, "item_type"=>"Excerpt", "item_id"=> new_excerpt.id})
    # Tags excerpt with person
    person_keyword = Keyword.find_by("keyword = ?", new_excerpt.person.person)
    KeywordItem.create({"keyword_id"=>person_keyword.id, "item_type"=>"Excerpt", "item_id"=> new_excerpt.id})
    # Tags excerpt with "excerpt"
    excerpt_keyword = Keyword.find_by("keyword = ?", "excerpt")
    KeywordItem.create({"keyword_id"=>excerpt_keyword.id, "item_type"=>"Excerpt", "item_id"=> new_excerpt.id})
    
    ########################################################################################
   
    # Keyword message      
    @add_keywords = "Your new excerpt was automatically tagged #{@source_keyword}, #{person_keyword} and \"excerpt\"."
  
    erb :"/public/keyword/_excerpt_formatting", :locals => {"excerpt"=>"#{new_excerpt.excerpt}", "source"=>"#{new_excerpt.source}", "person"=>"#{person1}", "success_message" => "#{success_message1}"}
  
  else
    @error_messages = new_excerpt.errors.to_a
    erb :"/admin/excerpt/new_excerpt"
  end
    
end
     
# UPDATED EXCERPT SUCCESS
##################################### need to test   
      
post "/admin/excerpt/update_success" do 
  params["user_id"] = session[:id]
  new_excerpt = Excerpt.new(params) #should include ID since updating, not creating
  
  if new_excerpt.save
    person1 = Person.find_by("id = ?", new_excerpt.person_id)
    success_message1 = "The excerpt was successfully updated:"
    keywords_message = "<h3><em>Thank you!</em></h3><p>Here are the current keywords: #{new_excerpt.get_keywords.join(", ")}.<br><br><a href='/assign_tag'>Add more keywords</a> to describe this excerpt, if you'd like.</p>"
    erb :"/public/keyword/_excerpt_formatting", :locals => {"excerpt"=>"#{new_excerpt.excerpt}", "source"=>"#{new_excerpt.source}", "person"=>"#{person1.person}", "success_message" => "#{success_message1}", "add_keywords"=>"#{keywords_message}"}
  
  else 
    @error_messages = new_excerpt.errors.to_a
    erb :"/admin/excerpt/update_excerpt"
  
  end
end

#### allow to add people and keywords first, then quotes. Terms leave off for now, because don't have good system for IPA? Or include but it's a hassle for user. 





get "/admin/person/new_person" do 
  erb :"admin/person/new_person"
end

post "/admin/person/new_success" do 
  erb :"public/keyword/person_formatting"
end

post "/admin/person/update_person" do 
  erb :"admin/person/update_person"
end

post "/admin/person/update_success" do 
  erb :"public/keyword/person_formatting"
end

post "/admin/quote/new_quote" do 
  erb :"admin/quote/new_quote"
end

post "/admin/quote/new_success" do 
  erb :"public/keyword/quote_formatting"
end

post "/admin/quote/update_quote" do 
  erb :"admin/quote/update_quote"
end
  
post "/admin/quote/update_success" do 
  erb :"public/keyword/quote_formatting"
end

post "/admin/term/new_term" do 
  erb :"admin/term/new_term"
end

post "/admin/term/new_success" do 
  erb :"public/keyword/term_formatting"
end

post "/admin/term/update_term" do 
  erb :"admin/term/update_term"
end

post "/admin/term/update_success" do 
  erb :"public/keyword/term_formatting"
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
  session[:email] = nil
  session[:privilege] = nil
  session[:user_name] = nil
end

# LOGOUT ROUTE ADDS LOGOUT MESSAGE LOADS LOGIN

get "/logout" do
  @logout_message = "You have successfully logged out. Thanks for contributing!"
  erb :"admin/login", :layout => :"/alt_layouts/public_layout" 
end
