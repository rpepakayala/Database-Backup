/****** Object:  Table [dbo].[ExactTargetDataToImport]    Script Date: 5/15/2018 12:00:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ExactTargetDataToImport](
	[zw_franchise_id] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[APIUserName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[APIPassword] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FastMailDate] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListID] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WebNumber] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreNumber] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastSync] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastTransformation] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Channel MemberID] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AccountID] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Validate] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
