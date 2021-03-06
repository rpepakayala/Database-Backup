/****** Object:  Table [dbo].[SKU_Category]    Script Date: 5/15/2018 11:59:10 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SKU_Category](
	[___c_ID] [float] NULL,
	[__constant] [float] NULL,
	[account_id] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[certitax_ID] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FII_Royalty_default] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[labor] [float] NULL,
	[NAC_Royalty_default] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PO_Approval] [float] NULL,
	[PO_Limit] [float] NULL,
	[PO_Range_Pct] [float] NULL,
	[PO_Type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[report_level] [float] NULL
) ON [PRIMARY]

GO
