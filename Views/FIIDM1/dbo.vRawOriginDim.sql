/****** Object:  View [dbo].[vRawOriginDim]    Script Date: 5/15/2018 12:13:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[vRawOriginDim]
AS
SELECT	O.T_CustomerTypeRaw AS RawOriginName
	,	O.T_CustomerType	AS Orign

	FROM (SELECT DISTINCT T_CustomerTypeRaw, T_CustomerType FROM dbo.CustomerDim) AS O

GO
