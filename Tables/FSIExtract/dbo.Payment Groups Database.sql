/****** Object:  Table [dbo].[Payment Groups Database]    Script Date: 5/15/2018 12:01:04 PM ******/
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
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]

GO
