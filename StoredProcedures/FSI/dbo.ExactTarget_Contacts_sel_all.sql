/****** Object:  StoredProcedure [dbo].[ExactTarget_Contacts_sel_all]    Script Date: 5/15/2018 12:09:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[ExactTarget_Contacts_sel_all]
(
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
BEGIN

		SELECT ic.contactid, ic.zw_franchise_id, ic.first_name, ic.last_name, ic.email,
				ic.zip_code, ic.company, ic.customer_industry, ic.last_order_date, ic.first_order_date,
				ic.average_total, ic.last_order_amount, ic.customer_origin, ic.last_product_ordered,
				ic.salesperson, ic.pickedup_date, ic.subscriber_id, ic.lastsync, COALESCE( ic.last_modified, cust.sys_du, cont.sys_du ) as last_modified, ic.OptOut
		FROM _ExactTarget_Integration_Contacts ic
			JOIN [contact database] cont
				ON ( ic.contactid = cont.contactid and ic.zw_franchise_id = cont.zw_franchise_id )
			JOIN [customer database] cust
				ON ( cont.customerid = cust.customerid and cont.zw_franchise_id = cust.zw_franchise_id )
		WHERE ic.zw_franchise_id = @zw_franchise_id
		and cont.zw_franchise_id = @zw_franchise_id
		and cust.zw_franchise_id = @zw_franchise_id
		AND ic.email is not null 
		AND ic.email <> ''
		AND charindex('@',ic.email) > 0 

END

GO
