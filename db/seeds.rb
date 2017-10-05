americasOtherArmy = Book.create(:name => "America's Other Army", :year_published => 2012, :has_been_read => 1)
nicholasKralev = Author.create(:name => "Nicholas Kralev")
publisherNicholasKralev = Publisher.create(:name => "Nicholas Kralev")
ia = Genre.create(:name => "International Affairs", :category => "Non-Fiction")

americasOtherArmy.author = nicholasKralev
americasOtherArmy.publisher = publisherNicholasKralev
americasOtherArmy.genres << ia
americasOtherArmy.save

nationsStatesAndViolence = Book.create(:name => "Nations, States, and Violence", :year_published => 2007, :has_been_read => 1)
davidLaitin = Author.create(:name => "David Laitin")
oxfordUniversityPress = Publisher.create(:name =>"Oxford University Press")
poliSci = Genre.create(:name => "Political Science", :category => "Non-Fiction")

nationsStatesAndViolence.author = davidLaitin
nationsStatesAndViolence.publisher = oxfordUniversityPress
nationsStatesAndViolence.genres << poliSci
nationsStatesAndViolence.genres << ia
nationsStatesAndViolence.save

containingNationalism = Book.create(:name => "Containing Nationalism", :year_published => 2007, :has_been_read => 1)
mHechter = Author.create(:name => "Michael Hechter")

containingNationalism.author = mHechter
containingNationalism.publisher = oxfordUniversityPress
containingNationalism.genres << ia
containingNationalism.genres << poliSci
containingNationalism.save
