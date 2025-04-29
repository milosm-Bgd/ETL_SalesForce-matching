

select * from [Sandbox].[ResSpecial].[RestaurantLocations]
																												
select * from [Sandbox].[ResSpecial].[RestaurantLocations_2] 

TRUNCATE TABLE [Sandbox].[ResSpecial].[RestaurantLocations_2]


--INSERT INTO [Sandbox].[ResSpecial].[RestaurantLocations_2]
SELECT * FROM [Sandbox].[ResSpecial].[RestaurantLocations]
WHERE TargetStartDate <> '2024-11-01'

SELECT * FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] 
													
SELECT * FROM [Sandbox].[ResSpecial].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-11-01' 

SELECT * FROM [Sandbox].[ResSpecial].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-11-15' 

ALTER TABLE [ResSpecial].[RestaurantLocations_2] ALTER COLUMN IsExcluded bit NOT NULL DEFAULT (0);
ALTER TABLE [ResSpecial].[RestaurantLocations_2] ALTER COLUMN IsExcluded bit NULL;
ALTER TABLE [ResSpecial].[RestaurantLocations_2] ALTER COLUMN CreatedBy nvarchar(50) NULL;
-- alternativa radimo preko Table design gde odaberemo column properities i tamo odradimo izmene

merge into [Sandbox].[ResSpecial].[RestaurantLocations_2] as target
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
      
  FROM [Sandbox].[ResSpecial].[RestaurantsStaging]
  where restaurant_id is not null
) as source 
([ResSpecialSiteId]   
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

on source.[ResSpecialSiteId] = target.[ResSpecialSiteId] 

when not matched then insert 
([Id]
,[ResSpecialSiteId]
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
	  ,source.[ResSpecialSiteId]
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

SELECT * FROM [Sandbox].[ResSpecial].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-11-15'    


SELECT * FROM [Sandbox].[ResSpecial].[RestaurantLocations_2]
WHERE TargetStartDate = '2024-12-01'   
ORDER BY TargetStartDate DESC

SELECT * 
FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] res1
INNER JOIN [Sandbox].[ResSpecial].[RestaurantsStaging] res2 
ON res2.[restaurant_id] = res1.[ResSpecialSiteId]
--WHERE TargetStartDate = '2024-11-01'
--WHERE TargetStartDate = '2024-11-15'
WHERE TargetStartDate = '2024-12-01'


SELECT * 
FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] res1
INNER JOIN [Sandbox].[ResSpecial].[RestaurantsStaging_2] res2 
ON res2.[restaurant_id] = res1.[ResSpecialSiteId]
WHERE TargetStartDate <> '2024-12-01'  

SELECT TOP 100 * FROM [ResSpecial].[RestaurantsStaging_2]

-- WITH statement za vracanje redova koji su ranije unešeni u sistem 

;WITH MyTable AS (
SELECT distinct restaurant_id
FROM [ResSpecial].[RestaurantsStaging]
)

select * 
FROM MyTable
JOIN [ResSpecial].[RestaurantLocations_2] res1
ON MyTable.[restaurant_id] = res1.[ResSpecialSiteId]
--WHERE res1.TargetStartDate <> '2024-11-01'    
--WHERE res1.TargetStartDate <> '2024-11-15'     
WHERE res1.TargetStartDate <> '2024-12-01'   

-- vratiti sve redove koji fale u excel-u u odnosu na inicijalni excel 

-- ResSpecialLocationId koristimo da validiramo za onih 19 redova koji stoje u Locations , jer treba da imaju neku vrednost
-- starting point Staging tabela , u kojoj imamo 120 lokacija, 
-- izvucemo distinct pandan kolonu kolone ResSpecialLocationId ( = restaurant_id) iz Staging tabele 


SELECT COUNT(*) FROM  


--insert into [Sandbox].[ResSpecial].[RestaurantLocations]
--(
--     [ResSpecialSiteId]
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
      
--  FROM [Sandbox].[ResSpecial].[RestaurantsStaging]
--  where restaurant_id is not null
