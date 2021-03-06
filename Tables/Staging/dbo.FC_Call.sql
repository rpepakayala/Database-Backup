/****** Object:  Table [dbo].[FC_Call]    Script Date: 5/15/2018 12:06:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_Call](
	[subject] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[timeAdded] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[callStatus] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[callType] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[comments] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_name294690254] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchiseeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
