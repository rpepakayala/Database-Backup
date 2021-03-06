/****** Object:  Table [System].[ReportSubscriptionUsers]    Script Date: 5/15/2018 11:59:48 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[ReportSubscriptionUsers](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SalesRegion] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Franchise_Id] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LongStoreNumber] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[ReportFormat] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailTo] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailFrom] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailCopy] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
