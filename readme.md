## Swiss pairings tournament ranking

Add players to a database, then pair them up for each round based on how well they do.

Tournament.sql creates the database schema. In the psql command line, create a database called, for example, "tournament." To create the tables and views, run \i tournament.sql or copy and paste the commands into your terminal.

`players` keeps track of players in the game. For the seeding to work correctly, you should have an even number of players.

`matchup` keeps track of who won and lost each match.

`standings` lists each player's id and name, then how many matches she or he has won and how many he or she has played in all.

Query `nextround` at the beginning for an initial match pairing. Query it again once each player has played a game and you'll have a grouping where each player is paired with another who's won a similar number of games

Once you've created your tables and views, hop over to tournament.py. In that file, you'll find functions that write player and match data to the database, and return standings and next round pairings.

Run the unit tests using `python tournament_test.py`. If you receive the message "Success! All tests pass!" then you've got it set up correctly.