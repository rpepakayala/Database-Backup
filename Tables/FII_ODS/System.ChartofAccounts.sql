/****** Object:  Table [System].[ChartofAccounts]    Script Date: 5/15/2018 11:59:46 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[ChartofAccounts](
	[GL_Account] [int] NOT NULL,
	[AccountName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListOrder] [tinyint] NULL,
 CONSTRAINT [PK_ChartofAccounts] PRIMARY KEY CLUSTERED 
(
	[GL_Account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
