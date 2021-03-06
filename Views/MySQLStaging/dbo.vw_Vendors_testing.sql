/****** Object:  View [dbo].[vw_Vendors_testing]    Script Date: 5/15/2018 12:14:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE VIEW [dbo].[vw_Vendors_testing]
AS
SELECT
	parent_id ,franchise_id,
    [Vendor Code] ,
    [Company Name] ,
    [Address] ,
    [Email] ,
    [URL] ,
    [Phone],
		franchise_name
FROM
    ( SELECT
        parent_id ,
        value ,
        field ,
		franchise_id,
		franchise_name
      FROM
        ( SELECT
            entity_info.value ,
            field_types.field ,
            entities.last_modified ,
            entity_types.name ,
            franchises.franchise_id ,
            entities.parent_id,
			franchises.franchise_name
          FROM
            entities
            INNER JOIN entity_info ON entities.entity_id = entity_info.entity_id
            INNER JOIN field_types ON entity_info.field_type_id = field_types.field_type_id
            INNER JOIN entity_types ON entities.entity_type_id = entity_types.entity_type_id
            JOIN franchises ON entities.franchise_id = franchises.franchise_id
        ) PairTable   
  WHERE PairTable.name = 'Vendor'
      
    ) p PIVOT
( MAX(value) FOR field IN ( [Vendor Code], [Company Name], [Address], [Email],
                            [URL], [Phone] ) ) AS pvt



GO
