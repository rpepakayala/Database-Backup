/****** Object:  Table [dbo].[Job_Item_Objects]    Script Date: 5/15/2018 11:59:09 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Job_Item_Objects](
	[___audit] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[___c_ID] [float] NULL,
	[___d_doc_join] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[___d_job] [float] NULL,
	[___d_Job_Item_ID] [float] NULL,
	[___d_SKU_ID] [float] NULL,
	[___d_SKU_Object_ID] [float] NULL,
	[__DG_trigger] [datetime] NULL,
	[_dupe_check] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_object] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[emphasis] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[spec] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[string] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
