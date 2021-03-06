/****** Object:  Table [dbo].[tblAssetContacts]    Script Date: 5/15/2018 12:01:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[tblAssetContacts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nAssetID] [int] NOT NULL,
	[vcEmployee] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DigitalAssets.tblAssetContacts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[tblAssetContacts]  WITH CHECK ADD  CONSTRAINT [FK_DigitalAssets.tblAssetContacts_DigitalAssets.tblAssets] FOREIGN KEY([nAssetID])
REFERENCES [dbo].[tblAssets] ([ID])
ALTER TABLE [dbo].[tblAssetContacts] CHECK CONSTRAINT [FK_DigitalAssets.tblAssetContacts_DigitalAssets.tblAssets]
GO
