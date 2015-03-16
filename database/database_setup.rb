configure :development do
 DATABASE = SQLite3::Database.new("/Users/hilarysk/Code/2015-02-13-daily-feminist-affirmation-project/feminist_affirmation.db")
end

unless ActiveRecord::Base.connection.table_exists?(:excerpts)
 ActiveRecord::Base.connection.create_table :excerpts do |t|
 t.text :excerpt
 t.text :source
 t.integer :person_id
 t.integer :user_id
 t.datetime :created_at
 t.datetime :updated_at
 end
end

unless ActiveRecord::Base.connection.table_exists?(:people)
 ActiveRecord::Base.connection.create_table :people do |t|
 t.text :person
 t.text :bio
 t.text :state
 t.text :country
 t.text :image
 t.text :caption
 t.text :source
 t.integer :user_id
 t.datetime :created_at
 t.datetime :updated_at
 end
end

unless ActiveRecord::Base.connection.table_exists?(:quotes)
 ActiveRecord::Base.connection.create_table :quotes do |t|
 t.text :quote
 t.integer :person_id
 t.integer :user_id
 t.datetime :created_at
 t.datetime :updated_at
 end
end

unless ActiveRecord::Base.connection.table_exists?(:terms)
 ActiveRecord::Base.connection.create_table :terms do |t|
 t.text :term
 t.text :definition
 t.text :phonetic
 t.integer :user_id
 t.datetime :created_at
 t.datetime :updated_at
 end
end

unless ActiveRecord::Base.connection.table_exists?(:keywords)
 ActiveRecord::Base.connection.create_table :keywords do |t|
 t.text :keyword
 t.integer :user_id
 t.datetime :created_at
 t.datetime :updated_at
 end
end

unless ActiveRecord::Base.connection.table_exists?(:keyword_items)
 ActiveRecord::Base.connection.create_table :keyword_items do |t|
 t.integer :keyword_id
 t.integer :item_id
 t.text :item_type
 end
end

unless ActiveRecord::Base.connection.table_exists?(:users)
 ActiveRecord::Base.connection.create_table :users do |t|
 t.text :user_name
 t.text :email
 t.text :password_hash
 t.integer :privilege
 t.datetime :created_at
 end
end


# DATABASE = SQLite3::Database.new("/Users/hilarysk/Code/2015-02-13-daily-feminist-affirmation-project/feminist_affirmation.db")

# DATABASE.results_as_hash = true
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS excerpts (id INTEGER PRIMARY KEY, excerpt TEXT, source TEXT, person_id INTEGER, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id), FOREIGN KEY(person_id) REFERENCES people(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS people (id INTEGER PRIMARY KEY, person TEXT, bio TEXT, state TEXT, country TEXT, image TEXT, caption TEXT, source TEXT, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS quotes (id INTEGER PRIMARY KEY, quote TEXT, person_id INTEGER, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id), FOREIGN KEY(person_id) REFERENCES people(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS terms (id INTEGER PRIMARY KEY, term TEXT, definition TEXT, phonetic TEXT, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS keywords (id INTEGER PRIMARY KEY, keyword TEXT, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS keyword_items (keyword_id INTEGER, item_id INTEGER, item_type TEXT, FOREIGN KEY(keyword_id) REFERENCES keywords(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, user_name TEXT, email TEXT UNIQUE, password_hash TEXT, privilege INTEGER, created_at DATETIME)")