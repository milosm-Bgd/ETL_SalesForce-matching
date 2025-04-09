--[Seated])).[RestaurantMerchantNumbers]))
--[FileUpload])).[SeatedAdditions]))


use Sandbox;

truncate table Seated.RestaurantsStaging


insert into Seated.RestaurantsStaging


SELECT ltrim(rtrim([restaurant_id]))
      ,ltrim(rtrim([name]))
      ,trim('"' from ltrim(rtrim([description])))
      ,ltrim(rtrim([full_address]))
      ,ltrim(rtrim([street_address]))
      ,ltrim(rtrim([Billing_City]))
      ,ltrim(rtrim([country]))
      ,ltrim(rtrim([state_code]))
      ,ltrim(rtrim([postal_code]))
      ,ltrim(rtrim([latitude]))
      ,ltrim(rtrim([longitude]))
      ,ltrim(rtrim([Default_Image])) --[Cuisine Image]
      ,ltrim(rtrim([Logo_URL]))
      ,ltrim(rtrim([monday_oh]))
      ,ltrim(rtrim([tuesday_oh]))
      ,ltrim(rtrim([wednesday_oh]))
      ,ltrim(rtrim([thursday_oh]))
      ,ltrim(rtrim([friday_oh]))
      ,ltrim(rtrim([saturday_oh]))
      ,ltrim(rtrim([sunday_oh]))
      ,ltrim(rtrim([photo1]))
      ,ltrim(rtrim([photo2]))
      ,ltrim(rtrim([photo3]))
      ,ltrim(rtrim([photo4]))
      ,ltrim(rtrim([photo5]))
      ,ltrim(rtrim([menu_url]))
      ,ltrim(rtrim([reservation_provider_name]))
      ,ltrim(rtrim([reservation_provider_url]))
      ,ltrim(rtrim([Website_Url]))
      ,ltrim(rtrim([phone_number]))
      ,ltrim(rtrim([primary_cuisine]))
      ,ltrim(rtrim([Allows_Reservations]))
      ,ltrim(rtrim([merchant_id]))
      ,ltrim(rtrim([payment_network]))
      ,ltrim(rtrim([VMID]))
      ,ltrim(rtrim([VSID]))
      ,ltrim(rtrim([MC_Acquiring_MID]))
      ,ltrim(rtrim([MC_Location_ID]))
      ,ltrim(rtrim([AEXP_merchant_ID]))
FROM [Sandbox].[dbo].[Seated_Additions_20241119_csv]
--FROM [Sandbox].[dbo].[Seated Additions 20241021]
  

 --select * from  Seated.RestaurantsStaging      
   select * from  Seated.RestaurantsStaging  
