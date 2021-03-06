/****** Object:  Table [dbo].[NAP]    Script Date: 5/15/2018 12:06:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[NAP](
	[StoreAdditionalInfo_Id] [bigint] NOT NULL,
	[date] [datetime] NULL,
	[notes] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NAP_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_NAP_Id] PRIMARY KEY CLUSTERED 
(
	[NAP_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[NAP]  WITH CHECK ADD  CONSTRAINT [FK_NAP_StoreAdditionalInfo] FOREIGN KEY([StoreAdditionalInfo_Id])
REFERENCES [dbo].[StoreAdditionalInfo] ([StoreAdditionalInfo_Id])
ALTER TABLE [dbo].[NAP] CHECK CONSTRAINT [FK_NAP_StoreAdditionalInfo]
GO
