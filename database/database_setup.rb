DATABASE = SQLite3::Database.new("/Users/hilarysk/Code/2015-02-13-daily-feminist-affirmation-project/feminist_affirmation.db")

DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS excerpts (id INTEGER PRIMARY KEY, excerpt TEXT, source TEXT, person_id INTEGER, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id), FOREIGN KEY(person_id) REFERENCES people(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS people (id INTEGER PRIMARY KEY, person TEXT, bio TEXT, state TEXT, country TEXT, image TEXT, caption TEXT, source TEXT, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS quotes (id INTEGER PRIMARY KEY, quote TEXT, person_id INTEGER, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id), FOREIGN KEY(person_id) REFERENCES people(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS terms (id INTEGER PRIMARY KEY, term TEXT, definition TEXT, phonetic TEXT, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS keywords (id INTEGER PRIMARY KEY, keyword TEXT, user_id INTEGER, created_at DATETIME, updated_at DATETIME, FOREIGN KEY(user_id) REFERENCES users(id))")




DATABASE.execute("CREATE TABLE IF NOT EXISTS keyword_items (keyword_id INTEGER, item_id INTEGER, item_type TEXT, FOREIGN KEY(keyword_id) REFERENCES keywords(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, user_name TEXT, email TEXT UNIQUE, password_hash TEXT, privilege INTEGER, created_at DATETIME)")
