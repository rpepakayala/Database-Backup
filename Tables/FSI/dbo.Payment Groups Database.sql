/****** Object:  Table [dbo].[Payment Groups Database]    Script Date: 5/15/2018 12:00:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Payment Groups Database](
	[PaymentMethodType] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[GroupName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultAccountCode] [int] NULL,
	[Text] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[zw_active] [bit] NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Payment Groups Database] PRIMARY KEY CLUSTERED 
(
	[PaymentMethodType] ASC,
	[StoreID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_FranchiseID]    Script Date: 5/15/2018 12:00:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_FranchiseID] ON [dbo].[Payment Groups Database]
(
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
