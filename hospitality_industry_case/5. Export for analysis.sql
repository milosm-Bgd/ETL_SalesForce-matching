
-- doing an export of all into one excel file, in order to make UPDATE in Salesforce and manually checking and flag all those not be onboarded    
--(export u jedan excel, radi update u SalesForce i manuelne provere i flag-ovanja svih onih koji ne treba da se onboarduju)
  

WITH
  accRecursive (SalesForceId, Id,ParentId,AccountId, ParentAccountId, AccLevel)
  AS
  (-- anchor query
    SELECT lc.SalesForceId, ac.Id ,ac.ParentId,ac.AccountId, ac.ParentAccountId, 1 
    FROM integrations.SalesForce.AccountHierarchy ac
	inner join ResSpecial.RestaurantLocations_2 lc on lc.SalesForceId collate SQL_Latin1_General_CP1_CS_AS  = ac.AccountId collate SQL_Latin1_General_CP1_CS_AS
	and lc.TargetStartDate = '2023-12-01 00:00:00.000'
	
    UNION ALL
    --recursive query
 SELECT r.SalesForceId, s.Id, s.ParentId,s.AccountId, s.ParentAccountId, r.AccLevel + 1
    FROM integrations.SalesForce.AccountHierarchy s
	INNER JOIN accRecursive r
     ON s.Id = r.ParentId   -- ON s.ParentId = r.Id 
  )

  , opps as (
  select ROW_NUMBER() over (partition by ac.SalesForceId order by o.CreatedOn desc) AS rnk, ac.SalesForceId, ac.AccountId as InCCC, ac.AccLevel,
  o.*
  from accRecursive ac
  inner join Integrations.SalesForce.Opportunity o on o.AccountId collate SQL_Latin1_General_CP1_CS_AS = ac.accountid collate SQL_Latin1_General_CP1_CS_AS
  )
  , ff as(
  select o.SalesForceId as AccLll, o.AccountId as OpportunityOnAccount, o.AccLevel as OpportunityOnLevel,
  o.Id as OpportunityId, o.OpportunityName, o.Stage, o.CreatedOn as OpportunityCreatedOn 
  from opps o
  where rnk = 1
  )


, cte as (

SELECT rl.[Id]
      ,rl.[ResSpecialSiteId]
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
	  ,rlp.Id as SiteId
	  ,rlp.Start_Date_1 StartDate
	  ,rlp.OOB_Date EndDate
	  ,ss.Status AS ActivePartnerStatus
	  from [Sandbox].[ResSpecial].[RestaurantLocations_2] rl
inner join [Sandbox].[ResSpecial].[RestaurantsStaging_2] s on rl.ResSpecialsiteid = s.restaurant_id
left join Master.dbo._Restaurant_Locations rl on rl.ResSpecialLocationid = rl.ResSpecialsiteid
left join Master.dbo._Restaurant_Status ss on ss.id = rl.Active_Partner
--where 
--rl.TargetStartDate != '2024-11-01'
--and rl.IsExcluded = 0
--and rl.ID is null

  )

  ,final as (  
  select   --c.[Id]   
		     c.[ResSpecialSiteId]
		    ,c.[Name]
		    ,c.[FullAddress]
		    ,c.[StreetAddress]
		    ,c.[BillingCity]
		    ,c.[Country]
		    ,c.[StateCode]
		    ,c.[PostalCode]
		    ,c.[SiteId]
		    ,c.[IsExcluded]
		    ,c.[TargetStartDate]
		  ,sf1.AccountId
		  ,sf1.[Type]
		  ,al.LastActivityDate
		  ,sf1.AccountName
		  ,sf1.BillingAddressLine1
		  ,sf1.BillingZipPostalCode
		  ,sf1.BillingCity as SfBillingCity
		  ,sf1.BillingStateProvince
		  ,sf2.AccountID ParentId
		  ,sf2.AccountName ParentAccountName
		  ,sf3.AccountID SecondParentId
		  ,sf3.AccountName SecondParentAccountName
		  ,sf4.AccountID ThirdParentId
		  ,sf4.AccountName ThirdParentAccountName
		  ,f.*  -- 7 polja within 
		 , c.SiteId
		  ,c.StartDate
	  ,c.EndDate
	  ,c.ActivePartnerStatus
  from cte c 
  left join ff f on f.AccLll collate latin1_general_cs_as = c.SalesForceId collate latin1_general_cs_as
  left join Integrations.SalesForce.SfSync sf1 on sf1.AccountID collate latin1_general_cs_as = c.SalesForceId collate latin1_general_cs_as
  left join Integrations.SalesForce.SfSync sf2 on sf2.AccountID collate latin1_general_cs_as = sf1.ParentAccountID collate latin1_general_cs_as
  left join Integrations.SalesForce.SfSync sf3 on sf3.AccountID collate latin1_general_cs_as = sf2.ParentAccountID collate latin1_general_cs_as
  left join Integrations.SalesForce.SfSync sf4 on sf4.AccountID collate latin1_general_cs_as = sf3.ParentAccountID collate latin1_general_cs_as
  left join Integrations.SalesForce.AccountsLastActivityDate al on al.Id collate latin1_general_cs_as = sf1.AccountID collate latin1_general_cs_as
)
select f.*, nullif(count( distinct case when sf.LocationType = 'Location' then sf.AccountID collate latin1_general_cs_as else null end),0) as LocationsUnderHierarchy
from final f
left join Integrations.SalesForce.SfSync sf on sf.ParentAccountId  collate latin1_general_cs_as = f.ParentId

group by

f.[ResSpecialSiteId]
,f.[Name]
,f.[FullAddress]
,f.[StreetAddress]
,f.[BillingCity]
,f.[Country]
,f.[StateCode]
,f.[PostalCode]
,f.[SiteId]
,f.[IsExcluded]
,f.[TargetStartDate]
,f.AccountId
,f.AccountName
,f.BillingAddressLine1
,f.BillingZipPostalCode
,f.SfBillingCity
,f.BillingStateProvince
,f.AccountID 
,f.AccountName 
,f.AccountID 
,f.AccountName 
,f.AccountID 
,f.AccountName
,f.ParentId
,f.ParentAccountName
,f.SecondParentId
,f.SecondParentAccountName
,f.ThirdParentId
,f.ThirdParentAccountName
,f.AccLll
,f.OpportunityOnAccount
,f.OpportunityId
,f.OpportunityName
,f.Stage
,f.OpportunityCreatedOn
,f.OpportunityOnLevel
,f.[Type]
,f.LastActivityDate
,f.SiteId
,f.StartDate
	  ,f.EndDate
	  ,f.ActivePartnerStatus
order by f.AccountID
