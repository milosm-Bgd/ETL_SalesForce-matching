

with cte as (
SELECT distinct 
	   [restaurant_id]
      ,[name]
      ,[description]
      ,[full_address]
      ,[street_address]
      ,[Billing_City]
      ,[country]
      ,[state_code]
      ,[postal_code]
      ,[latitude]
      ,[longitude]
      ,[Cuisine_Image]
      ,[Logo_URL]
      ,[monday_oh]
      ,[tuesday_oh]
      ,[wednesday_oh]
      ,[thursday_oh]
      ,[friday_oh]
      ,[saturday_oh]
      ,[sunday_oh]
      ,[photo1]
      ,[photo2]
      ,[photo3]
      ,[photo4]
      ,[photo5]
      ,[menu_url]
      ,[reservation_provider_name]
      ,[reservation_provider_url]
      ,[Website_Url]
      ,[phone_number]
      ,[primary_cuisine]
      ,[Allows_Reservations]
	  ,getutcdate() dafuq
      
  FROM [Sandbox].[Seated].[RestaurantsStaging]
  where restaurant_id is not null
)



select * 
from cte s
left join [Sandbox].[Seated].[RestaurantLocations] rl on rl.SeatedSiteId = s.restaurant_id


select *
from Integrations.SalesForce.SfSync 
where cast(SeatedLocationId as float) = 11017



select  count(distinct  restaurant_id)
from [Sandbox].[Seated].[RestaurantsStaging]

select count(distinct seatedsiteid)
from [Sandbox].[Seated].[RestaurantLocations]
where TargetStartDate = '2024-11-15'


select distinct rl.*, rlp.* --rlp.id, rlp.Active_partner, rlp.Start_Date_1
 
 select distinct rl.[Id]
      ,rl.[SeatedSiteId]
      ,rl.[Name]
      ,rl.[Description]
      ,rl.[FullAddress]
      ,rl.[StreetAddress]
      ,rl.[BillingCity]
      ,rl.[Country]
      ,rl.[StateCode]
      ,rl.[PostalCode]
      ,rl.[SalesForceId]
      ,rl.[SiteId]
      ,rl.[IsExcluded]
      ,rl.[TargetStartDate]
	  ,rlp.ID SiteId
	  ,rlp.Restaurant_Name
	  ,rlp.Address_1
	  ,rlp.City
	  ,rlp.Zip
	  ,rlp.State
	  ,rlp.Active_Partner
	  ,rlp.Start_Date_1
	  ,rlp.OOB_Date
from [Sandbox].[Seated].[RestaurantLocations] rl
inner join [Sandbox].[Seated].[RestaurantsStaging] s on rl.seatedsiteid = s.restaurant_id
left join Master.dbo.din_restaurant_locations_primary rlp on rlp.seatedLocationid = rl.seatedsiteid
where rl.TargetStartDate != '2024-11-01'
--and isnull(active_partner,-1) <> 1
and rl.SeatedSiteId not in (16474,
15565
)

and rl.IsExcluded = 1
and rlp.ID is null


select * from master.dbo.din_restaurant_status

--select * from [Sandbox].[Seated].[RestaurantLocations] where targetstartdate = '2024-10-15 00:00:00.000'

select * from [Sandbox].[Seated].[RestaurantLocations] where targetstartdate = '2024-11-15 00:00:00.000' -- 24 rows

select count(distinct seatedsiteid)
from [Sandbox].[Seated].[RestaurantLocations]
where TargetStartDate = '2024-11-15'   -- 24 rows 
where TargetStartDate = '2024-11-30'   --  0 rows 


<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

------   ODAVDE RADIMO IZVRSAVANJE:

<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


-- radi kreiranja kopije za  [RestaurantLocations] tabelu

-- after running merge into statement , running the select * for validation: 

-- SELECT * FROM [Sandbox].[Seated].[RestaurantsStaging]


select * from [Sandbox].[Seated].[RestaurantLocations]
														
														
select * from [Sandbox].[Seated].[RestaurantLocations_2] 

TRUNCATE TABLE [Sandbox].[Seated].[RestaurantLocations_2]


--INSERT INTO [Sandbox].[Seated].[RestaurantLocations_2]
SELECT * FROM [Sandbox].[Seated].[RestaurantLocations]
WHERE TargetStartDate <> '2024-11-01'

SELECT * FROM [Sandbox].[Seated].[RestaurantLocations_2] 
													
SELECT * FROM [Sandbox].[Seated].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-11-01'   -- 101 redova

SELECT * FROM [Sandbox].[Seated].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-11-15'   -- 24 redova

ALTER TABLE [Seated].[RestaurantLocations_2] ALTER COLUMN IsExcluded bit NOT NULL DEFAULT (0);
ALTER TABLE [Seated].[RestaurantLocations_2] ALTER COLUMN IsExcluded bit NULL;
ALTER TABLE [Seated].[RestaurantLocations_2] ALTER COLUMN CreatedBy nvarchar(50) NULL;
-- alternativa radimo preko Table design gde odaberemo column properities i tamo odradimo izmene

merge into [Sandbox].[Seated].[RestaurantLocations_2] as target
using (
SELECT distinct 
	 [restaurant_id]
      ,[name]
      ,[description]
      ,[full_address]
      ,[street_address]
      ,[Billing City]
      ,[country]
      ,[state_code]
      ,[postal_code]
      ,[latitude]
      ,[longitude]
      ,[Cuisine Image]
      --,[Default_Image]
	,[Logo URL]
      ,[monday_oh]
      ,[tuesday_oh]
      ,[wednesday_oh]
      ,[thursday_oh]
      ,[friday_oh]
      ,[saturday_oh]
      ,[sunday_oh]
      ,[photo1]
      ,[photo2]
      ,[photo3]
      ,[photo4]
      ,[photo5]
      ,[menu_url]
      ,[reservation_provider_name]
      ,[reservation_provider_url]
      ,[Website Url]
      ,[phone_number]
      ,[primary_cuisine]
      ,[Allows Reservations]
	,getutcdate()
      
  FROM [Sandbox].[Seated].[RestaurantsStaging]
  where restaurant_id is not null
) as source 
([SeatedSiteId]   
      ,[Name]
      ,[Description]
      ,[FullAddress]
      ,[StreetAddress]
      ,[BillingCity]
      ,[Country]
      ,[StateCode]
      ,[PostalCode]
      ,[Latitude]
      ,[Longitude]
      ,[CuisineImageUrl]
      ,[LogoUrl]
      ,[MondayOpenHours]
      ,[TuesdayOpenHours]
      ,[WednesdayOpenHours]
      ,[ThursdayOpenHours]
      ,[FridayOpenHours]
      ,[SaturdayOpenHours]
      ,[SundayOpenHours]
      ,[Photo1]
      ,[Photo2]
      ,[Photo3]
      ,[Photo4]
      ,[Photo5]
      ,[MenuUrl]
      ,[ReservationProviderName]
      ,[ReservationProviderUrl]
      ,[WebsiteUrl]
      ,[PhoneNumber]
      ,[PrimaryCuisine]
      ,[AllowsReservations]
      ,[CreatedOn])

on source.[SeatedSiteId] = target.[SeatedSiteId] 

when not matched then insert 
([Id]
,[SeatedSiteId]
      ,[Name]
      ,[Description]
      ,[FullAddress]
      ,[StreetAddress]
      ,[BillingCity]
      ,[Country]
      ,[StateCode]
      ,[PostalCode]
      ,[Latitude]
      ,[Longitude]
      ,[CuisineImageUrl]
      ,[LogoUrl]
      ,[MondayOpenHours]
      ,[TuesdayOpenHours]
      ,[WednesdayOpenHours]
      ,[ThursdayOpenHours]
      ,[FridayOpenHours]
      ,[SaturdayOpenHours]
      ,[SundayOpenHours]
      ,[Photo1]
      ,[Photo2]
      ,[Photo3]
      ,[Photo4]
      ,[Photo5]
      ,[MenuUrl]
      ,[ReservationProviderName]
      ,[ReservationProviderUrl]
      ,[WebsiteUrl]
      ,[PhoneNumber]
      ,[PrimaryCuisine]
      ,[AllowsReservations]
      ,[CreatedOn]
	  ,targetstartdate)
	  values
(	   newid()
	  ,source.[SeatedSiteId]
      ,source.[Name]
      ,source.[Description]
      ,source.[FullAddress]
      ,source.[StreetAddress]
      ,source.[BillingCity]
      ,source.[Country]
      ,source.[StateCode]
      ,source.[PostalCode]
      ,source.[Latitude]
      ,source.[Longitude]
      ,source.[CuisineImageUrl]
      ,source.[LogoUrl]
      ,source.[MondayOpenHours]
      ,source.[TuesdayOpenHours]
      ,source.[WednesdayOpenHours]
      ,source.[ThursdayOpenHours]
      ,source.[FridayOpenHours]
      ,source.[SaturdayOpenHours]
      ,source.[SundayOpenHours]
      ,source.[Photo1]
      ,source.[Photo2]
      ,source.[Photo3]
      ,source.[Photo4]
      ,source.[Photo5]
      ,source.[MenuUrl]
      ,source.[ReservationProviderName]
      ,source.[ReservationProviderUrl]
      ,source.[WebsiteUrl]
      ,source.[PhoneNumber]
      ,source.[PrimaryCuisine]
      ,source.[AllowsReservations]
      ,source.[CreatedOn]
	  ,'2024-12-01 00:00:00.000')    -- update the timestamp 
when matched 
and
(

isnull(target.[Name],'') != isnull(source.[Name],'')
or isnull(target.[Description],'') != isnull(source.[Description],'')
or isnull(target.[FullAddress],'') != isnull(source.[FullAddress],'')
or isnull(target.[StreetAddress],'') != isnull(source.[StreetAddress],'')
or isnull(target.[BillingCity],'') != isnull(source.[BillingCity],'')
or isnull(target.[Country],'') != isnull(source.[Country],'')
or isnull(target.[StateCode],'') != isnull(source.[StateCode],'')
or isnull(target.[PostalCode],'') != isnull(source.[PostalCode],'')
or isnull(target.[Latitude],'') != isnull(source.[Latitude],'')
or isnull(target.[Longitude],'') != isnull(source.[Longitude],'')
or isnull(target.[CuisineImageUrl],'') != isnull(source.[CuisineImageUrl],'')
or isnull(target.[LogoUrl],'') != isnull(source.[LogoUrl],'')
or isnull(target.[MondayOpenHours],'') != isnull(source.[MondayOpenHours],'')
or isnull(target.[TuesdayOpenHours],'') != isnull(source.[TuesdayOpenHours],'')
or isnull(target.[WednesdayOpenHours],'') != isnull(source.[WednesdayOpenHours],'')
or isnull(target.[ThursdayOpenHours],'') != isnull(source.[ThursdayOpenHours],'')
or isnull(target.[FridayOpenHours],'') != isnull(source.[FridayOpenHours],'')
or isnull(target.[SaturdayOpenHours],'') != isnull(source.[SaturdayOpenHours],'')
or isnull(target.[SundayOpenHours],'') != isnull(source.[SundayOpenHours],'')
or isnull(target.[Photo1],'') != isnull(source.[Photo1],'')
or isnull(target.[Photo2],'') != isnull(source.[Photo2],'')
or isnull(target.[Photo3],'') != isnull(source.[Photo3],'')
or isnull(target.[Photo4],'') != isnull(source.[Photo4],'')
or isnull(target.[Photo5],'') != isnull(source.[Photo5],'')
or isnull(target.[MenuUrl],'') != isnull(source.[MenuUrl],'')
or isnull(target.[ReservationProviderName],'') != isnull(source.[ReservationProviderName],'')
or isnull(target.[ReservationProviderUrl],'') != isnull(source.[ReservationProviderUrl],'')
or isnull(target.[WebsiteUrl],'') != isnull(source.[WebsiteUrl],'')
or isnull(target.[PhoneNumber],'') != isnull(source.[PhoneNumber],'')
or isnull(target.[PrimaryCuisine],'') != isnull(source.[PrimaryCuisine],'')
or isnull(target.[AllowsReservations],'') != isnull(source.[AllowsReservations],'')
or isnull(target.[CreatedOn],'') != isnull(source.[CreatedOn],'')


)

then update
set
target.[Name] = source.[Name],
target.[Description] = source.[Description],
target.[FullAddress] = source.[FullAddress],
target.[StreetAddress] = source.[StreetAddress],
target.[BillingCity] = source.[BillingCity],
target.[Country] = source.[Country],
target.[StateCode] = source.[StateCode],
target.[PostalCode] = source.[PostalCode],
target.[Latitude] = source.[Latitude],
target.[Longitude] = source.[Longitude],
target.[CuisineImageUrl] = source.[CuisineImageUrl],
target.[LogoUrl] = source.[LogoUrl],
target.[MondayOpenHours] = source.[MondayOpenHours],
target.[TuesdayOpenHours] = source.[TuesdayOpenHours],
target.[WednesdayOpenHours] = source.[WednesdayOpenHours],
target.[ThursdayOpenHours] = source.[ThursdayOpenHours],
target.[FridayOpenHours] = source.[FridayOpenHours],
target.[SaturdayOpenHours] = source.[SaturdayOpenHours],
target.[SundayOpenHours] = source.[SundayOpenHours],
target.[Photo1] = source.[Photo1],
target.[Photo2] = source.[Photo2],
target.[Photo3] = source.[Photo3],
target.[Photo4] = source.[Photo4],
target.[Photo5] = source.[Photo5],
target.[MenuUrl] = source.[MenuUrl],
target.[ReservationProviderName] = source.[ReservationProviderName],
target.[ReservationProviderUrl] = source.[ReservationProviderUrl],
target.[WebsiteUrl] = source.[WebsiteUrl],
target.[PhoneNumber] = source.[PhoneNumber],
target.[PrimaryCuisine] = source.[PrimaryCuisine],
target.[AllowsReservations] = source.[AllowsReservations],
target.LastModifiedOn = getutcdate(),
target.LastModifiedBy = getutcdate(); 


SELECT SUSER_SNAME();
GO

SELECT * FROM [Sandbox].[Seated].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-11-15'   -- imao 101 redova , gde ostatak od 120-101=19 redova pripada redovima koji su ranije unešeni u sistem    


SELECT * FROM [Sandbox].[Seated].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-12-01'   
ORDER BY TargetStartDate DESC

SELECT * 
FROM [Sandbox].[Seated].[RestaurantLocations_2] res1
INNER JOIN [Sandbox].[Seated].[RestaurantsStaging] res2 
ON res2.[restaurant_id] = res1.[SeatedSiteId]
--WHERE TargetStartDate = '2024-11-01'
--WHERE TargetStartDate = '2024-11-15'
WHERE TargetStartDate = '2024-12-01'


SELECT * 
FROM [Sandbox].[Seated].[RestaurantLocations_2] res1
INNER JOIN [Sandbox].[Seated].[RestaurantsStaging_2] res2 
ON res2.[restaurant_id] = res1.[SeatedSiteId]
WHERE TargetStartDate <> '2024-12-01'  

SELECT TOP 100 * FROM [Seated].[RestaurantsStaging_2]

-- WITH statement za vracanje redova koji su ranije unešeni u sistem 

;WITH MyTable AS (
SELECT distinct restaurant_id
FROM [Seated].[RestaurantsStaging]
)

select * 
FROM MyTable
JOIN [Seated].[RestaurantLocations_2] res1
ON MyTable.[restaurant_id] = res1.[SeatedSiteId]
--WHERE res1.TargetStartDate <> '2024-11-01'    
--WHERE res1.TargetStartDate <> '2024-11-15'     
WHERE res1.TargetStartDate <> '2024-12-01'     -- vraca nam 6 redova   (55-49=6 redova )

-- vratiti sve redove koji fale u excel-u u odnosu na inicijalni excel 

SELECT TOP 100 * FROM Master.dbo.DIN_Restaurant_Locations_Primary
ORDER BY Start_Date_1 DESC

-- SeatedLocationId koristimo da validiramo za onih 19 redova koji stoje u Locations , jer treba da imaju neku vrednost
-- starting point Staging tabela , u kojoj imamo 120 lokacija, 
-- izvucemo distinct pandan kolonu kolone SeatedLocationId ( = restaurant_id) iz Staging tabele 


SELECT COUNT(*) FROM  


--insert into [Sandbox].[Seated].[RestaurantLocations]
--(
--     [SeatedSiteId]
--      ,[Name]
--      ,[Description]
--      ,[FullAddress]
--      ,[StreetAddress]
--      ,[BillingCity]
--      ,[Country]
--      ,[StateCode]
--      ,[PostalCode]
--      ,[Latitude]
--      ,[Longitude]
--      ,[CuisineImageUrl]
--      ,[LogoUrl]
--      ,[MondayOpenHours]
--      ,[TuesdayOpenHours]
--      ,[WednesdayOpenHours]
--      ,[ThursdayOpenHours]
--      ,[FridayOpenHours]
--      ,[SaturdayOpenHours]
--      ,[SundayOpenHours]
--      ,[Photo1]
--      ,[Photo2]
--      ,[Photo3]
--      ,[Photo4]
--      ,[Photo5]
--      ,[MenuUrl]
--      ,[ReservationProviderName]
--      ,[ReservationProviderUrl]
--      ,[WebsiteUrl]
--      ,[PhoneNumber]
--      ,[PrimaryCuisine]
--      ,[AllowsReservations]
--      ,[CreatedOn]
--)



--SELECT distinct 
--	   [restaurant_id]
--      ,[name]
--      ,[description]
--      ,[full_address]
--      ,[street_address]
--      ,[Billing City]
--      ,[country]
--      ,[state_code]
--      ,[postal_code]
--      ,[latitude]
--      ,[longitude]
--      ,[Cuisine Image]
--      ,[Logo URL]
--      ,[monday_oh]
--      ,[tuesday_oh]
--      ,[wednesday_oh]
--      ,[thursday_oh]
--      ,[friday_oh]
--      ,[saturday_oh]
--      ,[sunday_oh]
--      ,[photo1]
--      ,[photo2]
--      ,[photo3]
--      ,[photo4]
--      ,[photo5]
--      ,[menu_url]
--      ,[reservation_provider_name]
--      ,[reservation_provider_url]
--      ,[Website Url]
--      ,[phone_number]
--      ,[primary_cuisine]
--      ,[Allows Reservations]
--	  ,'2024-07-01'
      
--  FROM [Sandbox].[Seated].[RestaurantsStaging]
--  where restaurant_id is not null
