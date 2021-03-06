/****** Object:  Table [Orders].[TrackingNumberDim]    Script Date: 5/15/2018 11:59:38 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[TrackingNumberDim](
	[TrackingNumberKey] [int] IDENTITY(1,1) NOT NULL,
	[TrackingNumberName] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_TrackingNumberKey] PRIMARY KEY CLUSTERED 
(
	[TrackingNumberKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_TrackingNumberName]    Script Date: 5/15/2018 11:59:38 AM ******/
CREATE NONCLUSTERED INDEX [Hint_TrackingNumberName] ON [Orders].[TrackingNumberDim]
(
	[TrackingNumberName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Orders].[TrackingNumberDim] ADD  CONSTRAINT [DF_TrackingNumber_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
