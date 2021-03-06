/****** Object:  Table [dbo].[FP_Shipping]    Script Date: 5/15/2018 12:07:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FP_Shipping](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[InfoID] [int] NOT NULL,
	[Address1] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address2] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[State] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ZIP] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Shipped] [bit] NOT NULL,
	[Invoiced] [bit] NOT NULL,
 CONSTRAINT [PK_FP_Shipping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[FP_Shipping]  WITH CHECK ADD  CONSTRAINT [FK_FP_Shipping_FP_Info] FOREIGN KEY([InfoID])
REFERENCES [dbo].[FP_Info] ([ID])
ON DELETE CASCADE
ALTER TABLE [dbo].[FP_Shipping] CHECK CONSTRAINT [FK_FP_Shipping_FP_Info]
GO
