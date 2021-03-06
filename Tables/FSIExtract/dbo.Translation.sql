/****** Object:  Table [dbo].[Translation]    Script Date: 5/15/2018 12:01:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Translation](
	[AMERICAN] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ENGLISH] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SPANISH] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[Chinese] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FrenchCanadian] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Portuguese] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Australian] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
