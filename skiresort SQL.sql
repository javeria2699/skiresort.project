create database skiresort;
use skiresort;

CREATE TABLE resorts (
    ID INT PRIMARY KEY,
    Resort VARCHAR(100),
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Country VARCHAR(50),
    Continent VARCHAR(50),
    Price INT,
    Season VARCHAR(25),
    Highest_point INT,
    Lowest_pont INT,
    Beginner_slopes INT,
    Intermediate_slopes INT,
    Difficult_slopes INT,
    Total_slopes INT,
    Longest_run INT,
    Snow_cannons INT,
    Surface_lifts INT,
    Chair_lifts INT,
    Gondola_lifts INT,
    Total_lifts INT,
    Lift_capacit INT,
    Child_friendly BOOLEAN,
    Snowparks BOOLEAN,
    Nightskiing BOOLEAN,
    Summer_skiing BOOLEAN
);


select * from resorts;



-- the top 10 most affordable ski resorts 

SELECT Resort, Country, Price, `Total slopes`
FROM resorts
WHERE `Total slopes` >= 10
ORDER BY Price
LIMIT 10;

--  top 10 ski resorts with the highest number of intermediate slopes.

SELECT Resort, Country, `Intermediate slopes`
FROM resorts
ORDER BY `Intermediate slopes` DESC
LIMIT 10;

-- child-friendly ski resorts with a lift capacity greater than 20,000.

SELECT Resort, Country, `Lift capacity`, `Child friendly`
FROM resorts 
WHERE `Child friendly` = 'yes' 
  AND `Lift capacity` > 20000;

-- resorts open during the popular winter season (December to April)
-- that offer at least 15 total slopes and have slopes for all skill levels: beginner, intermediate, and difficult.

SELECT Resort, Season, `Beginner slopes`, `Intermediate slopes`, `Difficult slopes`, `Total slopes`
FROM resorts
WHERE `Total slopes` >= 15
  AND `Beginner slopes` > 0
  AND `Intermediate slopes` > 0
  AND `Difficult slopes` > 0
  AND Season = 'December - April';


--  resorts with highest lift capacity per country
SELECT country, resort, `lift capacity`
FROM resorts r
WHERE `lift capacity` = (
    SELECT MAX(`lift capacity`)
    FROM resorts
    WHERE country = r.country
);

--  Average price per continent for family resorts
SELECT continent, AVG(price) AS avg_price
FROM resorts
WHERE `child friendly` = 'yes'
GROUP BY continent;

-- Resorts with more difficult slopes than beginner ones
SELECT resort, `beginner slopes`, `difficult slopes`
FROM resorts
WHERE `difficult slopes` > `beginner slopes`;

-- Resorts that offer both nightskiing and summer skiing
SELECT resort, nightskiing, `summer skiing`
FROM resorts
WHERE nightskiing = 'yes' AND `summer skiing` = 'yes';

-- CTE – Calculate elevation difference first
WITH elevation_diff AS (
    SELECT resort, (`highest point` - `lowest point`) AS elevation
    FROM resorts
)
SELECT resort, elevation
FROM elevation_diff
WHERE elevation > 1000
ORDER BY elevation DESC;















