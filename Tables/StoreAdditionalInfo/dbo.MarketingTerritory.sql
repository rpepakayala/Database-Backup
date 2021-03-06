/****** Object:  Table [dbo].[MarketingTerritory]    Script Date: 5/15/2018 12:06:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MarketingTerritory](
	[Marketing_Id] [bigint] NOT NULL,
	[Zip] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MarketingTerritory_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_MarketingTerritory_Id] PRIMARY KEY CLUSTERED 
(
	[MarketingTerritory_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[MarketingTerritory]  WITH CHECK ADD  CONSTRAINT [FK_MarketingTerritory_Marketing] FOREIGN KEY([Marketing_Id])
REFERENCES [dbo].[Marketing] ([Marketing_Id])
ALTER TABLE [dbo].[MarketingTerritory] CHECK CONSTRAINT [FK_MarketingTerritory_Marketing]
GO
