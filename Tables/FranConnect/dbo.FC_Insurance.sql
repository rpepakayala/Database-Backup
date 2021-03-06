/****** Object:  Table [dbo].[FC_Insurance]    Script Date: 5/15/2018 12:00:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_Insurance](
	[referenceId] [bigint] NULL,
	[fimTtPolicyTitle] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdInsuranceEffDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtInsuranceCompanyName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtPolicyNo] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdInsuranceExpDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrWcPresent] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtGlCoveragePresent] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtGlEachOccurrence] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtPropertyDeductible] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTaOther2Comments] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTaComments] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCbtContactTitle] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtContactFirstName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtContactLastName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimInsurance0] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimInsurance1] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_agency1147816886] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_nonownedAuto1152762955] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_nonownedAutoCoverageRequired79234099] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_wCPolicyNumber1635511779] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_wCExpirationDate299408743] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_wCEffectiveDate848718312] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_nonownedAutoExpirationDate321473356] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_nonownedAutoEffectiveDate517233932] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_nonOwnedAutoPolicyNumber1168160286] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCenterInfo_Id] [numeric](20, 0) NULL,
	[franchiseeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
