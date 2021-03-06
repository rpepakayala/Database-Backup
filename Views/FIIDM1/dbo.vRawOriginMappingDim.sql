/****** Object:  View [dbo].[vRawOriginMappingDim]    Script Date: 5/15/2018 12:13:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[vRawOriginMappingDim]
AS
SELECT	SourceCustomerType	AS Origin
	,	[1stPass_OriginKey]
	,	[2ndPass_OriginKey]
	,	[3rdPass_OriginKey]
	,	Final_OriginKey	AS OriginKey
	,	I1.OriginName AS OriginMatch1
	,	I2.OriginName AS OriginMatch2
	,	I3.OriginName AS OriginMatch3
	,	I.OriginName	AS OriginMatch

	FROM Fuzzy.OriginMapping	IM
		LEFT JOIN CustomerOriginDim I1 ON I1.OriginKey = [1stPass_OriginKey]
		LEFT JOIN CustomerOrigindim I2 ON I2.OriginKey = [2ndPass_OriginKey]
		LEFT JOIN CustomerOriginDim I3 ON I3.OriginKey = [3rdPass_OriginKey]
		LEFT JOIN CustomerOriginDim I ON I.OriginKey = Final_OriginKey

GO
