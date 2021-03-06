/****** Object:  Table [argot].[report_type]    Script Date: 5/15/2018 11:59:08 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [argot].[report_type](
	[report_type_id] [int] IDENTITY(1,1) NOT NULL,
	[report_type_name] [varchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_report_type] PRIMARY KEY CLUSTERED 
(
	[report_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
