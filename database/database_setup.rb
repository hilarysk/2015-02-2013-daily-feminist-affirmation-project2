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

# Keyword.create({"user_id"=>1, "keyword"=>"Ella Baker"})
# Keyword.create({"user_id"=>1, "keyword"=>"Ida B. Wells"})
# Keyword.create({"user_id"=>1, "keyword"=>"Barbara Mikulski"})
# Keyword.create({"user_id"=>1, "keyword"=>"Anita Hill"})
# Keyword.create({"user_id"=>1, "keyword"=>"Mildred Jeffrey"})
# Keyword.create({"user_id"=>1, "keyword"=>"Toni Morrison"})
# Keyword.create({"user_id"=>1, "keyword"=>"Mindy Kaling"})
# Keyword.create({"user_id"=>1, "keyword"=>"Gloria Steinem"})
# Keyword.create({"user_id"=>1, "keyword"=>"Malala Yousafzai"})
# Keyword.create({"user_id"=>1, "keyword"=>"Audre Lorde"})
# Keyword.create({"user_id"=>1, "keyword"=>"Lupita Nyong`o"})
# Keyword.create({"user_id"=>1, "keyword"=>"Sarah Silverman"})
# Keyword.create({"user_id"=>1, "keyword"=>"Virginia Woolf"})
# Keyword.create({"user_id"=>1, "keyword"=>"Amy Poehler"})
# Keyword.create({"user_id"=>1, "keyword"=>"Alberta Williams King"})
# Keyword.create({"user_id"=>1, "keyword"=>"Kirsten Gillibrand"})
# Keyword.create({"user_id"=>1, "keyword"=>"Fannie Lou Hamer"})
# Keyword.create({"user_id"=>1, "keyword"=>"Dolores Huerta"})
# Keyword.create({"user_id"=>1, "keyword"=>"Christine de Pizan"})
# Keyword.create({"user_id"=>1, "keyword"=>"Juana Inés de la Cruz"})
# Keyword.create({"user_id"=>1, "keyword"=>"Fannie Lou Hamer"})
# Keyword.create({"user_id"=>1, "keyword"=>"Julie Ruin"})
# Keyword.create({"user_id"=>1, "keyword"=>"Pakistan"})
# Keyword.create({"user_id"=>1, "keyword"=>"book"})
# Keyword.create({"user_id"=>1, "keyword"=>"song"})
# Keyword.create({"user_id"=>1, "keyword"=>"Beloved"})
# Keyword.create({"user_id"=>1, "keyword"=>"comedian"})
# Keyword.create({"user_id"=>1, "keyword"=>"person"})
# Keyword.create({"user_id"=>1, "keyword"=>"excerpt"})
# Keyword.create({"user_id"=>1, "keyword"=>"quote"})
# Keyword.create({"user_id"=>1, "keyword"=>"term"})
# Keyword.create({"user_id"=>1, "keyword"=>"Kimberlé Crenshaw"})
# Keyword.create({"user_id"=>1, "keyword"=>"history"})
# Keyword.create({"user_id"=>1, "keyword"=>"Julie Ruin"})
# Keyword.create({"user_id"=>1, "keyword"=>"author"})
# Keyword.create({"user_id"=>1, "keyword"=>"civil rights"})
# Keyword.create({"user_id"=>1, "keyword"=>"politics"})
# Keyword.create({"user_id"=>1, "keyword"=>"LGBTQ"})
# Keyword.create({"user_id"=>1, "keyword"=>"labor"})
# Keyword.create({"user_id"=>1, "keyword"=>"United States"})
# Keyword.create({"user_id"=>1, "keyword"=>"people of color"})
# Keyword.create({"user_id"=>1, "keyword"=>"The Indelicates"})
# Keyword.create({"user_id"=>1, "keyword"=>"Kate Chopin"})
# Keyword.create({"user_id"=>1, "keyword"=>"The Awakening"})
#
# Person.create({"user_id"=>1, "person"=>"Ella Baker", "bio"=>"Ella Jo Baker was born on Dec. 13, 1903, in Norfolk, Virginia, though she grew up in North Carolina. The pride and resilience of her grandmother, a former slave, in the face of racism and injustice, inspired Ms. Baker throughout her life. She studied at Shaw University in Raleigh, North Carolina, starting at age 15. After graduating as valedictorian, she moved to create York City and joined joined the Young Negroes Cooperative League, whose purpose was to develop black economic power through collective planning. She also involved herself with several women''s organizations. <br><br>Ms. Baker worked for the NAACP from 1940 to 1946, and helped organize Martin Luther King''s then-create organization, the Southern Christian Leadership Conference, or SCLC. She left SCLC after the first lunch counter sit-in protest in April 1960 to help found the Student Nonviolent Coordinating Committee, or SNCC. In 1964, SNCC helped create Freedom Summer, an effort to focus national attention on Mississippi''s racism and to register black voters. With Ella Baker''s guidance and encouragement, SNCC became one of the foremost advocates for human rights in the country. <br><br>Ella Baker once said, \"This may only be a dream of mine, but I think it can be made real.\"", "state"=>"Virginia", "country"=>"United States", "image"=>"http://ellabakercenter.org/sites/default/files/site/media/ella3.gif", "caption"=>"Courtesy of the Ella Baker Center for Human Rights", "source"=>"<a href=\"http://ellabakercenter.org/about/who-was-ella-baker\">The Ella Baker Center for Human Rights</a>"})
# Person.create({"user_id"=>1, "person"=>"Barbara Mikulski", "bio"=>"Born in 1936, Barbara Mikulski grew up in East Baltimore as the daughter of a grocer. She graduated from Mount St. Agnes College in 1958 and earned a master''s degree in social work from the University of Maryland in 1965. <br><br>In 1976, she won a seat in the U.S. House of Representatives. In 1986, Mikulski became the first female Democrat to win election to the Senate. She is currently the longest-serving woman senator. <br><br>Mikulski advocated for legislation to protect children and supported the Equal Rights Amendment. Over the years, Mikulski has worked on behalf of women''s issues, including legislation to get breast and cervical cancer screenings and treatment for the uninsured. <br><br>After winning her reelection bid in 2011, Mikulski is doing her best to bring more women into the Senate.", "state"=>"Maryland", "country"=>"United States", "image"=>"http://bioguide.congress.gov/bioguide/photo/m/m000702.jpg", "caption"=>"Photo via Congress.gov", "source"=>"<a href=\"http://www.biography.com/people/barbara-mikulski-20771233#political-career\">Biography.com</a>"})
# Person.create({"user_id"=>1, "person"=>"Anita Hill", "bio"=>"In the fall of 1991, a young law professor found herself at the center of a media storm of almost unprecedented proportions. Burdened with information that could determine the future of a Supreme Court nomination, Professor Hill''s experience changed the way we view sexual harassment, gender, and the judicial confirmation process. <br><br>A teacher, speaker, researcher and writer, Anita Hill has earned international prominence as an authority on race and gender issues, especially as they affect the workplace. Hill received her law degree from Yale University, and, after a stint at the Equal Employment Opportunity Commission (EEOC), she began teaching law at the University of Oklahoma. <br><br>In 1991, Hill testified that Supreme Court nominee Clarence Thomas had made unwelcome sexual advances while he was her supervisor at the EEOC in the 1980s. Although Thomas''s appointment was subsequently confirmed, Hill''s testimony brought the issue of sexual harassment to public attention, forever changing relations between men and women in the workplace. <br><br>In 1997, Hill published <em>Speaking Truth to Power</em>, a personal memoir and study of her involvement in the Thomas hearings. A documentary about this time, <em>Anita</em>, was released in 2013.", "state"=>"Oklahoma", "country"=>"United States", "image"=>"https://c1.staticflickr.com/3/2943/15343133981_d983bf8cb0_h.jpg", "caption"=>"Photo by <a href=\"https://www.flickr.com/photos/qwrrty/15343133981/\">Tim Pierce</a>", "source"=>"<a href=\"http://www.allamericanspeakers.com/speakers/Anita-Hill/722\">All American Speakers</a>"})
# Person.create({"user_id"=>1, "person"=>"Ida B. Wells", "bio"=>"The oldest of eight children, Ida B. Wells was born in Holly Springs, Mississippi. Wells attended Rust College and then became a teacher in Memphis, Tennessee. <br><br>Shortly after she arrived, Wells was involved in an altercation with a white conductor while riding the railroad. She had purchased a first-class ticket, and was seated in the ladies car when the conductor ordered her to sit in the Jim Crow (i.e. black) section, which did not offer first-class accommodations. She refused and when the conductor tried to remove her, she \"fastened her teeth on the back of his hand.\" <br><br>Wells was ejected from the train, and she sued. She won her case in a lower court, but the decision was reversed in an appeals court.<br><br>While living in Memphis, Wells became a co-owner and editor of a local black createspaper called THE FREE SPEECH AND HEADLIGHT. She condemned violence against blacks, disfranchisement, poor schools, and the failure of black people to fight for their rights. She was fired from her teaching job and became a full-time journalist. <br><br>When Wells was out of town, her createspaper was destroyed by a mob and she was warned not to return to Memphis because her life was in danger. Wells took her anti-lynching campaign to England and was well-received. <br><br>In 1895 she married Ferdinand Barnett, a prominent Chicago attorney. The following year she helped organize the National Association of Colored Women. In 1909, she helped found the National Association for the Advancement of Colored People. Wells-Barnett continued her fight for black civil and political rights and an end to lynching until shortly before she died.", "state"=>"Mississippi", "country"=>"United States", "image"=>"http://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Mary_Garrity_-_Ida_B._Wells-Barnett_-_Google_Art_Project_-_restoration_crop.jpg/840px-Mary_Garrity_-_Ida_B._Wells-Barnett_-_Google_Art_Project_-_restoration_crop.jpg", "caption"=>"Photo by public domain", "source"=>"<a href=\"http://www.pbs.org/wnet/jimcrow/stories_people_wells.html\">PBS</a>"})
# Person.create({"user_id"=>1, "person"=>"Mildred Jeffrey", "bio"=>"Mildred Jeffrey was an influential behind-the-scenes combatant in the women''s, labor and civil rights movements for seven decades. <br><br>She was born on Dec. 29, 1910, in Alton, Iowa, the eldest of seven children. Her grandmother, a widow, ran a farm and raised 16 children by herself. Her mother, who was the first woman to become a registered pharmacist in Iowa, in 1908, raised seven children on her own after her husband left the family. <br><br>As a student at the University of Minnesota in the early 1930''s, [Jeffrey] and an African-American classmate helped integrate restaurants in Minneapolis. Decades later, she marched in the South with the Rev. Dr. Martin Luther King Jr. She was also a founder of the National Women''s Political Caucus in 1971. <br><br>In 2000, President Bill Clinton awarded her the Presidential Medal of Freedom, the nation''s highest civilian honor.", "state"=>"Iowa", "country"=>"United States", "image"=>"http://www.uaw.org/sites/default/files/women_jeffrey_page.jpg", "caption"=>"Photo via the United Auto Workers", "source"=>"<a href=\"http://www.nytimes.com/2004/04/05/us/mildred-jeffrey-93-activist-for-women-labor-and-liberties.html\">create York Times</a>"})
# Person.create({"user_id"=>1, "person"=>"Gloria Steinem", "bio"=>"Groundbreaking writer, lecturer, editor and activist, Gloria Steinem has been looked to as the popular face of the women''s movement for over four decades. She was a buzzed-about journalist in the late-60s, when her political conscience compelled her to the growing feminist movement and made her one of its most visible and effective leaders. <br><br>She co-founded Ms. magazine in 1972, and has spent decades crisscrossing the United States and the world as a speaker and organizer. <br><br>She has been a controversial, good-humored, and inescapable public conscience on issues of equality and social justice. She has expanded the women’s movement to celebrate non-violent conflict resolution, the cultures of indigenous peoples, and organization across socioeconomic boundaries. <br><br>Steinem probes and lays bare the workings of gender roles, of sex and race caste systems, and of child abuse as roots of violence. She is a Phi Beta Kappa graduate of Smith College and an Inductee of the National Women’s Hall of Fame. <br><br>Gloria Steinem is a 2005 Founder of the Women’s Media Center. She lives in create York City.", "state"=>"Ohio", "country"=>"United States", "image"=>"http://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Gloria_Steinem_at_creates_conference%2C_Women%27s_Action_Alliance%2C_January_12%2C_1972.jpg/402px-Gloria_Steinem_at_creates_conference%2C_Women%27s_Action_Alliance%2C_January_12%2C_1972.jpg", "caption"=>"Photo via the U.S. Library of Congress", "source"=>"<a href=\"http://www.makers.com/gloria-steinem\">PBS</a>"})
# Person.create({"user_id"=>1, "person"=>"Malala Yousafzai", "bio"=>"Malala Yousafzai is a widely respected Pakistani rights activist and Nobel Peace Prize winner who has fought to promote education for girls - a struggle that resulted in the Taliban attempting to take her life in 2012.<br><br>Raised in the town of Mingora, in Pakistan’s Swat Valley, Yousafzai came to prominence as a teenager in 2009, when the valley was under the control of the local chapter of the Tehreek-e-Taliban Pakistan (TTP). The TTP-Swat enforced a strict interpretation of Islam in the valley, ruling with an iron fist. One of its many edicts enforced a complete ban on women’s education.<br><br>In January 2009, Yousafzai began to keep a diary for the BBC’s Urdu service, in which she detailed how she had been affected by the Taliban’s rule. <br><br>Her outspoken nature led to threats against her and her father, a prominent local educationalist, and on October 9, 2012, years after they had been driven out of the valley, the TTP attacked Yousafzai’s school van, shooting her in the head and badly wounding Kainat Riaz, a fellow classmate. Both survived, but were severely wounded. <br><br>Since the shooting, Yousafzai has continued to live in Birmingham with her family, due to continuing threats against their lives, and has ramped up her activism for children’s right to education, especially in conflict zones such as her native Pakistan and, among other places, Nigeria.<br><br>In 2013, Yousafzai founded the Malala Fund, a non-governmental organisation that works with governments and organisations around the world to provide girls with access to education. On October 10, 2014, the Nobel Prize committee jointly awarded her the Nobel Peace Prize, alongside Kailash Satyarthi, an Indian rights and labour activist. <br><br>At 17, Yousufzai become the youngest ever person to be awarded the prestigious prize.", "state"=>"", "country"=>"Pakistan", "image"=>"http://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Malala_Yousafzai_at_Girl_Summit_2014.jpg/360px-Malala_Yousafzai_at_Girl_Summit_2014.jpg", "caption"=>"Photo by Russell Watkins, <a href=\"https://www.flickr.com/photos/dfid/14714344864/\">Department for International Development</a>", "source"=>"<a href=\"http://www.aljazeera.com/creates/asia/2012/10/2012109123345472153.html\">Al-Jazeera</a>"})
# Person.create({"user_id"=>1, "person"=>"Kate Chopin", "bio"=>"Born in 1850, American author Kate Chopin wrote two published novels and about a hundred short stories in the 1890s. Most of her fiction is set in Louisiana and most of her best-known work focuses on the lives of sensitive, intelligent women.<br><br>Her short stories were well received in her own time and were published by some of America’s most prestigious magazines—Vogue, the Atlantic Monthly, Harper’s Young People, Youth’s Companion, and the Century. By the late 1890s, Kate Chopin was well known among American readers of magazine fiction.<br><br>Her early novel, \"At Fault,\" had not been much noticed by the public, but \"The Awakening\" was widely condemned. Critics called it morbid, vulgar, and disagreeable. Willa Cather, who would become a well known twentieth-century American author, labeled it trite and sordid.<br><br>Chopin’s novels were mostly forgotten after her death in 1904, but in the 1920s her short stories began to appear in anthologies, and slowly people again came to read her. In the 1930s a Chopin biography appeared which spoke well of her short fiction but dismissed The Awakening as unfortunate. However, by the 1950s scholars and others recognized that the novel is an insightful and moving work of fiction. Such readers set in motion a Kate Chopin revival, one of the more remarkable literary revivals in the United States.<br><br>She is today understood as a classic writer who speaks eloquently to contemporary concerns. \"The Awakening,\" \"Désirée’s Baby,\" \"A Pair of Silk Stockings,\" \"A Respectable Woman,\" and other stories appear in countless editions and are embraced by people for their sensitive, graceful, poetic depictions of women’s lives.", "state"=>"Missouri", "country"=>"United States", "image"=>"http://www.katechopin.org/wp-content/uploads/2014/10/kateimage300.jpg", "caption"=>"Courtesy of the Kate Chopin International Society", "source"=>"<a href=\"http://www.katechopin.org/biography/\">The Kate Chopin International Society</a>"})
# Person.create({"user_id"=>1, "person"=>"Toni Morrison", "bio"=>"Born Chloe Anthony Wofford, in 1931 in Lorain (Ohio), the second of four children in a black working-class family. Displayed an early interest in literature. Studied humanities at Howard and Cornell Universities, followed by an academic career at Texas Southern University, Howard University, Yale, and since 1989, a chair at Princeton University. <br><br>She has also worked as an editor for Random House, a critic, and given numerous public lectures, specializing in African-American literature. <br><br>She made her debut as a novelist in 1970, soon gaining the attention of both critics and a wider audience for her epic power, unerring ear for dialogue, and her poetically-charged and richly-expressive depictions of Black America. <br><br>A member since 1981 of the American Academy of Arts and Letters, she has been awarded a number of literary distinctions, among them the Pulitzer Prize in 1988.", "state"=>"Ohio", "country"=>"United States", "image"=>"http://upload.wikimedia.org/wikipedia/commons/0/04/Toni_Morrison_2008-2.jpg", "caption"=>"Angela Radulescu / CC-BY-SA-3.0", "source"=>"From Nobel Lectures, Literature 1991-1995, Editor Sture Allén, World Scientific Publishing Co., Singapore, 1997"})
# Person.create({"user_id"=>1, "person"=>"Dolores Huerta", "bio"=>"Dolores Huerta is a union leader and an activist for the rights of farm workers and women. Along with Cesar Chavez, she founded the first successful farm workers union in the country, the United Farm Workers, in 1962. She is a recipient of the Presidential Medal of Freedom.<br><br>Huerta was born in create Mexico in 1930, where her father was a union activist and state legislator. Following her parents divorce, Dolores moved with her mother to California’s farm-filled San Joaquin Valley. <br><br>She was inspired to fight for workers rights when, as a young school teacher, she noticed that many of her students were showing up to school ill or malnourished. She founded the Agricultural Workers Association in 1960 and used the organization to lobby politicians on a variety of issues pertaining to the rights of migrant workers. She left the AWA just two years later, when she and Cesar Chavez founded what would come to be known as the United Farm Workers union.<br><br>Often she risked life and limb in order to ensure the rights of farm workers — in 1988, a San Francisco police officer beat her so badly that she was left with several broken ribs and a ruptured spleen.<br><br> Huerta has since stepped down from her position at the UFW, but she continues to lecture on worker’s issues and women’s issues around the country. In addition to the Presidential Medal of Freedom, she has received numerous awards and recognitions—among them the Eleanor Roosevelt Humans Rights Award from President Clinton in l998, the Ohtli award from the Mexican Government, and nine honorary doctorates from Universities throughout the United States.", "state"=>"create Mexico", "country"=>"United States", "image"=>"http://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Dolores_Huerta.jpg/303px-Dolores_Huerta.jpg", "caption"=>"Photo by <a href=\"http://www.flickr.com/photos/33977223@N08/3584728514\">Eric Guo</a>", "source"=>"<a href=\"http://www.makers.com/dolores-huerta\">PBS</a>"})
#
# Quote.create({"user_id"=>1, "quote"=>"The stuggle is eternal. The tribe increase. Somebody else carries on.", "person_id"=>"1"})
# Quote.create({"user_id"=>1, "quote"=>"I think people are well aware that they have a right to come forward [about sexual harassment]. But many people have a fear that the processes will not give them a fair hearing. Even for those who complain, I think we’ve fallen down in terms of the investigative process. We still have a lot of challenges in terms of making sure that the people who are found guilty of harassment suffer the consequences of their behavior.", "person_id"=>"3"})
# Quote.create({"user_id"=>1, "quote"=>"My underlying goal was always to empower women. Get them to learn their rights, and to exercise them!", "person_id"=>"5"})
# Quote.create({"user_id"=>1, "quote"=>"Though we have the courage to raise our daughters more like our sons, we''ve rarely had the courage to raise our sons more like our daughters.", "person_id"=>"6"})
# Quote.create({"user_id"=>1, "quote"=>"We cannot all succeed when half of us are held back.", "person_id"=>"7"})
#
# Excerpt.create({"user_id"=>1, "excerpt"=>"And if she thought anything, it was No. No. Nono. Nonono. Simple. She just flew. Collected every bit of life she had made, all the parts of her that were precious and fine and beautiful, and carried, pushed, dragged them through the veil, out, away, over there where no one could hurt them. Over there. Outside this place, where they would be safe.", "source"=>"Beloved", "person_id"=>"9"})
# Excerpt.create({"user_id"=>1, "excerpt"=>"I would give up the unessential; I would give up my money, I would give up my life for my children; but I wouldn''t give myself. I can''t make it more clear; it''s only something I am beginning to comprehend, which is revealing itself to me.", "source"=>"The Awakening", "person_id"=>"8"})
# Excerpt.create({"user_id"=>1, "excerpt"=>"We liked to be known as the clever girls. When we decorated our hands with henna for holidays and weddings, we drew calculus and chemical formulae instead of flowers and butterflies.", "source"=>"I Am Malala: The Girl Who Stood Up for Education and Was Shot by the Taliban", "person_id"=>"7"})
# Excerpt.create({"user_id"=>1, "excerpt"=>"She sometimes feels that her years as a man junkie took irreplaceable time away from her music, and wonders what women could be if, as she puts it, ''We stopped taking care of men so they will take care of us - and put the same amount of time into taking care of ourselves.''", "source"=>"Revolution From Within: A Book of Self-Esteem", "person_id"=>"6"})
#
#
#
# Term.create({"user_id"=>1, "term"=>"intersectional feminism", "definition"=>"Coined by black legal scholar Kimberlé Crenshaw in 1989, \"intersectionality\" refers to the intersections of different forms or systems of oppression. For modern feminism, it means bringing groups of women to the table who have often been marginalized by mainstream feminist movements, and by recognizing that the difficulties women of color face, or women with disabilities, or LGBTQ women, or poor women face can be very different than those faced by white, able-bodied, straight, middle-class women; and that their voices must no longer be silenced, and their struggles no longer ignored. Essentially, it''s the idea that there is no \"one size fits all\" feminism.", "phonetic"=>"ˌɪntərˈsɛkʃən(ə)l ˈfɛmɪˌnɪzəm"})
# Term.create({"user_id"=>1, "term"=>"lived experience", "definition"=>"As contrasted with observed experience, \"lived experience\" refers to the experiences of people who live as members of a minority or oppressed group. People often discount the struggles women face simply because the outsider has no firsthand experience with such struggles, and so therefore, they don''t believe that they happen.", "phonetic"=>"laɪvd ɪkˈspɪriəns"})
# Term.create({"user_id"=>1, "term"=>"privilege", "definition"=>"Privilege refers to advantages conferred on people based soley on social status - such as white privilege, male privilege, able-bodied privilege. You can enjoy the benefits of being white, for example, while still facing challenges (such as poverty). Being privileged in one sector of your life does not erase challenges in others. But without being aware of one''s own privilege, a person can''t be an effective ally.", "phonetic"=>"ˈprɪvləʤ"})
# Term.create({"user_id"=>1, "term"=>"gender binary", "definition"=>"A gender binary system is a social system that only recognizes two \"legitimate\" gender identities or gender expressions, namely masculine and feminine.", "phonetic"=>"ˈʤɛndər ˈbaɪnəri"})
# Term.create({"user_id"=>1, "term"=>"Schrödinger''s rapist", "definition"=>"\"So when you, a stranger, approach me, I have to ask myself: Will this man rape me?\"<br><br>The concept of Schrödinger''s rapist <a href=\"http://kateharding.net/2009/10/08/guest-blogger-starling-schrodinger%E2%80%99s-rapist-or-a-guy%E2%80%99s-guide-to-approaching-strange-women-without-being-maced/\">was introduced</a> by Phaedra Starling in 2009, and references the thought experiment Schrödinger''s cat, which essentially posits a situation where a cat may or may not die based on a random event, the outcome of which cannot be predicted. Starling''s essay tells men interested in approaching women that, to them, the men may or may not wish them physical harm - they have no way of knowing, and therefore, all men are potential rapists.", "phonetic"=>"ʃröˈdɪŋərz ˈreɪpɪst"})
# Term.create({"user_id"=>1, "term"=>"mansplain", "definition"=>"A portmanteau of \"man\" and \"explain,\" it refers to men explaining something they have little knowledge of to women in a condescending manner - specifically, topics related to women - because they assume that the woman knows even less.", "phonetic"=>"mænspleɪn"})
#
#
# KeywordItem.create({"keyword_id"=>"26", "item_id"=>"1", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"1", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"1", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"29", "item_id"=>"1", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"24", "item_id"=>"1", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"6", "item_id"=>"1", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"43", "item_id"=>"2", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"2", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"44", "item_id"=>"2", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"29", "item_id"=>"2", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"24", "item_id"=>"2", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"1", "item_id"=>"1", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"1", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"36", "item_id"=>"1", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"1", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"1", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"3", "item_id"=>"2", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"2", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"2", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"37", "item_id"=>"2", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"37", "item_id"=>"3", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"3", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"3", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"4", "item_id"=>"3", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"3", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"2", "item_id"=>"4", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"4", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"4", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"4", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"36", "item_id"=>"4", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"33", "item_id"=>"4", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"5", "item_id"=>"5", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"5", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"5", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"39", "item_id"=>"5", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"36", "item_id"=>"5", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"37", "item_id"=>"5", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"8", "item_id"=>"6", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"6", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"6", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"9", "item_id"=>"7", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"23", "item_id"=>"7", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"7", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"43", "item_id"=>"8", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"44", "item_id"=>"8", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"35", "item_id"=>"8", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"8", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"8", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"10", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"10", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"10", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"39", "item_id"=>"10", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"18", "item_id"=>"10", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"28", "item_id"=>"9", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"9", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"9", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"35", "item_id"=>"9", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"26", "item_id"=>"9", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"6", "item_id"=>"9", "item_type"=>"Person"})
# KeywordItem.create({"keyword_id"=>"31", "item_id"=>"1", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"38", "item_id"=>"1", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"1", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"31", "item_id"=>"2", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"31", "item_id"=>"3", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"31", "item_id"=>"4", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"38", "item_id"=>"4", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"31", "item_id"=>"5", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"31", "item_id"=>"6", "item_type"=>"Term"})
# KeywordItem.create({"keyword_id"=>"1", "item_id"=>"1", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"1", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"36", "item_id"=>"1", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"1", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"30", "item_id"=>"1", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"33", "item_id"=>"1", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"30", "item_id"=>"2", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"2", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"37", "item_id"=>"2", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"4", "item_id"=>"2", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"5", "item_id"=>"3", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"37", "item_id"=>"3", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"39", "item_id"=>"3", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"30", "item_id"=>"3", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"30", "item_id"=>"4", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"8", "item_id"=>"4", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"30", "item_id"=>"5", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"5", "item_id"=>"5", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"23", "item_id"=>"5", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"2", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"3", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"40", "item_id"=>"4", "item_type"=>"Quote"})
# KeywordItem.create({"keyword_id"=>"8", "item_id"=>"4", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"29", "item_id"=>"4", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"24", "item_id"=>"4", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"46", "item_id"=>"4", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"9", "item_id"=>"3", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"29", "item_id"=>"3", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"41", "item_id"=>"3", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"24", "item_id"=>"3", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"23", "item_id"=>"3", "item_type"=>"Excerpt"})
# KeywordItem.create({"keyword_id"=>"45", "item_id"=>"3", "item_type"=>"Excerpt"})





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