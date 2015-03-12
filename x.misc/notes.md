
def his_madness
  psychosis = true
end
#################################################################        



SELECT table1.column_name, table1.column_name2, table1.column_name3, table2.column_name
FROM table1
JOIN table2
ON table1.column_name = table2.column_name;




 =>  keyword    |   item_id    |  item_type
 ------------------------------------------------
    1                  3              2
    1                 3              1
    1                 15             3
    1                 27             4
    1                 27             4
    1                 27             4
    1                


SELECT keywords.keyword, matches.item_id, matches.item_type FROM keywords JOIN matches ON keywords.id = matches.keyword_id
 
 =>  keyword    |   item_id    |  item_table_namee_
 ------------------------------------------------
     term            3              2
     quote           3              1
    toni morrison    15             3
    toni morrison    27             4
    beloved          27             4
    excerpt          27             4
    
 
 SELECT keywords.keyword, matches.item_id, types.name FROM keywords JOIN matches ON keywords.id = matches.keyword_id JOIN types ON types.id = matches.item_type
 
 =>  keyword    |   item_id    |  name
 ------------------------------------------------
     term            3              terms
     quote           3              quotes
    toni morrison    15             person
    toni morrison    27             excerpts
    beloved          27             excerpts
    excerpt          27             excerpts
    
 
----> trying to  
 
 =>  keyword_id   |   terms_id  
 -----------------------------
       1                3        
       1                3        
       1                15       
       1                27       
       1                27       
       1                27       
 
 =>  keyword_id    |   quotes_id  
 -----------------------------
        1             3        
        1             3        
        1             15       
        1             27       
        1             27       
        1             27       
        1         
        
        
        
        =>  keyword    |  excerpt.name   |  excerpt.text | 
        ------------------------------------------------
            term            3              terms
            quote           3              quotes
           toni morrison    15             person
           toni morrison    27             excerpts
           beloved          27             excerpts
           excerpt          27             excerpts
        
 
 
  SELECT keywords.keyword, matches.item_id, types.name FROM keywords JOIN matches ON keywords.id = matches.keyword_id JOIN types ON types.id = matches.item_type
 
 
 
 
 Type table
 ID  name
 1  quotes
 2  terms
 3  people
 4 excerpts
 
 
  <select name="category_id">
  <% @all_category_info_array.each do |hash| %>
  <option value="<%= hash["id"] %>"><%= hash["name"]%></option>
  <% end %>
  </select>
  <br><br>



### Facebook share button:
This: <a href="https://www.facebook.com/sharer/sharer.php?u=example.org" target="_blank">
  (Share button goes here) </a>
  
Or maybe this? <iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2F 
<!-- domain.com goes here --> %2F
<!-- page name goes here -->
&amp;width&amp;layout=standard&amp;action=like&amp;show_faces=true&amp;share=true&amp;height=80&amp;appId=275052925858908" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:80px;" allowTransparency="true"></iframe>
  

From here: https://developers.facebook.com/docs/plugins/share-button
  


______________________________________________________________________________

#*"Should" cases*

* The page should return a random excerpt with each refresh/click of an "Again!" button or something
* The user should be able to share a specific excerpt displayed to social media
* Click author tag to see all excerpts from specific author, information about specific author
* Click book tag to see all excerpts from specific book
* Click category tags to see all excerpts tagged that category
* Let user download the results of a search as jpg or or pdf through use of external gem (IMGKIT? Wicked?) and maybe auto-delete after 30 minutes or something? (Not sure on functional capabilities of either gem yet)

#*"Should not" cases*

* Have authors, excerpts or keywords listed more than once
* Create JPG/PDF to download until user specifically requests one
* Be able to create author without all additional information; same for excerpts
* Be able to assign a value to the author_id field in the excerpts table unless that ID already exists as a primary key in the authors table

#*Extensions*

* Don't repeat until has gone through entire list for specific IP address (use session?)
* Let user log-in with password and be able to edit database (add excerpts, authors, etc.)










