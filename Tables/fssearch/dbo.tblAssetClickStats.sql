/****** Object:  Table [dbo].[tblAssetClickStats]    Script Date: 5/15/2018 12:01:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[tblAssetClickStats](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nAssetID] [int] NOT NULL,
	[dtmDateClicked] [datetime] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_tblAssetClickStats] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[tblAssetClickStats]  WITH CHECK ADD  CONSTRAINT [FK_tblAssetClickStats_tblAssets] FOREIGN KEY([nAssetID])
REFERENCES [dbo].[tblAssets] ([ID])
ALTER TABLE [dbo].[tblAssetClickStats] CHECK CONSTRAINT [FK_tblAssetClickStats_tblAssets]
GO
