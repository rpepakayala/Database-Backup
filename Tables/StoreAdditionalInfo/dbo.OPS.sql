/****** Object:  Table [dbo].[OPS]    Script Date: 5/15/2018 12:06:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OPS](
	[SDS] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Compliance] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fMM] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tech] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mentor] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[emediaCert] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[exemptLevel] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[exemptDate] [datetime] NULL,
	[aSP] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[aSPLink] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[oPSRegion] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[shipByDate] [datetime] NULL,
	[receiveByDate] [datetime] NULL,
	[storeDecor] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pricingMethod] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[rPMUser] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pOSVersion] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPS_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_OPS_Id] PRIMARY KEY CLUSTERED 
(
	[OPS_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
