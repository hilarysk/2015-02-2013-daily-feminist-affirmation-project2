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



#
# - create error messages if username is the same as an exisiting username
#


enable :sessions # https://github.com/mjackson/sinatra-session, https://github.com/mjackson/sinatra-session/blob/master/lib/sinatra/session.rb

# before "/user/*" do                # maybe this will work better?
#   if session[:user] == nil
#     @fail_message = "Oops! Looks like you need to login first."
#     erb :login
#   end
# end

get '/login' do
  erb :login, :layout => :"/alt_layouts/public_layout" 
end


get "/user_verification" do
  auth = User.user_name_pass_search(params)
  if auth == nil
    @fail_message = "We couldn't find you in the system; please try again." 
    erb :login, :layout => :"/alt_layouts/public_layout"
  else
    session[:user] = auth
    redirect to ("/user/update_database")
  end
end

get "/user/update_database" do   # seems to work, but cookies keep remembering? doesn't actaully work unless i clear my cookies/cache
  if session[:user] == nil
    @fail_message = "Oops! Looks like you need to login first." 
    erb :login, :layout => :"/alt_layouts/public_layout"
  else
    @username = "#{session[:user].username}"
    erb :"user/update_database"
  end
end

["/user/excerpt", "/user_excerpt_success"].each do |path|
  before path do
    @person_names_ids = Person.find_specific_fields_hashes("field1"=>"id", "field2"=>"person", "table"=>"persons")
    @excerpt_sources = Excerpt.find_specific_field_array({"field"=>"source", "table"=>"excerpts"})
  end
end

get "/user/excerpt" do 
  if params["action"] == "new"
    erb :"user/excerpt/new_excerpt"
  elsif params["action"] == "update"
    erb :"user/excerpt/update_excerpt"
  end
end  # here

before "/user/excerpt/success" do 
  @excerpt_check = Excerpt.method_to_check_if_there_is_excerpt_already(params["excerpt"])

  if @excerpt_check == true
    @fail_message = "Hmm, looks like an excerpt nearly indentical to that already exists. Feel free to add a different one, though."
    erb :"user/excerpt/new_excerpt"
  end # else redirect to("/user/excerpt/success")?
end

get "/user/excerpt/success" do  # NOT DONE YET
  # show new excerpt, formatted (use _excerpt_formatting partial) 
  if params["action"] == "update"
    @success_message = "The excerpt was successfully updated:"
    erb :_excerpt_formatting, :locals => {:excerpt => "#{params["excerpt"]}", :author => "#{params["person"]}"}
  else
    @success_message = "Your excerpt was successfully added:"
    erb :_excerpt_formatting, :locals => {:excerpt => "#{params["excerpt"]}", :author => "#{params["person"]}"}
  end
end








get "/user/person/new_person" do 
  erb :"user/person/new_person"
end

get "/user/person/update_person" do 
  erb :"user/person/update_person"
end

get "/user/quote/new_quote" do 
  erb :"user/quote/new_quote"
end

get "/user/quote/update_quote" do 
  erb :"user/quote/update_quote"
end

get "/user/term/new_term" do 
  erb :"user/term/new_term"
end

get "/user/term/update_term" do 
  erb :"user/term/update_term"
end

get "/user/tag/new_tag" do 
  erb :"user/tag/new_tag"
end

get "/user/tag/assign_tag" do 
  erb :"user/tag/assign_tag"
end


before "/logout" do 
  session[:user] == nil
end

get "/logout" do
  @logout_message = "You have successfully logged out. Thanks for contributing!"
  erb :login, :layout => :"/alt_layouts/public_layout"
end
