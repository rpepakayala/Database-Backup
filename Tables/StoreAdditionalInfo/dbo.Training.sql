/****** Object:  Table [dbo].[Training]    Script Date: 5/15/2018 12:06:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Training](
	[StoreAdditionalInfo_Id] [bigint] NOT NULL,
	[date] [datetime] NULL,
	[training] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[confidentiality] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[month] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[day] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[year] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Training_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Training_Id] PRIMARY KEY CLUSTERED 
(
	[Training_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Training]  WITH CHECK ADD  CONSTRAINT [FK_Training_StoreAdditionalInfo] FOREIGN KEY([StoreAdditionalInfo_Id])
REFERENCES [dbo].[StoreAdditionalInfo] ([StoreAdditionalInfo_Id])
ALTER TABLE [dbo].[Training] CHECK CONSTRAINT [FK_Training_StoreAdditionalInfo]
GO
