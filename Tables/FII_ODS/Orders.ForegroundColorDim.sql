/****** Object:  Table [Orders].[ForegroundColorDim]    Script Date: 5/15/2018 11:59:35 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[ForegroundColorDim](
	[ForegroundColorKey] [int] IDENTITY(1,1) NOT NULL,
	[ForegroundColorName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ForegroundColorKey] PRIMARY KEY CLUSTERED 
(
	[ForegroundColorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_ForegroundColorName]    Script Date: 5/15/2018 11:59:35 AM ******/
CREATE NONCLUSTERED INDEX [Hint_ForegroundColorName] ON [Orders].[ForegroundColorDim]
(
	[ForegroundColorName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Orders].[ForegroundColorDim] ADD  CONSTRAINT [DF_ForegroundColor_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
