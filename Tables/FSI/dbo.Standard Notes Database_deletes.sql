/****** Object:  Table [dbo].[Standard Notes Database_deletes]    Script Date: 5/15/2018 12:00:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Standard Notes Database_deletes](
	[NotesID] [int] NOT NULL,
	[StoreID] [int] NULL,
	[OrderNotes] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InstallNotes] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
