DATABASE = SQLite3::Database.new("/Users/hilarysk/Code/2015-02-13-daily-feminist-affirmation-project/feminist_affirmation.db")

DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS excerpts (id INTEGER PRIMARY KEY, excerpt TEXT, source TEXT, person_id INTEGER, FOREIGN KEY(person_id) REFERENCES persons(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS persons (id INTEGER PRIMARY KEY, person TEXT, bio TEXT, state TEXT, country TEXT, image TEXT, caption TEXT, source TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS quotes (id INTEGER PRIMARY KEY, quote TEXT, person_id INTEGER, FOREIGN KEY(person_id) REFERENCES persons(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS terms (id INTEGER PRIMARY KEY, term TEXT, definition TEXT, phonetic TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS keywords (id INTEGER PRIMARY KEY, keyword TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS keywords_items (keyword_id INTEGER, item_id INTEGER, item_table_id INTEGER, FOREIGN KEY(item_table_id) REFERENCES items_tables(id), FOREIGN KEY(keyword_id) REFERENCES keywords(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS items_tables (id INTEGER PRIMARY KEY, table_name TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, password TEXT)")



# REALLY DON'T THINK I NEED THIS:
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS likes (id INTEGER PRIMARY KEY, user_ip TEXT, item_id INTEGER, item_type TEXT)")







# # KEYWORD MATCHING TABLES
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS keywords_terms (keyword_id INTEGER, term_id INTEGER, FOREIGN KEY(keyword_id) REFERENCES keywords(id), FOREIGN KEY(term_id) REFERENCES terms(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS keywords_quotes (keyword_id INTEGER, quote_id INTEGER, FOREIGN KEY(keyword_id) REFERENCES keywords(id), FOREIGN KEY(quote_id) REFERENCES quotes(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS keywords_excerpts (keyword_id INTEGER, excerpt_id INTEGER, FOREIGN KEY(keyword_id) REFERENCES keywords(id), FOREIGN KEY(excerpt_id) REFERENCES excerpts(id))")
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS keywords_persons (keyword_id INTEGER, person_id INTEGER, FOREIGN KEY(keyword_id) REFERENCES keywords(id), FOREIGN KEY(person_id) REFERENCES persons(id))")
#
#
