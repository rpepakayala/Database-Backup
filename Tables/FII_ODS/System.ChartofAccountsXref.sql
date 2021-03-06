/****** Object:  Table [System].[ChartofAccountsXref]    Script Date: 5/15/2018 11:59:46 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[ChartofAccountsXref](
	[Account Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GL Account] [int] NULL,
	[Validated Account] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NULL,
	[OLTP_InsertDate] [date] NULL,
 CONSTRAINT [PK_ChartofAccountsXref] PRIMARY KEY CLUSTERED 
(
	[Account Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [System].[ChartofAccountsXref] ADD  CONSTRAINT [DF_ChartofAccountsXref_OLTP_InsertDate]  DEFAULT (getdate()) FOR [OLTP_InsertDate]
ALTER TABLE [System].[ChartofAccountsXref]  WITH CHECK ADD  CONSTRAINT [FK_ChartofAccountsXref_ChartofAccounts] FOREIGN KEY([GL Account])
REFERENCES [System].[ChartofAccounts] ([GL_Account])
ALTER TABLE [System].[ChartofAccountsXref] CHECK CONSTRAINT [FK_ChartofAccountsXref_ChartofAccounts]
GO
