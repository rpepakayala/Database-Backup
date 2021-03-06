/****** Object:  Table [dbo].[tblAssociations]    Script Date: 5/15/2018 12:01:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[tblAssociations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nAssetID] [int] NOT NULL,
	[nAssociatedAssetID] [int] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DigitalAssets.tblAssociations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[tblAssociations]  WITH CHECK ADD  CONSTRAINT [FK_DigitalAssets.tblAssociations_DigitalAssets.tblAssets] FOREIGN KEY([nAssetID])
REFERENCES [dbo].[tblAssets] ([ID])
ALTER TABLE [dbo].[tblAssociations] CHECK CONSTRAINT [FK_DigitalAssets.tblAssociations_DigitalAssets.tblAssets]
ALTER TABLE [dbo].[tblAssociations]  WITH CHECK ADD  CONSTRAINT [FK_DigitalAssets.tblAssociations_DigitalAssets.tblAssets1] FOREIGN KEY([nAssociatedAssetID])
REFERENCES [dbo].[tblAssets] ([ID])
ALTER TABLE [dbo].[tblAssociations] CHECK CONSTRAINT [FK_DigitalAssets.tblAssociations_DigitalAssets.tblAssets1]
GO
