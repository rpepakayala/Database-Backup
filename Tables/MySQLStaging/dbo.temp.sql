/****** Object:  Table [dbo].[temp]    Script Date: 5/15/2018 12:04:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[temp](
	[franchise_royalty_id] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[period_name] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[nac_royalty_rate] [decimal](6, 2) NULL,
	[franchise_royalty_rate] [decimal](6, 2) NULL,
	[sales_total] [money] NULL,
	[royalty_sales_total] [money] NULL,
	[royalty_subtotal] [decimal](27, 6) NULL,
	[adjustment_amount] [int] NOT NULL,
	[royalty_total] [decimal](27, 6) NULL,
	[period_start_date] [date] NULL,
	[created_on] [datetime] NULL,
	[nac_adjustment_amount] [int] NOT NULL,
	[wip_total] [float] NULL,
	[rejected_total] [float] NULL,
	[ar_total] [float] NULL
) ON [PRIMARY]

GO
