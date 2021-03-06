/****** Object:  Table [dbo].[FP_Info]    Script Date: 5/15/2018 12:07:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FP_Info](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Store] [int] NOT NULL,
	[FirstName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LastName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address1] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address2] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[State] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ZIP] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Phone] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Shipping] [bit] NOT NULL,
 CONSTRAINT [PK_FP_Info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
