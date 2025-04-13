SELECT TOP (1000) [Id]
		,[isexcluded]
		,[targetstartdate]
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
      ,[SalesForceId]
      ,[SiteId]
      ,[IsExcluded]
      ,[CreatedOn]
      ,[CreatedBy]
      ,[LastModifiedOn]
      ,[LastModifiedBy]


	  --FROM [Sandbox].[ResSpecial].[RestaurantLocations_2]
  FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec]
  where TargetStartDate = '2024-12-15 00:00:00.000'
  order by CreatedOn desc    
  -- dobijamo samo aktuelne podatke iz RestaurantLocations tabele za poslednji Additions load koji smo radili u mesecu 


  --2ND 

  select s.Name, 
			--rlp.Restaurant_Name, 
			s.isexcluded,      
			s.StreetAddress, 
			--rlp.Address_1, 
			s.PostalCode, *
			--rlp.Zip,
			--rlp.Start_Date_1,
			--rlp.OOB_Date, 
			--rlp.Active_Partner
    --update s set s.siteid = rlp.id, isexcluded = 1 
--    FROM   [Sandbox].[ResSpecial].[RestaurantLocations_2] s
	  FROM   [Sandbox].[ResSpecial].[RestaurantLocations_spec] s
	--INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging]) r ON r.Restaurant_Id = s.ResSpecialsiteID
	INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging_spec]) r ON r.Restaurant_Id = s.ResSpecialsiteID
	inner join master.dbo.Restaurant_Locations rlp on rlp.ResSpecialLocationId = s.ResSpecialsiteID
	--and rlp.Restaurant_Name  like '%' + left(s.Name,5) + '%'
	--and left(rlp.Address_1,4) = left(ltrim(s.StreetAddress),4)
	--and right(concat('0000',ltrim(rtrim(s.PostalCode))),5) = left(rlp.Zip,5)
	--and rlp.Active_Partner in (1,5)
  where 
  targetstartdate  = '2023-12-15 00:00:00.000'
   and rlp.ResSpecialLocationId = s.ResSpecialsiteID 
  and 
  s.SiteId is null
  order by s.StreetAddress desc 


!!!!!!!  !!!!!!!  --  slicing logic with distinct Restaurant_id instead of WHERE targetStartDate 

  --3rd 
  
  select s.Name, 
		s.SiteId,  
		rlp.Restaurant_Name, 
		s.StreetAddress, 
		rlp.Address_1, 
		s.PostalCode, 
		rlp.Zip,
		rlp.Start_Date_1, 
		rlp.Active_Partner
--    FROM   [Sandbox].[ResSpecial].[RestaurantLocations_2] s
	    FROM   [Sandbox].[ResSpecial].[RestaurantLocations_spec] s
	inner join master.dbo.Restaurant_Locations rl on left(rl.Restaurant_Name,5) = left(s.Name,5)
	and left(rl.Address_1,4) = left(ltrim(s.StreetAddress),4)
	and rl.Active_Partner in (1,5)
  where targetstartdate = '2023-12-15 00:00:00.000' 
  and s.SiteId is null
  order by 3       

   --select * from master.dbo.Restaurant_Locations 
   --where Target_Term_Date  = '2024-12-15 00:00:00.000'   -- naci pandan koloni TargetStartDate , Start_Date_1 , Timestamp 

  --  select count(*) from master.dbo.Restaurant_Locations 
  --  select top 100 * , Active_Partner from master.dbo.Restaurant_Locations


 select * from Master.dbo.Restaurant_Status
-- status Restorana (1 Active partner, 3 Out of Business, 5 Corporate HQ Location, 12 Franchise No Contract)

  
-- 5th query 
-- see below beautified SQL like source ([RestaurantLocations_2]), 
-- with added "SiteId" and "IsExcluded" fields 

  select ResSpecialSiteId, Name, FullAddress, StreetAddress, BillingCity, StateCode, PostalCode, Latitude,Longitude, WebsiteUrl, PhoneNumber, PrimaryCuisine, TargetStartDate
    FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] s
  where targetstartdate  = '2023-12-01 00:00:00.000' 
  --and s.SiteId is null
  order by 3  

			-- running for validation number of records which we are supossed to obtain 

SELECT ResSpecialSiteId,
		SiteId, 
		IsExcluded,
        [Name],
        FullAddress,
        StreetAddress,
        BillingCity,
        StateCode,
        PostalCode,
        Latitude,
        Longitude,
        WebsiteUrl,
        PhoneNumber,
        PrimaryCuisine,
        TargetStartDate
--FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] s
FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec] s
WHERE targetstartdate = '2023-12-15 00:00:00.000' 
	--and s.SiteId is null
ORDER BY  5   

  --6th  

-- updating the field IsExcluded in getting the value '1' inside [RestaurantLocations_2] table 
-- for the restaurants inside WHERE clause, by that getting the flag on 'IsExlcuded' value of '1'

  select *
  --update s set s.IsExcluded = 1
  --FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] s
  FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec] s
  where targetstartdate  = '2023-12-15 00:00:00.000'
  
  or [name] like '%offici%'
  or [name] like '%gyps%kit%' --   Gypsy Kitchen, 
  or [name] like '%milto%bl%mou%'  
  or [name] like '%milt%cui%'
  or [name] like '%Asellina%'
  or [name] like '%STK%'
  or [name] like '%Boqueria%'    
  or [name] like '%Rosa%Mexic%'
  or [name] like '%chido%pad%' 
  or [name] like '%ocean%acr%' --   Ocean & Acre, 
  or [name] like '%big%ketch%'
  or [name] like '%Bagatelle%'
  or [name] like '%Kona%Grill%'
  or [name] like '%Manhattan%'
  or [name] like '%blind%pig%' --   The blind Pig Parlour Bar, 
  or [name] like '%south%gent%' --  Southern Gentlemen, 
  or [name] like '%lizz%cant%' --  The Lizzy Cantina
  or [name] like '%dock%oyst%' --   Dock's Oyster Bar, 
  or [name] like '%isabelle%' --   Isabelle's Osteria, 
  or [name] like '%jane%rest%' --   Jane Restaurant, 
  or [name] like '%purdy%'
  or [name] like '%tamam%fala%'
  )  
   



  --with cte as (
  --  select sf4.AccountName ThirdParent,sf3.AccountName SecondParent ,sf2.AccountName FirstParent, sf.*
  --from integrations.SalesForce.sfsync sf
  --left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  --left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  --left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as
  --where sf.LocationType = 'Location'
  --)

 --select count(*) from integrations.SalesForce.sfsync sf

 select db_name();
 use Sandbox;

--7th 
	-- match-ing with Salesforce  
		-- salesforce with additional information on restaurants , legal entities and opportunities 
			-- 

with cte as (
    select 
	s.IsExcluded, 
	s.ResSpecialSiteId, 
	sf.AccountID, 
	s.Name, 
	sf.AccountName, 
	s.StreetAddress, 
	sf.BillingAddressLine1, 
	s.PostalCode, 
	sf.BillingZipPostalCode,
	ROW_NUMBER () over (partition by s.ResSpecialSiteId order by s.ResSpecialSiteId) as rnk
	,sf2.AccountName FirstParent
	,sf3.AccountName SecondParent 
	,sf4.AccountName ThirdParent
  --update s set s.IsExcluded = 1   
  --FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] s 
  FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec] s 
  inner join Integrations.salesforce.sfsync sf on 1=1  -- the JOIN 'sf' to 's' to establish the relationship between the main entity and its first-level parent (e.g., linking accounts to their immediate parent).
  and left(sf.accountname, 
			case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) 
			= left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end )

  and left(sf.billingaddressline1,5) = left(s.streetaddress,5)
  and right(concat('0000',sf.BillingZipPostalCode),5) = right(concat('0000', s.postalcode),5)


  and sf.locationtype = 'Location'
  -- hierarchical relationship for getting the ParentAccount on AccountID 
  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as
  -- lEFT JOIN for returning the same data from initial innerjoin structure, in case there is no child-parent relation , i.e. AccountID has no matching ParentAccountID 
  
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging]) r 
    INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging_spec]) r 
    ON r.Restaurant_Id = s.ResSpecialsiteID
  --inner join master.dbo.Restaurant_Locations rl on rl.ResSpecialLocationId = s.ResSpecialsiteID

  --where
  --s.targetstartdate  = '2023-11-15 00:00:00.000' and  -- instead of WHERE targetstartdate we rather be going with JOIN conditions with distinct restaurant_id from RestStaging tbl
  --s.ResSpecialSiteID = sf2.ResSpecialLocationID
	-- instead of 'targetstartdate' we use subset the ones from [Staging]   (where AccountId IS NULL) 
	-- i ResSpecialLocationID (nvarchar(50)) from SalesForce.sfsync tbl  =   RestaurantLocations.ResSpecialSiteID (nvarchar(512)) 
--  and s.SalesForceId is null 
)

, cte2 as (
select ResSpecialsiteid, count(*) as cnt
from cte 
group by ResSpecialSiteId
having count(*) = 1 
) 

--update [Sandbox].[ResSpecial].[RestaurantLocations_2] set [Sandbox].[ResSpecial].[RestaurantLocations_2].[SalesForceId] = sf2.Accountid

select 
s.isExcluded, c.*
--update s set s.SalesForceId = c.Accountid
from cte c
inner join cte2 c2 on c.ResSpecialSiteId = c2.ResSpecialSiteId
--inner join [Sandbox].[ResSpecial].[RestaurantLocations_2] s on s.ResSpecialSiteId = c.ResSpecialSiteId
inner join [Sandbox].[ResSpecial].[RestaurantLocations_spec] s on s.ResSpecialSiteId = c.ResSpecialSiteId
order by 3  

							
--select SalesForceId , * from [ResSpecial].[RestaurantLocations_2]
select SalesForceId , * from [ResSpecial].[RestaurantLocations_spec]
 where targetstartdate  = '2023-12-15 00:00:00.000'
 and SalesForceId IS NOT NULL

--select SalesForceId , * from [ResSpecial].[RestaurantLocations_2] 
select SalesForceId , * from [ResSpecial].[RestaurantLocations_spec]
 where targetstartdate  = '2023-12-15 00:00:00.000'
 and SalesForceId IS NULL


 --update [ResSpecial].[RestaurantLocations_2] 
 --set SalesForceId = NULL
 --where targetstartdate = '2024-12-01 00:00:00.000'
 --and SalesForceId IS NOT NULL

--



--update [Sandbox].[ResSpecial].[RestaurantLocations_2] 
--set 
--SalesForceId = c.Accountid,
--IsExcluded = 1
--where SiteId is  not null


  select sf.accountid, sf4.AccountName,sf3.AccountName,sf2.AccountName, sf.*
  from integrations.SalesForce.sfsync sf
  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as
  where sf.accountid collate latin1_general_cs_as in (

'001Qm00000BOVm0',
'001Qm00000Bwd9V'
--'001Qm00000By7hp',
--'0014600000tgZer',
--  '0014600001Vhetn',
--'0014600000pznX6')





-- 8th 

with cte as (
    select s.SalesForceId, s.ResSpecialSiteId, sf.AccountID, s.Name, sf.AccountName, s.StreetAddress, sf.BillingAddressLine1, s.PostalCode, sf.BillingZipPostalCode,
	 ROW_NUMBER () over (partition by s.ResSpecialSiteId order by s.ResSpecialSiteId) as rnk
	,sf2.AccountName FirstParent
	,sf3.AccountName SecondParent 
	,sf4.AccountName ThirdParent
  --update s set s.IsExcluded = 1
  --FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] s 
  FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec] s 
  inner join Integrations.salesforce.sfsync sf on 1=1 
  and sf.AccountName like '%' + left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end ) + '%'
  --and left(sf.accountname, case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) = left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end )

  and left(sf.billingaddressline1,5) = left(s.streetaddress,5) -
  and right(concat('0000',sf.BillingZipPostalCode),5) = right(concat('0000', s.postalcode),5) 


  and sf.locationtype = 'Location'

  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as

  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging]) r 
  INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging_spec]) r 
  ON r.Restaurant_Id = s.ResSpecialsiteID
  --where s.targetstartdate  = '2023-11-15 00:00:00.000'
  --and s.SalesForceId is null 
)

, cte2 as (
select ResSpecialsiteid, count(*) as cnt
from cte 
group by ResSpecialSiteId
having count(*) = 1
) 
select c.Accountid, c.*
--update s set s.SalesForceId = c.Accountid
from cte c
inner join cte2 c2 on c.ResSpecialSiteId = c2.ResSpecialSiteId
--inner join [Sandbox].[ResSpecial].[RestaurantLocations_2] s on s.ResSpecialSiteId = c.ResSpecialSiteId
inner join [Sandbox].[ResSpecial].[RestaurantLocations_spec] s on s.ResSpecialSiteId = c.ResSpecialSiteId
order by 3




-- 9th 

with cte as (
    select s.ResSpecialSiteId, sf.AccountID, s.Name, sf.AccountName, s.StreetAddress, sf.BillingAddressLine1, s.PostalCode, sf.BillingZipPostalCode,
	ROW_NUMBER () over (partition by s.ResSpecialSiteId order by s.ResSpecialSiteId) as rnk
	,sf2.AccountName FirstParent
	,sf3.AccountName SecondParent 
	,sf4.AccountName ThirdParent
  --update s set s.IsExcluded = 1
  --FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] s 
    FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec] s 
  inner join Integrations.salesforce.sfsync sf on 1=1
  
  and sf.AccountName like '%' + left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end ) + '%'
  --and left(sf.accountname, case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) = left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end )

  and left(sf.billingaddressline1,5) = left(s.streetaddress,5)
  --and right(concat('0000',sf.BillingZipPostalCode),5) = right(concat('0000', s.postalcode),5)


  and sf.locationtype = 'Location'

  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as 
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging]) r 
   INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging_spec]) r
  ON r.Restaurant_Id = s.ResSpecialsiteID
  --where s.targetstartdate  = '2023-11-15 00:00:00.000'
  --and s.SalesForceId is null
)

, cte2 as (
select ResSpecialsiteid, count(*) as cnt
from cte 
group by ResSpecialSiteId
having count(*) = 1
)
select s.SalesForceId,
	c.Accountid,
	c.*
--update s set s.SalesForceId = c.Accountid
from cte c
inner join cte2 c2 on c.ResSpecialSiteId = c2.ResSpecialSiteId
--inner join [Sandbox].[ResSpecial].[RestaurantLocations_2] s on s.ResSpecialSiteId = c.ResSpecialSiteId
inner join [Sandbox].[ResSpecial].[RestaurantLocations_spec] s on s.ResSpecialSiteId = c.ResSpecialSiteId
--where s.SalesForceId = c.Accountid COLLATE SQL_Latin1_General_CP1_CI_AS
order by 3




 --10th 
with cte as (
    select s.ResSpecialSiteId, sf.AccountID, s.Name, sf.AccountName, s.StreetAddress, sf.BillingAddressLine1, s.PostalCode, sf.BillingZipPostalCode,
	ROW_NUMBER () over (partition by s.ResSpecialSiteId order by s.ResSpecialSiteId) as rnk
	,sf2.AccountName FirstParent
	,sf3.AccountName SecondParent 
	,sf4.AccountName ThirdParent
  --update s set s.IsExcluded = 1
  --FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] s 
    FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec] s 

  inner join Integrations.salesforce.sfsync sf on 1=1
  
  and left(sf.accountname, case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) like '%' + left(s.name,2) + '%'
  --and left(sf.accountname, case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) = left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end )

  and left(ltrim(rtrim(sf.billingaddressline1)),3) = left(ltrim(rtrim(s.streetaddress)),3)
  and right(concat('0000',sf.BillingZipPostalCode),3) = right(concat('0000', s.postalcode),3)


  and sf.locationtype = 'Location'

  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging_2]) r 
    INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging_spec]) r 

  ON r.Restaurant_Id = s.ResSpecialsiteID
  --where s.targetstartdate  = '2023-11-15 00:00:00.000'
  --and s.SalesForceId is null
  --and s.IsExcluded = 0
  --and s.Name not like 'The%'
  --and sf3.AccountName = 'ResSpecial Locations - On Hold'
  --and s.ResSpecialSiteId <> 16299
--  and s.ResSpecialSiteId in (
--16510,
--16536,
--15732,
--16559,
--16496)
)

, cte2 as (
select ResSpecialsiteid, count(*) as cnt
from cte 
group by ResSpecialSiteId
having count(*) = 1
)
select s.SalesForceId, 
		s.IsExcluded,
		c.*
--update s set s.SalesForceId = c.Accountid
from cte c
inner join cte2 c2 on c.ResSpecialSiteId = c2.ResSpecialSiteId
--inner join [Sandbox].[ResSpecial].[RestaurantLocations] s on s.ResSpecialSiteId = c.ResSpecialSiteId
inner join [Sandbox].[ResSpecial].[RestaurantLocations_spec] s on s.ResSpecialSiteId = c.ResSpecialSiteId
order by 3





--11th
select replace(name,'’',''''), *
--update s set s.salesforceid = sf.accountid
--FROM [Sandbox].[ResSpecial].[RestaurantLocations_2] s 
FROM [Sandbox].[ResSpecial].[RestaurantLocations_spec] s 

left join Integrations.SalesForce.SfSync sf on sf.GUID = cast(s.SiteId as nvarchar(25))
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging]) r 
    INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[ResSpecial].[RestaurantsStaging_spec]) r 

  ON r.Restaurant_Id = s.ResSpecialsiteID
--where s.targetstartdate  = '2023-12-01 00:00:00.000' and s.SalesForceId is null
 order by 4
