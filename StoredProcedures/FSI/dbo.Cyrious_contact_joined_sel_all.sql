/****** Object:  StoredProcedure [dbo].[Cyrious_contact_joined_sel_all]    Script Date: 5/15/2018 12:09:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[Cyrious_contact_joined_sel_all]
( 
@modified_since datetime, 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON

	SELECT
		Cont.[ContactID], 
		Cont.[FirstName] as 'contact_firstname', 
		Cont.[LastName] as 'contact_lastname', 
		Cont.[Title],
		Cont.[PareaCode],
		Cont.[PhoneNumber],
		Cont.[PhoneExtention],
		Cont.[FareaCode], 
		Cont.[FaxNumber], 
		Cont.[EmailAddress], 
		Cont.[IsActive], 
		Cont.[zw_franchise_id],
		cont.sys_du as 'contact_sys_du',
		
		CUST.[customerid],
		CUST.[CompanyName],
		CUST.[BillingAddress1],
		CUST.[BillingAddress2],
		CUST.[City],
		CUST.[state],
		Cust.[Zip],
		Cust.[Country],
		cust.sys_du as 'customer_sys_du',

		emp.[EmployeeID],
		emp.[FirstName] as 'employee_firstname',
		emp.[LastName] as 'employee_lastname',
		emp.sys_du as 'employee_sys_du',

		ind.[IndustryTypeID],
		ind.[IndustryType],
		ind.sys_du as 'industry_sys_du',

		ct.[customertypeid],
		CT.[CustomerType],
		ct.sys_du as 'customertype_sys_du',
		CASE
		WHEN (store.MktgFlag5Name like 'Exclude%' AND cust.lastcontact1 is not null) THEN CAST(1 AS bit)
		ELSE CAST(0 AS bit)
		END as OptOut
	
	FROM [Contact Database] Cont
		JOIN [customer database] cust 
			ON ( cust.zw_franchise_id = cont.zw_franchise_id 
				AND cont.customerid = cust.customerid )
		LEFT OUTER JOIN [Customer Type Database] CT 
			ON ( cust.CustomerTypeID = CT.CustomerTypeID
				AND cust.zw_franchise_id = CT.zw_franchise_id )
		LEFT OUTER JOIN [Employee Database] emp 
			ON ( cust.SalesPersonID = emp.EmployeeID 
				AND cust.zw_franchise_id = emp.zw_franchise_id )
		LEFT OUTER JOIN [industry database] ind
			ON ( cust.industrytypeid = ind.IndustryTypeID 
				AND cust.zw_franchise_id = ind.zw_franchise_id )
		LEFT OUTER JOIN (select top 1 * from [Store Information Database] where zw_franchise_id = @zw_franchise_id and MktgFlag5Name like 'Exclude%') store
			ON ( cont.zw_franchise_id = store.zw_franchise_id )

	WHERE Cont.[ContactID]>0 
	AND Cont.isactive=1 
	AND Cont.[CustomerID]>1
	AND CHARINDEX('@',Cont.EmailAddress) > 0

	AND cont.zw_franchise_id = @zw_franchise_id

	AND ( 
		cont.sys_du > @modified_since
		OR cust.sys_du > @modified_since
		OR emp.sys_du > @modified_since
		OR ind.sys_du > @modified_since
		OR ct.sys_du > @modified_since
	)

GO
