/****** Object:  Table [dbo].[Payment Groups Database_deletes]    Script Date: 5/15/2018 12:00:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Payment Groups Database_deletes](
	[PaymentMethodType] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[GroupName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultAccountCode] [int] NULL,
	[Text] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NULL,
	[sys_du] [datetime] NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] NOT NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]

GO
