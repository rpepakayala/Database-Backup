/****** Object:  Table [dbo].[FC_Agreement]    Script Date: 5/15/2018 12:06:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_Agreement](
	[StoreNumber] [bigint] NULL,
	[referenceId] [bigint] NULL,
	[fimDdApprovedDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdDateExecuted] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdExpirationDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdClosingDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtOtherAddendum] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtProtectedTerritory] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtSalesperson] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtPreviousLicenseNumber] [tinyint] NULL,
	[fimDdStoreSoldDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdRequiredOpeningDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTaComments] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimLicenseAgreement0] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_fddState922329430] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_fddDate949849278] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_rightOfFirstRefusalDetails1548376824] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_rightOfFirstRefusalNoticePeriod1727863359] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_rightOfFirstRefusalFee248665797] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_rightOfFirstRefusalArea9343070] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_effectiveDate304225873] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_keyRequirements115864372] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_salesperson571955920] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_comments1383229648] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_developmentArea11914615654] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_developmentArea2360170703] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_developmentArea3708982721] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_versionOfFdd2134955744] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_coopDate257385578] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_napAgreement578839550] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_napDirectAgreement1972630697] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCenterInfo_Id] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
