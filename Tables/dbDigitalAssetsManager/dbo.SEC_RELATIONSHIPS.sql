/****** Object:  Table [dbo].[SEC_RELATIONSHIPS]    Script Date: 5/15/2018 11:59:13 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SEC_RELATIONSHIPS](
	[RelationshipID] [int] NOT NULL,
	[ParentID] [int] NOT NULL,
	[ParentType] [int] NOT NULL,
	[ChildID] [int] NOT NULL,
	[ChildType] [int] NOT NULL,
	[AccessCode] [int] NOT NULL,
	[DateCreated] [datetime] NULL,
	[DateLastModified] [datetime] NULL
) ON [PRIMARY]

GO
