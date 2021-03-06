/****** Object:  Table [dbo].[Industry Database]    Script Date: 5/15/2018 12:00:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Industry Database](
	[IndustryTypeID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[IndustryType] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ActiveType] [bit] NULL,
	[SICCode] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[zw_active] [bit] NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Industry Database] PRIMARY KEY CLUSTERED 
(
	[IndustryTypeID] ASC,
	[StoreID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Idx_Alex7]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [Idx_Alex7] ON [dbo].[Industry Database]
(
	[zw_franchise_id] ASC,
	[IndustryTypeID] ASC,
	[IndustryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_FranchiseID]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [IX_FranchiseID] ON [dbo].[Industry Database]
(
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
