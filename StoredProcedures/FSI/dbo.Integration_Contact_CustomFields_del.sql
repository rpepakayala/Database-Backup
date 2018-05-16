/****** Object:  StoredProcedure [dbo].[Integration_Contact_CustomFields_del]    Script Date: 5/15/2018 12:09:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[Integration_Contact_CustomFields_del]
(
@zw_franchise_id varchar(10),
@contactid int
)
AS
SET NOCOUNT ON

UPDATE _ExactTarget_Integration_Contacts
SET
		first_name = NULL,
		last_name = NULL,
		email = NULL,
		zip_code = NULL,
		company = NULL, 
		customer_industry = NULL, 
		last_order_date = NULL, 
		first_order_date = NULL, 
		average_total = NULL, 
		last_order_amount = NULL, 
		customer_origin = NULL, 
		last_product_ordered = NULL, 
		salesperson = NULL, 
		pickedup_date = NULL,
		subscriber_id = NULL,
		Lastsync = NULL
WHERE 
	contactid = @contactid
AND 
	zw_franchise_id = @zw_franchise_id


GO
