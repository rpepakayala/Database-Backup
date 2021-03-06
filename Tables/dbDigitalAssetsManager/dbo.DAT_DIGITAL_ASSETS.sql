/****** Object:  Table [dbo].[DAT_DIGITAL_ASSETS]    Script Date: 5/15/2018 11:59:12 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DAT_DIGITAL_ASSETS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Keywords] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [int] NULL,
	[Updated] [datetime] NULL,
	[FileNames] [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Approved] [bit] NULL,
	[OldID] [int] NULL,
	[DateAdded] [datetime] NULL,
	[Category] [int] NULL,
	[Department] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Copyright] [bit] NULL,
 CONSTRAINT [PK_DAT_DIGITAL_ASSETS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[DAT_DIGITAL_ASSETS] ADD  CONSTRAINT [DF__DAT_DIGIT__Categ__0B7CAB7B]  DEFAULT (1) FOR [Category]
GO
