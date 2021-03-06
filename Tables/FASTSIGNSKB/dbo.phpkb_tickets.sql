/****** Object:  Table [dbo].[phpkb_tickets]    Script Date: 5/15/2018 11:59:19 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_tickets](
	[ticket_id] [int] IDENTITY(1,1) NOT NULL,
	[ticket_status] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[contact_name] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[contact_email] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ticket_subject] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ticket_content] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ticket_priority] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ticket_date] [smalldatetime] NOT NULL,
	[member_id] [int] NOT NULL,
	[ip_address] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [ticket_id] PRIMARY KEY CLUSTERED 
(
	[ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_tickets] ADD  DEFAULT ('open') FOR [ticket_status]
ALTER TABLE [dbo].[phpkb_tickets] ADD  DEFAULT ('Low') FOR [ticket_priority]
ALTER TABLE [dbo].[phpkb_tickets] ADD  DEFAULT ((0)) FOR [member_id]
ALTER TABLE [dbo].[phpkb_tickets]  WITH CHECK ADD CHECK  (([ticket_status]='closed' OR [ticket_status]='open'))
ALTER TABLE [dbo].[phpkb_tickets]  WITH CHECK ADD CHECK  (([ticket_priority]='Urgent' OR [ticket_priority]='High' OR [ticket_priority]='Medium' OR [ticket_priority]='Low'))
GO
