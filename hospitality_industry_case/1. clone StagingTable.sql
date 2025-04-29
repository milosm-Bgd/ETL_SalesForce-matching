
-- kreiranje kopija tabela

  --ResSpecial.RestStaging_2 
  --ResSpecial.RestStaging_mycopy

use Sandbox;

-- DROP TABLE IF EXISTS ResSpecial.RestStaging_2 

-- CREATE TABLE ResSpecial.RestStaging_2 (

TRUNCATE TABLE ResSpecial.RestStaging_2 

--CREATE TABLE ResSpecial.RestStaging_2
--	([restaurant_id] int,
--     [name] nvarchar(max),
--     [description] nvarchar(max),
--     [full_address] nvarchar(max),
--     [street_address] nvarchar(max),
--     [Billing City] nvarchar(max),
--     [country] nvarchar(max),
--     [state_code] nvarchar(max),
--     [postal_code] int,
--     [latitude] float,
--     [longitude] float,
--     [Default_Image] nvarchar(max), --[Cuisine Image]
--     [Logo URL] nvarchar(max),
--     [monday_oh] nvarchar(max),
--     [tuesday_oh] nvarchar(max),
--     [wednesday_oh] nvarchar(max),
--     [thursday_oh] nvarchar(max),
--     [friday_oh] nvarchar(max),
--     [saturday_oh] nvarchar(max),
--     [sunday_oh] nvarchar(max),
--     [photo1] nvarchar(max),
--     [photo2] nvarchar(max),
--     [photo3] nvarchar(max),
--     [photo4] nvarchar(max),
--     [photo5] nvarchar(max),
--     [menu_url] nvarchar(max),
--     [reservation_provider_name] nvarchar(max),
--     [reservation_provider_url] nvarchar(max),
--     [Website Url] nvarchar(max),
--     [phone_number] bigint,
--     [primary_cuisine] nvarchar(max),
--     [Allows Reservations] bit,
--     [merchant_id] nvarchar(max),
--     [payment_network] nvarchar(max),
--     [VMID] nvarchar(max),
--     [VSID] nvarchar(max),
--     [MC Acquiring MID] nvarchar(max),
--     [MC Location ID] nvarchar(max),
--     [AEXP merchant ID] nvarchar(max))

--	 SELECT * FROM ResSpecial.RestStaging_2 

-- INSERT block 

insert into ResSpecial.RestStaging_2
SELECT [restaurant_id],
     [name],
     [description],
     [full_address],
     [street_address],
     [Billing_City],
     [country],
     [state_code],
     [postal_code],
     [latitude],
     [longitude],
     [Default_Image], --[Cuisine Image]
     [Logo_URL],
     [monday_oh],
     [tuesday_oh],
     [wednesday_oh],
     [thursday_oh],
     [friday_oh],
     [saturday_oh],
     [sunday_oh],
     [photo1],
     [photo2],
     [photo3],
     [photo4],
     [photo5],
     [menu_url],
     [reservation_provider_name],
     [reservation_provider_url],
     [Website_Url],
     [phone_number],
     [primary_cuisine],
     [Allows_Reservations],
     [merchant_id],
     [payment_network],
     [VMID],
     [VSID],
     [MC_Acquiring_MID],
     [MC_Location_ID],
     [AEXP_merchant_ID]

--	 FROM [Sandbox].[ResSpecial].[RestStaging]
	 FROM [ResSpecial].RestStaging_November2024

  --FROM [Sandbox].[dbo].[ResSpecial Additions 20241021]


  select * from [Sandbox].[ResSpecial].[RestStaging_2] 
  select * from [Sandbox].[ResSpecial].[RestStaging]    



  --SELECT distinct restaurant_id FROM [ResSpecial].[RestStaging_2]  
  SELECT distinct restaurant_id FROM [ResSpecial].[RestStaging] 
  SELECT count(1) FROM [ResSpecial].[RestStaging]	
 
