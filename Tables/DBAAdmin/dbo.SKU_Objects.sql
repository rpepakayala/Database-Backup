/****** Object:  Table [dbo].[SKU_Objects]    Script Date: 5/15/2018 11:59:10 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SKU_Objects](
	[___c_ID] [float] NULL,
	[___d_META_SKU] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[___d_META_SKU_Object_ID] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[___d_SKU_ID] [float] NULL,
	[__DG_trigger] [datetime] NULL,
	[access] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[E_value] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[required] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sort] [float] NULL,
	[string] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
