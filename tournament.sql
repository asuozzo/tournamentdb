-- Table definitions for the tournament project.


CREATE TABLE players (
    name text,
    id serial PRIMARY KEY
);

CREATE TABLE matchup (
    winner integer REFERENCES players(id),
    loser integer REFERENCES players(id),
    matchid serial PRIMARY KEY
);

-- summarize total wins and total matches played for each player
CREATE VIEW standings AS
    SELECT
        players.id as playerid,
        players.name as playername,
        count(case when matchup.winner = players.id then 1 end) as wins,
        count(case when matchup.winner = players.id OR matchup.loser = players.id then 1 end) as matches
    FROM players
        LEFT JOIN matchup
        ON players.id = matchup.winner OR players.id = matchup.loser
    GROUP BY players.id
    ORDER BY wins DESC;


-- matchups for next round
CREATE VIEW nextround AS
    SELECT
        a.playerid as id1,
        a.playername as name1,
        b.playerid as id2,
        b.playername as name2
    FROM (SELECT *,
        CEILING(row_number() OVER(ORDER BY wins ASC)/2.0) AS row
        FROM standings) as a,
        (SELECT *,
        CEILING(row_number() OVER(ORDER BY wins ASC)/2.0) AS row
        FROM standings) as b
    WHERE
        a.row = b.row
        and a.playerid > b.playerid;
