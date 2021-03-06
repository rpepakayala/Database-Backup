/****** Object:  StoredProcedure [dbo].[sp_MatchSalesToMailingAddressesByDate]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE [dbo].[sp_MatchSalesToMailingAddressesByDate]
	-- input date format: mm/dd/yyyy	
	@mDate varchar(50), -- Mailing date
	@sStartDate varchar(50), -- Sales Start Date
	@sEndDate varchar(50)= null -- Sales End Date can be empty
AS

BEGIN
	SET NOCOUNT ON;

	declare @mailingDate datetime, @salesStart datetime, @salesEnd datetime

	set @mailingDate = convert(datetime, @mDate, 101)
	set @salesStart = convert(datetime, @sStartDate, 101)

	if  @sEndDate is not null or @sEndDate <> ''
	set @salesEnd = convert(datetime, @sEndDate, 101)


	declare @StoreCountry table (webnum int, countrycode nvarchar(10))
	insert into @StoreCountry (webnum, countrycode)
	SELECT a.[WebNumber], e.countryisocode
	FROM [01DALSVMSQL001].[Alpine].[dbo].[COR_STORES] a
	left join [01DALSVMSQL001].[Alpine].[dbo].[COR_STORES_addresses_link] b on a.storeid = b.storeid
	left join [01DALSVMSQL001].[Alpine].[dbo].[COR_addresses] c on b.addressid = c.addressid
	left join [01DALSVMSQL001].[Alpine].[dbo].[COR_POLITICAL_DIVISION] d on c.PoliticalDivisionID = d.PoliticalDivisionID
	left join [01DALSVMSQL001].[Alpine].[dbo].[COR_COUNTRIES] e on d.countryid = e.countryid
	where a.webnumber > 0

declare @MonthMailing table (webid int, address nvarchar(550), zip nvarchar(25), city nvarchar(50))

insert into @MonthMailing  (webid , address, zip, city)
select  cast(COALESCE(u.webid,'0') as int) as webid, 
		CASE WHEN u.address1 is null or u.address1 ='' THEN u.address2 + ' ' + u.address1 ELSE u.address1 + ' ' + u.address2 END AS address, 
 u.zip, u.city from dmmailings u
				where DATEADD(day, DATEDIFF(day, 0, u.mailingDate), 0) = @mailingDate
and webid > 0

	declare @StoreDetail table (webno int, CompanyName nvarchar(150),firstname nvarchar(50), lastname nvarchar(50), address1 nvarchar(250), address2 nvarchar(250), city nvarchar(50), state nvarchar(25), 
zipcode nvarchar(25), orderdate datetime, sale money)

		insert into @StoreDetail  (webno , companyname, firstname , lastname , 
address1 , address2 , city , state , 
zipcode , orderdate , sale )
		select * from 
		(
			select CASE WHEN webno is null THEN 0 ELSE webno  END AS webno, 
		CASE WHEN CompanyName is null THEN '' ELSE CompanyName  END AS CompanyName, 
		CASE WHEN firstname is null and webno is not null and companyname is null THEN 'Center Total' 
WHEN firstname is null and webno is not null and companyname is not null THEN 'Company Total'
		WHEN webno is null THEN 'Grand Total'
		ELSE firstname  END AS firstname,  
		CASE WHEN firstname is null and webno is not null and webno <> 0  THEN cast(count(*) as varchar(50)) + ' Order(s)' 
		WHEN lastname is null THEN '' 
		ELSE lastname  END AS lastname,
		CASE WHEN address1 is null THEN '' ELSE address1  END AS address1, 
		CASE WHEN address2 is null THEN '' ELSE address2  END AS address2, 
		CASE WHEN dm.city is null THEN '' ELSE dm.city  END AS dcity, 
		CASE WHEN dm.state is null THEN '' ELSE dm.state  END AS state, 
		CASE WHEN zipcode is null THEN '' ELSE zipcode  END AS zipcode, 
		CASE WHEN orderdate is null THEN '' ELSE orderdate  END AS orderdate, 
		SUM(salesamt)  as Sales from dmcustomers dm
			where   dm.orderDate >= @salesStart and ((@salesEnd is null) OR (DATEADD(day, DATEDIFF(day, 0, dm.orderDate), 0) <= @salesEnd)) 
			and exists 
			(
				select webid from @MonthMailing u
				where u.webid = dm.webno and 
					(((dm.address1 like '%[0-9]%[a-z]%' or dm.address1 like '%[a-z]%[0-9]%')and u.address like '%'+dm.address1+'%') 
					or ((dm.address2 like '%[0-9]%[a-z]%' or dm.address2 like '%[a-z]%[0-9]%')and u.address like '%'+dm.address2+'%')) 
					and					
					(left(u.zip, 5) = left(dm.zipcode,5) or dm.city=u.city)  
			)

			group by webno, CompanyName,firstname, lastname,address1,  address2, dm.city, state, zipcode, orderdate 
			with rollup
		) T
		where (firstname ='Center Total' and lastname ='' and address1 ='' and address2 ='' and dcity ='' and state ='' and zipcode ='' and orderdate ='') or (firstname !='' and lastname !='' and orderdate !='') or (firstname !='' and lastname !='' and address1 ='' and address2 ='' and dcity ='' and state ='' and zipcode ='' and orderdate ='') and (webno <> 0 )


select a.*, c.countrycode from @StoreDetail a
left join @StoreCountry c on a.webno = c.webnum


END


GO
