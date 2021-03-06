/****** Object:  Table [Orders].[OriginLink]    Script Date: 5/15/2018 11:59:36 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[OriginLink](
	[OriginKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerTypeID] [int] NULL,
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OriginTypeKey] [int] NULL,
	[OLTP_InsertDate] [datetime] NULL,
	[OLTP_UpdateDate] [datetime] NULL,
	[UpdateCheckSum] [int] NULL,
 CONSTRAINT [PK_OriginLink] PRIMARY KEY CLUSTERED 
(
	[OriginKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Orders].[OriginLink]  WITH CHECK ADD  CONSTRAINT [FK_OriginLink_OriginTypeKey] FOREIGN KEY([OriginTypeKey])
REFERENCES [Orders].[OriginTypeDim] ([OriginTypeKey])
ALTER TABLE [Orders].[OriginLink] CHECK CONSTRAINT [FK_OriginLink_OriginTypeKey]
GO
