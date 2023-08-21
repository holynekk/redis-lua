# REDISEARCH

docker run -p 6379:6379 redislabs/redisearch:latest

## Creating index

ft.create idx:movie ON hash PREFIX 1 "movie" SCHEMA movie_name TEXT SORTABLE release_year NUMERIC SORTABLE rating NUMERIC SORTABLE category TAG SORTABLE

ft.info idx:movie

## Search

ft.search idx:movie "war"

ft.search idx:movie "war -jedi"

ft.search idx:movie "war" RETURN 2 movie_name release_year

ft.search idx:movie "@movie_name:war" RETURN 2 movie_name release_year

ft.search idx:movie "%gdfather%" return 2 movie_name release_year

ft.search idx:movie "@category:{Thriller}" return 2 movie_name release_year

ft.search idx:movie "@category:{Thriller|Action}" return 3 movie_name release_year category

ft.search idx:movie "@category:{Thriller|Action} @movie_name:-jedi" return 3 movie_name release_year category

## Search by Value

ft.search idx:movie "@release_year:[1970 1980]" return 2 movie_name release_year

ft.search idx:movie * FILTER release_year 1970 1980 return 2 movie_name release_year

ft.search idx:movie "@release_year:[1970 (1980]" return 2 movie_name release_year

## Counting total records/documents

ft.search idx:movie "*" LIMIT 0 0

## Redis provides you re-indexing

expire movie:5 30

ft._list

ft.alter idx:movie SCHEMA ADD plot TEXT WEIGHT 0.5

ft.dropindex idx:movie

# CREATE NEW BIG DATABASE

import redis files: redis-cli -h localhost -p 6379 < ./import_actors.redis

## Create indexes

ft.create idx:movie  ON hash PREFIX 1 "movie:" SCHEMA movie_name TEXT SORTABLE release_year NUMERIC SORTABLE category TAG SORTABLE rating NUMERIC SORTABLE plot TEXT

ft.create idx:actor ON hash PREFIX 1 "actor:" SCHEMA first_name TEXT SORTABLE last_name TEXT SORTABLE date_of_birth NUMERIC SORTABLE

ft.create idx:theater ON hash PREFIX 1 "theater:" SCHEMA name TEXT SORTABLE location GEO

ft.create idx:user ON hash PREFIX 1 "user:" SCHEMA gender TAG country TAG SORTABLE last_login NUMERIC SORTABLE location GEO

## And Or

ft.search idx:movie "@category:{Mystery}" return 3 movie_name release_year category

ft.search idx:movie "@category:{Mystery|Thriller}" return 3 movie_name release_year category 

ft.search idx:movie "@category:{Mystery|Thriller} @release_year:[2014 2014]" return 3 movie_name release_year category

ft.search idx:movie "@category:{Mystery|Thriller} (@release_year:[2014 2014] | @release_year:[2018 2018])" return 3 movie_name release_year category

## Numerical Conditions

ft.search idx:movie "@release_year:[1995 2000]" return 2 movie_name release_year

ft.search idx:movie "@release_year:[2000 +inf]" return 2 movie_name release_year

ft.search idx:movie "@release_year:[(2014 +inf]" return 2 movie_name release_year

ft.search idx:movie "@release_year:[-inf (2014]" return 2 movie_name release_year

## SORTBY

ft.search idx:movie "@category:{Action}" SORTBY release_year DESC return 2 movie_name release_year 

## Limit

ft.search idx:movie "@category:{Action}" SORTBY release_year DESC LIMIT 0 5 return 2 movie_name release_year

## Aggregate

ft.search idx:movie "*" limit 0 0

ft.aggregate idx:movie "*" GROUPBY 1 @release_year

ft.aggregate idx:movie "*" GROUPBY 2 @release_year @category

ft.aggregate idx:movie "*" GROUPBY 1 @release_year REDUCE COUNT 0 AS total_movie_count

ft.aggregate idx:movie "heat" GROUPBY 1 @release_year REDUCE COUNT 0 AS total_movie_count

ft.aggregate idx:movie "*" GROUPBY 1 @release_year REDUCE COUNT 0 AS total_movie_count SORTBY 2 @release_year ASC

ft.aggregate idx:movie "*" GROUPBY 1 @category SORTBY 2 @category DESC

ft.aggregate idx:movie "*" GROUPBY 1 @category REDUCE COUNT 0 AS total_num_of_movies SORTBY 2 @category DESC

ft.aggregate idx:movie "*" GROUPBY 1 @category REDUCE COUNT 0 AS total_num_of_movies REDUCE SUM 1 votes AS total_votes REDUCE AVG 1 rating AS avg_rating

ft.aggregate idx:movie "*" GROUPBY 1 @category REDUCE COUNT 0 AS total_num_of_movies REDUCE SUM 1 votes AS total_votes REDUCE AVG 1 rating AS avg_rating SORTBY 4 @avg_rating DESC @total_votes ASC

ft.aggregate idx:user "@gender:{female}" GROUPBY 1 @country REDUCE COUNT 0 AS num_of_female_users SORTBY 2 @num_of_female_users DESC

## Apply

ft.aggregate idx:user "*" APPLY YEAR(@last_login) AS year APPLY "monthofyear(@last_login) + 1" AS month GROUPBY 2 @year @month REDUCE COUNT 0 AS count_user_logins SORTBY 3 @year DESC @month

ft.aggregate idx:user "*" APPLY dayofweek(@last_login) AS day_of_week GROUPBY 1 @day_of_week REDUCE COUNT 0 AS count_week_user_logins SORTBY 2 @day_of_week DESC

## Filter

ft.aggregate idx:user "@gender:{female}" GROUPBY 1 @country REDUCE COUNT 0 AS count_females FILTER "@country != 'china' && @count_females >= 109" SORTBY 2 @count_females DESC

ft.create idx:movie:drama ON hash prefix 1 "movie:" FILTER "@category=='Drama' && @release_year >=1990 && @release_year < 2000" SCHEMA movie_name TEXT SORTABLE release_year NUMERIC SORTABLE
