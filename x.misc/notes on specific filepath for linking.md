get "/item/:number" do  ##--> localhost:4546/item/T34
    params[:number]
    a = t
    b = 34
    
    results = database.execute("select * from #{a} where id = #{b}")
    
    if a = terms
      @a = results
      erb :terms
    end

end
  
- create error messages if username is the same as an exisiting username
  

