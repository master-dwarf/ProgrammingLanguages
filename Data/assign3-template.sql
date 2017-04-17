use bb16;

-- Query for problem 1

select '***' from dual;
select 'Problem 1' from dual;
select '***' from dual;

-- Put your solution for 1 here

SELECT DISTINCT bb16.Teams2016.name
	FROM bb16.Teams2016,bb16.Pitching2016
	WHERE bb16.Teams2016.teamID = bb16.Pitching2016.teamID
    AND bb16.Pitching2016.W > 15
    GROUP BY bb16.Pitching2016.teamID
    HAVING count(*) > 1;

-- Query for problem 2

select '***' from dual;
select 'Problem 2' from dual;
select '***' from dual;

-- Put your solution for 2 here

SELECT p.nameLast, p.nameFirst
	FROM bb16.Players2016 AS p, bb16.Batting2016 AS b
	where (b.teamId='MIL' OR b.teamID='NYN')
  and p.playerID = b.playerID
	order by HR Desc
	limit 2;

-- Query for problem 3

select '***' from dual;
select 'Problem 3' from dual;
select '***' from dual;

-- Put your solution for Problem 3 here

select 'Problem 3 not solved' from dual;

-- Query for problem 4

select '***' from dual;
select 'Problem 4' from dual;
select '***' from dual;

-- Put your solution for 4 here

select pl.nameFirst, pl.nameLast
	from bb16.Players2016 as pl
	where not(
		exists(
			SELECT bat.playerID, SUM(bat.3B) AS totaltriple
				FROM bb16.Batting2016 as bat
                where pl.playerID = bat.playerID
				GROUP BY playerID
				having totaltriple > 0)
		OR
		exists(
			select pl.playerID
				from bb16.Pitching2016 as pit
                where pl.playerID = pit.playerID
			)
    );

-- Query for problem 5

select '***' from dual;
select 'Problem 5' from dual;
select '***' from dual;

-- Put your solution for 5 here

select 'Problem 5 not solved' from dual;

-- Query for problem 6

select '***' from dual;
select 'Problem 6' from dual;
select '***' from dual;

-- Put your solution for 6 here

select pl.nameFirst, pl.nameLast, team.name as Team, ((H-2B-3B-HR)+(2*2B)+(3*3B)+(4*HR))/AB AS slugging
	from bb16.Batting2016 as bat, bb16.Players2016 as pl, bb16.Teams2016 as team
		where AB > 400
        and pl.playerID = bat.playerID
        and bat.teamID = team.teamID
		group by bat.playerID
		order by slugging desc
		limit 1;

-- Query for problem 7

select '***' from dual;
select 'Problem 7' from dual;
select '***' from dual;

-- Put your solution for 7 here

select t.name as Team, (sum(ER)/sum(IPouts/27))as TeamEarnedRunAverage
	from bb16.Pitching2016 as pit, bb16.Teams2016 as t
    where pit.teamID = t.teamID
    group by pit.teamID
    order by TeamEarnedRunAverage asc;

-- Query for problem 8

select '***' from dual;
select 'Problem 8' from dual;
select '***' from dual;

-- Put your solution for 8 here

select 'Problem 8 not solved' from dual;

-- Query for problem 9

select '***' from dual;
select 'Problem 9' from dual;
select '***' from dual;

-- Put your solution for 9 here

select 'Problem 9 not solved' from dual;

-- Query for problem 10

select '***' from dual;
select 'Problem 10' from dual;
select '***' from dual;

-- Put your solution for 10 here

select divID
	from bb16.Teams2016 as team
	where exists(
		select bat.teamID
			from bb16.Batting2016 as bat
			where bat.H > 150
			and team.teamID = bat.teamID
			group by teamID
			)
	group by divID
	having count(team.divID) = 5;

SELECT '***' FROM dual;
SELECT 'THE END' FROM dual;
SELECT '***' FROM dual;
