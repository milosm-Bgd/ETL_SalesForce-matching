

-- kreiranje kopije za [Seated].[Locations] tabelu


SELECT * FROM [Sandbox].[Seated].[RestaurantLocations]
																

DROP TABLE [Sandbox].[Seated].[RestaurantLocations_spec]

-- sintaksa sa kreiranje RestaurantLocations_2 tabele na osnovu RestaurantLocations
SELECT * INTO [Sandbox].[Seated].[RestaurantLocations_spec]
FROM [Sandbox].[Seated].[RestaurantLocations]

SELECT TargetStartDate, * 
--FROM [Sandbox].[Seated].[RestaurantLocations_spec]
FROM [Sandbox].[Seated].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-12-01'
ORDER BY 1 DESC

select count(distinct seatedsiteid)
from [Sandbox].[Seated].[RestaurantLocations_2]
where TargetStartDate = '2024-11-15'

--SELECT SeatedLocationId FROM [Sandbox].[Seated].[RestaurantLocations_2]

-- provera za unos od 15.dec 2024
SELECT TargetStartDate, * 
FROM [Sandbox].[Seated].[RestaurantLocations_spec]
WHERE TargetStartDate = '2024-12-15'
ORDER BY 1 DESC

