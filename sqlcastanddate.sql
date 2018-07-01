-- 2. Change date into correct SQL format
SELECT date,
CAST(SUBSTR(date,7,4) || '-' || SUBSTR(date,1,2) || '-' || SUBSTR(date,4,2) AS date) AS new_date
FROM sf_crime_data
LIMIT 10
