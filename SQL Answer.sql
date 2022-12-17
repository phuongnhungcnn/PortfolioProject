

--I.	Simple Queries
--Simple Queries / Ex 1: 459 rows
select
	EventName,
	EventDate
from
	tblEvent
order by
	EventDate desc;
	
--Simple Queries / Ex 2
select
	top 5 EventName,
	EventDetails
from
	tblEvent te
order by
	EventDate asc ;


--Simple Queries / Ex 3:
select
	top 3
	CategoryID,
	CategoryName
from
	tblCategory tc
order by
	CategoryName desc;

--Simple Queries / Ex 4: Click on the Text instead of Grid to switch
select
	top 2 EventName,
	EventDetails
from
	tblEvent te
order by
	EventDate asc ;

select
	top 2 EventName,
	EventDetails
from
	tblEvent te
order by
	EventDate desc;



--Use WHERE / Ex 1:
select
	*
from
	tblEvent te
where
	CategoryID = 11


--Use WHERE / Ex 2: 2 rows
select
	*
from
	tblEvent te
where
	year(EventDate) = 2005
	and month(EventDate) = 2


--Use WHERE / Ex 3: 2 rows
select
	*
from
	tblEvent te
where
	EventName like '%Teletubbies %'
	or EventName like '%Pandy %'


--Use WHERE / Ex 4: 11 rows, 13 rows without the >= 1970 filter

select
	*
from
	tblEvent te
where
	(CountryID in (8, 22, 30, 35)
	or EventDetails like '%Water %'
	or CategoryID = 4) 
	and year(EventDate) >= 1970

--Use WHERE / Ex 5: 4 rows
select
	*
from
	tblEvent te
where
	CategoryID != 14
	and EventDetails like '%Train%'
	
	
--Use WHERE / Ex 6: 6 rows
select
	*
from
	tblEvent te
where
	CountryID = 13
	and EventName not like '%Space%'
	and EventDetails not like '%Space%'
	
--Use WHERE / Ex 7: 91 rows
select
	*
from
	tblEvent te
where
	CategoryID in (5, 6)
	and EventDetails not like '%War%'
	and EventDetails not like '%Death%'

--Basic joins / Ex 1: 13 rows
SELECT
	tblAuthor.AuthorName,
	tblEpisode.Title,
	tblEpisode.EpisodeType
FROM
	tblAuthor
INNER JOIN tblEpisode ON
	tblAuthor.AuthorId = tblEpisode.AuthorId
WHERE
	tblEpisode.EpisodeType LIKE '%special%'
ORDER BY
	tblEpisode.Title


--Basic joins / Ex 2: 15 rows
select
	td.DoctorName ,
	te.Title
from
	tblEpisode te
left join tblDoctor td on
	te.DoctorId = td.DoctorId
where
	year(te.EpisodeDate) = 2010


--Basic joins / Ex 3: 459 rows
select
	CountryName ,
	eventname,
	eventdate
from
	tblCountry tc
inner join tblEvent te on
	tc.CountryID = te.CountryID
order by
	eventdate

--Basic joins / Ex 4: 5 rows
select
	te.EventName,
	tc.CountryName,
	tc2.ContinentName
from
	tblEvent te
left join tblCountry tc on
	te.CountryID = tc.CountryID
left join tblContinent tc2 on
	tc.ContinentID = tc2.ContinentID
where
	tc.CountryName = 'Russia'
	or tc2.ContinentName = 'Antarctic'

--Basic joins / Ex 5:
--Inner join, 459 rows
select
	EventName ,
	EventDate ,
	tc.CategoryName
from
	tblEvent te
inner join tblCategory tc on
	te.CategoryID = tc.CategoryID;
--Full outer join, 461 rows
select
	EventName ,
	EventDate ,
	tc.CategoryName
from
	tblEvent te
full outer join tblCategory tc on
	te.CategoryID = tc.CategoryID
where EventID is null;

--Basic joins / Ex 6:	 16 rows
select
	Title,
	authorname,
	enemyname
from
	tblEpisode te
inner join tblAuthor ta on
	te.AuthorId = ta.AuthorId
inner join tblEpisodeEnemy tee on
	te.EpisodeId = tee.EpisodeId
inner join tblEnemy te2 on
	tee.EnemyId = te2.EnemyId
where
	te2.EnemyName = 'Daleks'


--Basic joins / Ex 7: 2 rows
select 
	ta.AuthorName ,
	len(ta.AuthorName),
	te.Title ,
	len(te.Title),
	td.DoctorName ,
	len(td.DoctorName),
	te2.EnemyName ,
	len(te2.EnemyName),
	len(ta.AuthorName) + len(te.Title) + len(td.DoctorName) + len(te2.EnemyName) as [total length]
from
	tblEpisode te
inner join tblAuthor ta on
	te.AuthorId = ta.AuthorId
inner join tblDoctor td on 
	te.DoctorId = td.DoctorId 
inner join tblEpisodeEnemy tee on
	te.EpisodeId = tee.EpisodeId
inner join tblEnemy te2 on
	tee.EnemyId = te2.EnemyId
where len(ta.AuthorName) + len(te.Title) + len(td.DoctorName) + len(te2.EnemyName) < 40

--Basic joins / Ex 8: 1 row
select
	*
from
	tblCountry tc
full outer join tblEvent te on
	tc.CountryID = te.CountryID
where
	te.EventID is null

--Aggregation and grouping / Ex 1: 25 rows
select
	ta.AuthorName,
	count(distinct EpisodeId) as [Count Episode],
	min(EpisodeDate) as [Earliest episode date],
	max(EpisodeDate) as [Latest episode date]
from
	tblEpisode te
inner join tblAuthor ta on
	te.AuthorId = ta.AuthorId
group by
	ta.AuthorName
order by
	count(distinct EpisodeId) desc


--Aggregation and grouping / Ex 2: 18 rows, if use left join it should return 20 rows
select
	tc.CategoryName ,
	count(distinct te.EventID) as [Count event]
from
	tblCategory tc
inner join tblEvent te on
	tc.CategoryID = te.CategoryID
group by
	tc.CategoryName
order by
	count(distinct te.EventID) desc

--Aggregation and grouping / Ex 3:
select
	count(distinct EventID) as [Number of events],
	min(EventDate) as [First Date],
	max(EventDate) as [Last Date]
from
	tblEvent te;


--Aggregation and grouping / Ex 4: 42 rows
select
	tc2.ContinentName ,
	tc.CountryName ,
	count(distinct te.EventID) as [Number of events]
from
	tblEvent te
inner join tblCountry tc on
	te.CountryID = tc.CountryID
inner join tblContinent tc2 on
	tc2.ContinentID = tc.ContinentID
group by
	tc2.ContinentName ,
	tc.CountryName;

--Aggregation and grouping / Ex 5: 4 rows
select
	ta.AuthorName ,
	td.DoctorName ,
	count(distinct te.EpisodeId) as [Number of episodes]
from
	tblEpisode te
inner join tblAuthor ta on
	te.AuthorId = ta.AuthorId
inner join tblDoctor td on
	te.DoctorId = td.DoctorId
group by
	ta.AuthorName ,
	td.DoctorName
having
	count(distinct te.EpisodeId) > 5
order by
	count(distinct te.EpisodeId) desc

--Aggregation and grouping / Ex 6: 4 rows
select
	year(te.EpisodeDate) as [Episode Year],
	te2.EnemyName,
	count(distinct te.EpisodeId) as [Episodes]
from
	tblEpisode te
inner join tblEpisodeEnemy tee on
	te.EpisodeId = tee.EpisodeId
inner join tblEnemy te2 on
	tee.EnemyId = te2.EnemyId
inner join tblDoctor td on 
	te.DoctorId = td.DoctorId 
where year(td.BirthDate) < 1970
group by
	year(te.EpisodeDate) ,
	te2.EnemyName
having 
	count(distinct te.EpisodeId) > 1
order by 
	count(distinct te.EpisodeId) desc;



--Aggregation and grouping / Ex 7: 12 rows without nulls, 14 rows with nulls
select
	left(tc.CategoryName, 1),
	count(distinct te.EventID) as [Number of events],
	avg(len(EventName)) as [Average event name length]
from
	tblEvent te
inner join tblCategory tc on
	te.CategoryID = tc.CategoryID
group by
	left(tc.CategoryName, 1)
order by 
	avg(len(EventName)) desc;


--Aggregation and grouping / Ex 8:
select
	concat(1 + year(EventDate) / 100,  
		case when right(1 + year(EventDate) / 100, 1) = 1 
			 then 'st'
			 when right(1 + year(EventDate) / 100, 1) = 2
			 then ' nd'
			 when right(1 + year(EventDate) / 100, 1) = 3 
			 then ' rd'
			 else 'th'
			 end,
		' century')
	as century,
	count(distinct EventID) as Number_of_events
from
	tblEvent te
group by
	1 + year(EventDate) / 100;
	
	

--Calculations using dates / Ex 1:
select
	EventDate,
	format(EventDate, 'dd/MM/yyyy') as formattedDate
from
	tblEvent te
where 
year(EventDate) = 1995;

--Calculations using dates / Ex 2:
select
	EventDate ,
	cast('09/26/1995' as date) as DOB, --or use datefromparts
	abs(datediff(day, EventDate, cast('09/26/1995' as date))) as daydiff
from
	tblEvent te
order by
	abs(datediff(day, EventDate, cast('09/26/1995' as date))) asc;


--Calculations using dates / Ex 3:
select
	EventName,
	EventDate,
	datename(weekday, EventDate) as Day_of_week,
	datepart(day, EventDate) as Day_number
from
	tblEvent te
where 
	datename(weekday, EventDate) = 'Friday' 
	and datepart(day, EventDate) = 13;

select
	EventName,
	EventDate,
	datename(weekday, EventDate) as Day_of_week,
	datepart(day, EventDate) as Day_number
from
	tblEvent te
where 
	datename(weekday, EventDate) = 'Thursday' 
	and datepart(day, EventDate) = 12;
	
select
	EventName,
	EventDate,
	datename(weekday, EventDate) as Day_of_week,
	datepart(day, EventDate) as Day_number
from
	tblEvent te
where 
	datename(weekday, EventDate) = 'Saturday' 
	and datepart(day, EventDate) = 14;

--Calculations using dates / Ex 4:
select
	EventName as Event_Name,
	concat(datename(weekday, EventDate), ' ', 
	case 
        when datepart(day, EventDate) in (1, 21, 31) 
       		then convert(varchar, datepart(day, EventDate))+ 'st'
       	when datepart(day, EventDate) in (2, 22) 
       		then convert(varchar, datepart(day, EventDate))+ 'nd'
       	when datepart(day, EventDate) in (3, 23) 
	        then convert(varchar, datepart(day, EventDate))+ 'rd'
        else convert(varchar, datepart(day, EventDate)) + 'th'
        end , ' ' 
        , datename(month, EventDate) , ' ' 
        , year(EventDate)) as Full_Date
from
	tblEvent te



