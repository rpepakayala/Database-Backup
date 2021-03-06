/****** Object:  View [dbo].[vw_Accounts]    Script Date: 5/15/2018 12:14:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



CREATE VIEW [dbo].[vw_Accounts]
AS
    SELECT
        accounts.franchise_id AS FranchiseID ,
        accounts.display_id AS DisplayAccountID ,
        accounts.company_name AS CompanyName ,
        address_types.name AS AddressType ,
        accounts_address.primary_address AS PrimaryAddressFlag ,
        accounts_address.address_1 AS Address1 ,
        accounts_address.address_2 AS Address2 ,
        accounts_address.city AS City ,
        states.name AS State ,
		accounts_address.zipcode AS Zip,
        countries.code AS CountryCode ,
        countries.name AS CountryName ,
        phone_types.name AS PhoneType ,
        accounts_phone.primary_phone ,
        accounts_phone.telephone ,
        accounts_phone.ext ,
        accounts.tax_id_number ,
        accounts.tax_id_expiry_date ,
        accounts.tax_exempt ,
        accounts.accounts_id
    FROM
        accounts
        LEFT JOIN accounts_address ON accounts_address.accounts_id = accounts.accounts_id
        LEFT JOIN accounts_phone ON accounts_phone.accounts_id = accounts_address.accounts_id
        LEFT JOIN phone_types ON phone_types.phone_type_id = accounts_phone.phone_type_id
        LEFT JOIN address_types ON accounts_address.address_type_id = address_types.address_type_id
        /*INNER JOIN states ON accounts_address.state_id = states.state_id
        INNER JOIN countries ON states.country_id = countries.country_id
		efw - temp fix for reporting.  review for performance or other options later 20140919
		*/
		LEFT JOIN states ON accounts_address.state_id = states.state_id
        LEFT JOIN countries ON states.country_id = countries.country_id



GO
