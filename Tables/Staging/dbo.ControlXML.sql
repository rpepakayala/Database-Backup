/****** Object:  Table [dbo].[ControlXML]    Script Date: 5/15/2018 12:06:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ControlXML](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransHeaderID] [int] NULL,
	[GoodsItemID] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FormattedText] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifierCode] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnitID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParentID] [int] NULL
) ON [PRIMARY]

GO
