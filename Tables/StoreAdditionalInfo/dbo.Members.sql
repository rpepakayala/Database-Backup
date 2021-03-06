/****** Object:  Table [dbo].[Members]    Script Date: 5/15/2018 12:06:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Members](
	[StoreAdditionalInfo_Id] [bigint] NOT NULL,
	[group] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[members] [int] NULL,
	[user] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[reference] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sort] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Members_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Members_Id] PRIMARY KEY CLUSTERED 
(
	[Members_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Members]  WITH CHECK ADD  CONSTRAINT [FK_Members_StoreAdditionalInfo] FOREIGN KEY([StoreAdditionalInfo_Id])
REFERENCES [dbo].[StoreAdditionalInfo] ([StoreAdditionalInfo_Id])
ALTER TABLE [dbo].[Members] CHECK CONSTRAINT [FK_Members_StoreAdditionalInfo]
GO
