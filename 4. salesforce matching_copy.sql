SELECT TOP (1000) [Id]
		,[isexcluded]
		,[targetstartdate]
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
      ,[SalesForceId]
      ,[SiteId]
      ,[IsExcluded]
      ,[CreatedOn]
      ,[CreatedBy]
      ,[LastModifiedOn]
      ,[LastModifiedBy]


	  --FROM [Sandbox].[Seated].[RestaurantLocations_2]
  FROM [Sandbox].[Seated].[RestaurantLocations_spec]
  where TargetStartDate = '2024-12-15 00:00:00.000'
  order by CreatedOn desc    
  -- dobijamo samo aktuelne podatke iz RestaurantLocations tabele za poslednji Additions load koji smo radili u mesecu 


  --2ND QUERY
  --2nd query -  UPDATE QUERY !!! ( menjamo redosled izvrsavanja 2. i 3. skripte, prvo ide 3. pa 2. !)
 -- ovde ukrštavamo ponovo sa istom tabelom kao iz prethodnog query-ja samo za one restorane rlp tabele čije se 
 -- ime podudara sa prvih 5 slova imena restorana iz RestaurantLocations tabele 
  select s.Name, 
			--rlp.Restaurant_Name, 
			s.isexcluded,            -- 25.11.24:  ja dodao kolonu 
			s.StreetAddress, 
			--rlp.Address_1, 
			s.PostalCode, *
			--rlp.Zip,
			--rlp.Start_Date_1,
			--rlp.OOB_Date, 
			--rlp.Active_Partner
    --update s set s.siteid = rlp.id, isexcluded = 1      -- ranujemo UPDATE radi flegovanja rekorda koji su vec u bazi !!! 
--    FROM   [Sandbox].[Seated].[RestaurantLocations_2] s
	  FROM   [Sandbox].[Seated].[RestaurantLocations_spec] s
	--INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging]) r ON r.Restaurant_Id = s.seatedsiteID
	INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging_spec]) r ON r.Restaurant_Id = s.seatedsiteID
	inner join master.dbo.Din_Restaurant_Locations_Primary rlp on rlp.SeatedLocationId = s.seatedsiteID
	--and rlp.Restaurant_Name  like '%' + left(s.Name,5) + '%'
	--and left(rlp.Address_1,4) = left(ltrim(s.StreetAddress),4)
	--and right(concat('0000',ltrim(rtrim(s.PostalCode))),5) = left(rlp.Zip,5)
	--and rlp.Active_Partner in (1,5)
  where 
  targetstartdate  = '2024-12-15 00:00:00.000'       -- treba izmeniti da gadja sve lokacije u Staging tabeli 
   and rlp.SeatedLocationId = s.seatedsiteID 		-- + jos jedan korak / uslov SeatedLocationId da bude JOIN ON condition = seatedsiteID RestLocations tabele 
  and 
  s.SiteId is null
  order by s.StreetAddress desc 


!!!!!!!  !!!!!!!  -- dalje idemo sa istom logikom slajsovanjem sa distinct Restaurant_id a ne preko WHERE targetStartDate 

  --3rd query
  -- ovde imamo ukrštavanje sa Restaurant_Locations_Primary tebelom iz back-office baze na RestaurantName polju gde ciljamo 
  --status aktivnog partnera 1 ili 5 
  select s.Name, 
		s.SiteId,   -- 26.11. dodata kolona 
		rlp.Restaurant_Name, 
		s.StreetAddress, 
		rlp.Address_1, 
		s.PostalCode, 
		rlp.Zip,
		rlp.Start_Date_1, 
		rlp.Active_Partner
--    FROM   [Sandbox].[Seated].[RestaurantLocations_2] s
	    FROM   [Sandbox].[Seated].[RestaurantLocations_spec] s
	inner join master.dbo.Din_Restaurant_Locations_Primary rlp on left(rlp.Restaurant_Name,5) = left(s.Name,5)
	and left(rlp.Address_1,4) = left(ltrim(s.StreetAddress),4)
	and rlp.Active_Partner  in (1,5)
  where targetstartdate = '2024-12-15 00:00:00.000' -- testiranje BETWEEN '2024-10-01 00:00:00.000' AND '2024-12-31 00:00:00.000' 
  and s.SiteId is null
  order by 3       

   --select * from master.dbo.Din_Restaurant_Locations_Primary 
   --where Target_Term_Date  = '2024-12-15 00:00:00.000'   -- naci pandan koloni TargetStartDate , Start_Date_1 , Timestamp 

  --  select count(*) from master.dbo.Din_Restaurant_Locations_Primary 
  --  select top 100 * , Active_Partner from master.dbo.Din_Restaurant_Locations_Primary


 select * from Master.dbo.Din_Restaurant_Status
-- status Restorana (1 Active partner, 3 Out of Business, 5 Corporate HQ Location, 12 Franchise No Contract)

  
-- 5th query 
-- ispod ranujemo scriptu (beautified SQL) sa preimenovanom tabelom odakle povlačimo ([RestaurantLocations_2]), 
--sa dodatim "SiteId" i "IsExcluded" poljima 

  select SeatedSiteId, Name, FullAddress, StreetAddress, BillingCity, StateCode, PostalCode, Latitude,Longitude, WebsiteUrl, PhoneNumber, PrimaryCuisine, TargetStartDate
    FROM [Sandbox].[Seated].[RestaurantLocations_2] s
  where targetstartdate  = '2024-12-01 00:00:00.000' 
  --and s.SiteId is null
  order by 3  

			-- ranovanje služi kao validacija broja rekorda koje treba da dobijemo 

SELECT SeatedSiteId,
		SiteId, --dodatno polje
		IsExcluded,  --dodatno polje
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
--FROM [Sandbox].[Seated].[RestaurantLocations_2] s
FROM [Sandbox].[Seated].[RestaurantLocations_spec] s
WHERE targetstartdate = '2024-12-15 00:00:00.000' 
	--and s.SiteId is null
ORDER BY  5   

  --6th query 

-- ovde hoćemo da apdejtujemo IsExcluded da dobije vrednost 1 u [RestaurantLocations_2] tabeli 
-- i to za one restorane navedene u WHERE clause-u, čime ujedno dobijaju flag za 'IsExlcuded' na 1

  select *
  --update s set s.IsExcluded = 1			-- nema potreba za aktiviranjem UPDATE statement-a jer vraca 0 rows kada odemo na pure SELECT 
  --FROM [Sandbox].[Seated].[RestaurantLocations_2] s
  FROM [Sandbox].[Seated].[RestaurantLocations_spec] s
  where targetstartdate  = '2024-12-15 00:00:00.000'
  and ([name] like '%uncle%jack%'
  or [name] like '%hard%rock%'
  or [name] like '%offici%'
  or [name] like '%Asellina%'
  or [name] like '%Bagatelle%'
  or [name] like '%Kona%Grill%'
  or [name] like '%Manhattan%' -- One Manhattan
  or [name] like '%STK%'
  or [name] like '%Boqueria%'    
  or [name] like '%Rosa%Mexic%'
  or [name] like '%chido%pad%' --   Chido&Padre, 
  or [name] like '%gyps%kit%' --   Gypsy Kitchen, 
  or [name] like '%milto%bl%mou%' --   Milton's Black Mountain, 
  or [name] like '%milt%cui%' --   Milton's Cuisine, 
  or [name] like '%ocean%acr%' --   Ocean & Acre, 
  or [name] like '%big%ketch%' --   The Big Ketch Saltwater Grill, 
  or [name] like '%blind%pig%' --   The blind Pig Parlour Bar, 
  or [name] like '%south%gent%' --  Southern Gentlemen, 
  or [name] like '%lizz%cant%' --  The Lizzy Cantina
  or [name] like '%dock%oyst%' --   Dock's Oyster Bar, 
  or [name] like '%isabelle%' --   Isabelle's Osteria, 
  or [name] like '%jane%rest%' --   Jane Restaurant, 
  or [name] like '%sarabeth%' --   Sarabeth's, 
  or [name] like 'hudson%' --   Hudson, 
  or [name] like '%purdy%' --   Purdy's, 
  or [name] like '%tamam%fala%' --   Tamama Falafel
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

--7th query
	-- odavde radimo match-ovanje sa Salesforce-om  
		-- salesforce sadrze dodatne informacije o restoranima i njihovim legal entity i opportunity-ma 
			-- na salesforce se pravi opportunity od strane sales team-a
			-- 

with cte as (
    select 
	s.IsExcluded, 
	s.SeatedSiteId, 
	sf.AccountID, 
	s.Name, 
	sf.AccountName, 
	s.StreetAddress, 
	sf.BillingAddressLine1, 
	s.PostalCode, 
	sf.BillingZipPostalCode,
	ROW_NUMBER () over (partition by s.SeatedSiteId order by s.SeatedSiteId) as rnk
	,sf2.AccountName FirstParent
	,sf3.AccountName SecondParent 
	,sf4.AccountName ThirdParent
  --update s set s.IsExcluded = 1   
  --FROM [Sandbox].[Seated].[RestaurantLocations_2] s 
  FROM [Sandbox].[Seated].[RestaurantLocations_spec] s 
  inner join Integrations.salesforce.sfsync sf on 1=1  -- the JOIN 'sf' to 's' to establish the relationship between the main entity and its first-level parent (e.g., linking accounts to their immediate parent).
  and left(sf.accountname, 
			case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) 
			= left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end )

  and left(sf.billingaddressline1,5) = left(s.streetaddress,5)
  and right(concat('0000',sf.BillingZipPostalCode),5) = right(concat('0000', s.postalcode),5)


  and sf.locationtype = 'Location'
  -- hierarchical relationship se koristi da bismo izvukli ParentAccount za svakog AccountID-a 
  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as
  -- lEFT JOIN kako bi izbacio iste podatke iz inicijalne innerjoin formacije , u slucaju da nema relacije child-parent, tj. da AccountID nema ParentAccountID 
  
  --deo koji menjamo da bi zamenili WHERE condition
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging]) r 
    INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging_spec]) r 

  ON r.Restaurant_Id = s.seatedsiteID
  --inner join master.dbo.Din_Restaurant_Locations_Primary rlp on rlp.SeatedLocationId = s.seatedsiteID

  --where
  --s.targetstartdate  = '2024-11-15 00:00:00.000' and  -- treba da iskljucimo WHERE targetstartdate uslov , i umetnemo join uslov sa distinct restaurant_id iz RestStaging tabele
  --s.seatedSiteID = sf2.seatedLocationID
	-- umesto targetstartdate koristimo subset onih u Stagingu (where AccountId IS NULL) 
	-- i seatedLocationID (nvarchar(50)) iz SalesForce.sfsync tabele = RestaurantLocations.seatedSiteID (nvarchar(512)) 
--  and s.SalesForceId is null 
)

, cte2 as (
select seatedsiteid, count(*) as cnt
from cte 
group by SeatedSiteId
having count(*) = 1 
) 

--update [Sandbox].[Seated].[RestaurantLocations_2] set [Sandbox].[Seated].[RestaurantLocations_2].[SalesForceId] = sf2.Accountid
--ne radi nijedna kombinacija pri ranovanju update komande u okviru 7th query-a, izbacuje mi error " 'sf2.Accountid' could not be bound ".

select 
s.isExcluded, c.*
--update s set s.SalesForceId = c.Accountid
from cte c
inner join cte2 c2 on c.SeatedSiteId = c2.SeatedSiteId
--inner join [Sandbox].[Seated].[RestaurantLocations_2] s on s.SeatedSiteId = c.SeatedSiteId
inner join [Sandbox].[Seated].[RestaurantLocations_spec] s on s.SeatedSiteId = c.SeatedSiteId
order by 3  

							
--select SalesForceId , * from [seated].[RestaurantLocations_2]
select SalesForceId , * from [seated].[RestaurantLocations_spec]
 where targetstartdate  = '2024-12-15 00:00:00.000'
 and SalesForceId IS NOT NULL

--select SalesForceId , * from [seated].[RestaurantLocations_2] 
select SalesForceId , * from [seated].[RestaurantLocations_spec]
 where targetstartdate  = '2024-12-15 00:00:00.000'
 and SalesForceId IS NULL


-- OTVORENO: DA LI RANUJEMO OVAJ DEO SKRIPTE RADI RESETOVANJA POLJA SalesForceID = NULL ????????????????????  
 --update [seated].[RestaurantLocations_2] 
 --set SalesForceId = NULL
 --where targetstartdate  = '2024-12-01 00:00:00.000'
 --and SalesForceId IS NOT NULL

--end of 7th query



--update [Sandbox].[Seated].[RestaurantLocations_2] 
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

  -- collate sluzi da se napravi distinkcija tj. ukljuci case sensitivity!

  '001Qm00000BOVm0',
'001Qm00000Bwd9V'


--'001Qm00000By7hp',
--'0014600000tgZer',

--  '0014600001Vhetn',
--'0014600000pznX6'


)








-- 8th query (skoro identican sedmom)

with cte as (
    select s.SalesForceId, s.SeatedSiteId, sf.AccountID, s.Name, sf.AccountName, s.StreetAddress, sf.BillingAddressLine1, s.PostalCode, sf.BillingZipPostalCode,
	ROW_NUMBER () over (partition by s.SeatedSiteId order by s.SeatedSiteId) as rnk
	,sf2.AccountName FirstParent
	,sf3.AccountName SecondParent 
	,sf4.AccountName ThirdParent
  --update s set s.IsExcluded = 1
  --FROM [Sandbox].[Seated].[RestaurantLocations_2] s 
  FROM [Sandbox].[Seated].[RestaurantLocations_spec] s 
  inner join Integrations.salesforce.sfsync sf on 1=1 
  and sf.AccountName like '%' + left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end ) + '%' -- za one Account-e iz sf tabele čija se imena podudaraju sa poljem name iz RestaurantLocations tabele
  --and left(sf.accountname, case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) = left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end )

  and left(sf.billingaddressline1,5) = left(s.streetaddress,5) -- dalji uslov podudaranja dve kolone iz dve različite tabele 
  and right(concat('0000',sf.BillingZipPostalCode),5) = right(concat('0000', s.postalcode),5)  -- dalji uslov podudaranja dve kolone iz dve različite tabele


  and sf.locationtype = 'Location'

  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as

  --umecemo jos jedan join umesto WHERE condition-a 
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging]) r 
  INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging_spec]) r 
  ON r.Restaurant_Id = s.seatedsiteID
  --where s.targetstartdate  = '2024-11-15 00:00:00.000'
  --and s.SalesForceId is null   -- šta proveramo ovim uslovom   ?????
)

, cte2 as (
select seatedsiteid, count(*) as cnt
from cte 
group by SeatedSiteId
having count(*) = 1
)   -- vraća nam samo one SeatedSiteId / restaurant_id koji se samo jedanput pojavljuju u cte tabeli, tj nema duplikata 
select c.Accountid, c.*
--update s set s.SalesForceId = c.Accountid
from cte c
inner join cte2 c2 on c.SeatedSiteId = c2.SeatedSiteId
--inner join [Sandbox].[Seated].[RestaurantLocations_2] s on s.SeatedSiteId = c.SeatedSiteId
inner join [Sandbox].[Seated].[RestaurantLocations_spec] s on s.SeatedSiteId = c.SeatedSiteId
order by 3






-- 9th query
with cte as (
    select s.SeatedSiteId, sf.AccountID, s.Name, sf.AccountName, s.StreetAddress, sf.BillingAddressLine1, s.PostalCode, sf.BillingZipPostalCode,
	ROW_NUMBER () over (partition by s.SeatedSiteId order by s.SeatedSiteId) as rnk
	,sf2.AccountName FirstParent
	,sf3.AccountName SecondParent 
	,sf4.AccountName ThirdParent
  --update s set s.IsExcluded = 1
  --FROM [Sandbox].[Seated].[RestaurantLocations_2] s 
    FROM [Sandbox].[Seated].[RestaurantLocations_spec] s 
  inner join Integrations.salesforce.sfsync sf on 1=1
  
  and sf.AccountName like '%' + left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end ) + '%'
  --and left(sf.accountname, case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) = left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end )

  and left(sf.billingaddressline1,5) = left(s.streetaddress,5)
  --and right(concat('0000',sf.BillingZipPostalCode),5) = right(concat('0000', s.postalcode),5)


  and sf.locationtype = 'Location'

  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as
   --umecemo jos jedan join umesto WHERE condition-a 
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging]) r 
   INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging_spec]) r
  ON r.Restaurant_Id = s.seatedsiteID
  --where s.targetstartdate  = '2024-11-15 00:00:00.000'
  --and s.SalesForceId is null
)

, cte2 as (
select seatedsiteid, count(*) as cnt
from cte 
group by SeatedSiteId
having count(*) = 1
)
select s.SalesForceId, -- 26.11.24 dodato polje 
	c.Accountid, -- 26.11.24 dodato polje
	c.*
--update s set s.SalesForceId = c.Accountid
from cte c
inner join cte2 c2 on c.SeatedSiteId = c2.SeatedSiteId
--inner join [Sandbox].[Seated].[RestaurantLocations_2] s on s.SeatedSiteId = c.SeatedSiteId
inner join [Sandbox].[Seated].[RestaurantLocations_spec] s on s.SeatedSiteId = c.SeatedSiteId
--where s.SalesForceId = c.Accountid COLLATE SQL_Latin1_General_CP1_CI_AS  -- 26.11.24 dodat uslov 
order by 3




 --10th query 
with cte as (
    select s.SeatedSiteId, sf.AccountID, s.Name, sf.AccountName, s.StreetAddress, sf.BillingAddressLine1, s.PostalCode, sf.BillingZipPostalCode,
	ROW_NUMBER () over (partition by s.SeatedSiteId order by s.SeatedSiteId) as rnk
	,sf2.AccountName FirstParent
	,sf3.AccountName SecondParent 
	,sf4.AccountName ThirdParent
  --update s set s.IsExcluded = 1
  --FROM [Sandbox].[Seated].[RestaurantLocations_2] s 
    FROM [Sandbox].[Seated].[RestaurantLocations_spec] s 

  inner join Integrations.salesforce.sfsync sf on 1=1
  
  and left(sf.accountname, case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) like '%' + left(s.name,2) + '%'
  --and left(sf.accountname, case when CHARINDEX(' - ',sf.AccountName) = 0 then len(sf.accountname) else CHARINDEX(' - ',sf.AccountName) end ) = left(s.name,case when CHARINDEX(' - ',s.Name) = 0 then len(s.name) else CHARINDEX(' - ',s.Name) end )

  and left(ltrim(rtrim(sf.billingaddressline1)),3) = left(ltrim(rtrim(s.streetaddress)),3)
  and right(concat('0000',sf.BillingZipPostalCode),3) = right(concat('0000', s.postalcode),3)


  and sf.locationtype = 'Location'

  left join integrations.SalesForce.sfsync sf2 on sf2.AccountID collate latin1_general_cs_as = sf.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join integrations.SalesForce.sfsync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as
   --umecemo jos jedan INNER JOIN umesto WHERE condition-a 
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging_2]) r 
    INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging_spec]) r 

  ON r.Restaurant_Id = s.seatedsiteID
  --where s.targetstartdate  = '2024-11-15 00:00:00.000'
  --and s.SalesForceId is null
  --and s.IsExcluded = 0
  --and s.Name not like 'The%'
  --and sf3.AccountName = 'Seated Locations - On Hold'
  --and s.SeatedSiteId <> 16299
--  and s.SeatedSiteId in (16569,
--16510,
--16513,
--16536,
--15732,
--16559,
--16495)
)

, cte2 as (
select seatedsiteid, count(*) as cnt
from cte 
group by SeatedSiteId
having count(*) = 1
)
select s.SalesForceId, 
		s.IsExcluded, -- 26.11.24 dodato polje 
		c.*
--update s set s.SalesForceId = c.Accountid
from cte c
inner join cte2 c2 on c.SeatedSiteId = c2.SeatedSiteId
--inner join [Sandbox].[Seated].[RestaurantLocations] s on s.SeatedSiteId = c.SeatedSiteId
inner join [Sandbox].[Seated].[RestaurantLocations_spec] s on s.SeatedSiteId = c.SeatedSiteId
order by 3





--11 the query 

select replace(name,'’',''''), *
--update s set s.salesforceid = sf.accountid
--FROM [Sandbox].[Seated].[RestaurantLocations_2] s 
FROM [Sandbox].[Seated].[RestaurantLocations_spec] s 

left join Integrations.SalesForce.SfSync sf on sf.GUID = cast(s.SiteId as nvarchar(25))
  -- umesto where condition
  --INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging]) r 
    INNER JOIN (SELECT DISTINCT Restaurant_id FROM [Sandbox].[Seated].[RestaurantsStaging_spec]) r 

  ON r.Restaurant_Id = s.seatedsiteID
-- 26.11.24 ne radimo vise sa sa WHERE, jer clerks salju sa duplikatima !!!!
--where 
--s.targetstartdate  = '2024-12-01 00:00:00.000'   
-- and
--s.SalesForceId is null
 order by 4
