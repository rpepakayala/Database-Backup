/****** Object:  Table [dbo].[AddressConsolidated]    Script Date: 5/15/2018 11:59:01 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AddressConsolidated](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyLocationId] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FranchiseName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AddressId] [int] NULL,
	[Address1] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address2] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address3] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[State] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[County] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PostalCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PostalCodeExtended] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsUpdate] [int] NULL,
	[OLTP_InsertDate] [datetime] NULL,
	[OLTP_UpdateDate] [datetime] NULL,
	[UpdateCheckSum] [int] NULL,
 CONSTRAINT [PK_AddressConsolidated] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[AddressConsolidated] ADD  CONSTRAINT [DF_AddressConsolidated_OLTP_InsertDate]  DEFAULT (getdate()) FOR [OLTP_InsertDate]
GO
