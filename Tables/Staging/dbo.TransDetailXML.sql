/****** Object:  Table [dbo].[TransDetailXML]    Script Date: 5/15/2018 12:06:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransDetailXML](
	[ID] [int] NULL,
	[TransHeaderID] [int] NULL,
	[ParentID] [int] NULL,
	[Description] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InternalNotes] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParameterStr] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifierStr] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PartStr] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
