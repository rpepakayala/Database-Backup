/****** Object:  Table [dbo].[Product Category Database]    Script Date: 5/15/2018 12:01:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Product Category Database](
	[ProductCategoryID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ProductCategory] [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ActiveCategory] [bit] NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]

GO
