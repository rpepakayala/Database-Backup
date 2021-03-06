/****** Object:  StoredProcedure [dbo].[Integration_Contact_CustomFields_iu]    Script Date: 5/15/2018 12:09:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[Integration_Contact_CustomFields_iu]
(
@zw_franchise_id varchar(10),
@contactid int,
@first_name varchar(20),
@last_name varchar(20),
@email varchar(50),
@zip_code varchar(25),
@company varchar(100),
@customer_industry varchar(100),
@last_order_date datetime,
@first_order_date datetime,
@average_total money,
@last_order_amount money,
@customer_origin varchar(100),
@last_product_ordered varchar(100),
@salesperson varchar(100),
@pickedup_date datetime,
@last_modified datetime,
@optout bit = 0
)
AS
SET NOCOUNT ON

	UPDATE _ExactTarget_Integration_Contacts
	SET
		first_name = @first_name,
		last_name = @last_name,
		email = @email,
		zip_code = @zip_code,
		company = @company, 
		customer_industry = @customer_industry, 
		last_order_date = @last_order_date, 
		first_order_date = @first_order_date, 
		average_total = @average_total, 
		last_order_amount = @last_order_amount, 
		customer_origin = @customer_origin, 
		last_product_ordered = @last_product_ordered, 
		salesperson = @salesperson, 
		pickedup_date = @pickedup_date,
		last_modified = @last_modified,
		OptOut = @optout
	WHERE 
		[contactid] = @contactid
	AND 
		[zw_franchise_id] = @zw_franchise_id

IF( @@ROWCOUNT = 0 )
		BEGIN

			INSERT INTO _ExactTarget_Integration_Contacts( zw_franchise_id, contactid, first_name, last_name, email, zip_code, company, customer_industry, last_order_date, first_order_date, average_total, last_order_amount, customer_origin, last_product_ordered, salesperson, pickedup_date, last_modified, OptOut )
			VALUES( @zw_franchise_id, @contactid, @first_name, @last_name, @email, @zip_code, @company, @customer_industry, @last_order_date, @first_order_date, @average_total, @last_order_amount, @customer_origin, @last_product_ordered, @salesperson, @pickedup_date, @last_modified, @optout )

		END

GO
