/****** Object:  Table [dbo].[Account Code Database_deletes]    Script Date: 5/15/2018 12:00:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Account Code Database_deletes](
	[ID] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Type] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Number] [int] NULL,
	[Text] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NULL,
	[sys_du] [datetime] NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] NOT NULL,
	[BreakOutSub] [bit] NULL,
	[BaseText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifierText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DiscountText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InstallText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OmitFromExport] [bit] NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]

GO
