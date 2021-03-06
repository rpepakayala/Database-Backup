/****** Object:  Table [dbo].[POS]    Script Date: 5/15/2018 12:06:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[POS](
	[StoreAdditionalInfo_Id] [bigint] NOT NULL,
	[date] [datetime] NULL,
	[pOSName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[version] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[supportThru] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[POS_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_POS_Id] PRIMARY KEY CLUSTERED 
(
	[POS_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[POS]  WITH CHECK ADD  CONSTRAINT [FK_POS_StoreAdditionalInfo] FOREIGN KEY([StoreAdditionalInfo_Id])
REFERENCES [dbo].[StoreAdditionalInfo] ([StoreAdditionalInfo_Id])
ALTER TABLE [dbo].[POS] CHECK CONSTRAINT [FK_POS_StoreAdditionalInfo]
GO
