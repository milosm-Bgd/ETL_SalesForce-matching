

-- kreiranje kopije za [ResSpecial].[Locations] tabelu


SELECT * FROM [Sandbox].[ResSpecial].[RestaurantLocations]
																

DROP TABLE [Sandbox].[ResSpecial].[RestaurantLocations_spec]

-- sintaksa sa kreiranje RestaurantLocations_2 tabele na osnovu RestaurantLocations
SELECT * INTO [Sandbox].[ResSpecial].[RestaurantLocations_spec]
FROM [Sandbox].[ResSpecial].[RestaurantLocations]

SELECT TargetStartDate, * 
--FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec]
FROM [Sandbox].[ResSpecial].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-12-01'
ORDER BY 1 DESC

select count(distinct ResSpecialsiteid)
from [Sandbox].[ResSpecial].[RestaurantLocations_2]
where TargetStartDate = '2024-11-15'

--SELECT ResSpecialLocationId FROM [Sandbox].[ResSpecial].[RestaurantLocations_2]

-- provera 
SELECT TargetStartDate, * 
FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec]
WHERE TargetStartDate = '2024-12-15'
ORDER BY 1 DESC

