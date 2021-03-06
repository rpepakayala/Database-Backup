/****** Object:  Table [dbo].[invoices_emails]    Script Date: 5/15/2018 12:04:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[invoices_emails](
	[invoice_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[added_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[added_on] [datetime2](0) NOT NULL,
	[contact] [nvarchar](120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_invoices_emails_invoice_id] PRIMARY KEY CLUSTERED 
(
	[invoice_id] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[invoices_emails] ADD  DEFAULT (NULL) FOR [contact]
GO
