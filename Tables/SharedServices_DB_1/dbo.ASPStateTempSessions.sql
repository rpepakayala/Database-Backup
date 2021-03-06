/****** Object:  Table [dbo].[ASPStateTempSessions]    Script Date: 5/15/2018 12:05:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ASPStateTempSessions](
	[SessionId] [nvarchar](88) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Created] [datetime] NOT NULL,
	[Expires] [datetime] NOT NULL,
	[LockDate] [datetime] NOT NULL,
	[LockDateLocal] [datetime] NOT NULL,
	[LockCookie] [int] NOT NULL,
	[Timeout] [int] NOT NULL,
	[Locked] [bit] NOT NULL,
	[SessionItemShort] [varbinary](7000) NULL,
	[SessionItemLong] [image] NULL,
	[Flags] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_Expires]    Script Date: 5/15/2018 12:05:10 PM ******/
CREATE NONCLUSTERED INDEX [Index_Expires] ON [dbo].[ASPStateTempSessions]
(
	[Expires] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[ASPStateTempSessions] ADD  DEFAULT (getutcdate()) FOR [Created]
ALTER TABLE [dbo].[ASPStateTempSessions] ADD  DEFAULT ((0)) FOR [Flags]
GO
