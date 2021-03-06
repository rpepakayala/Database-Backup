/****** Object:  Table [dbo].[MSSScopeDisplayGroups]    Script Date: 5/15/2018 12:05:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSScopeDisplayGroups](
	[DisplayGroupID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Description] [nvarchar](300) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[ConsumerID] [int] NOT NULL,
	[DisplayInAdminUI] [bit] NOT NULL,
	[Undeletable] [bit] NOT NULL,
	[DefaultScopeID] [int] NOT NULL,
	[LastModifiedTime] [datetime] NOT NULL,
	[LastModifiedBy] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DisplayGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[ConsumerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[MSSScopeDisplayGroups]  WITH CHECK ADD  CONSTRAINT [FK_ScopeDisplayGroups_ConsumerID] FOREIGN KEY([ConsumerID])
REFERENCES [dbo].[MSSRegisteredConsumers] ([ConsumerID])
ON DELETE CASCADE
ALTER TABLE [dbo].[MSSScopeDisplayGroups] CHECK CONSTRAINT [FK_ScopeDisplayGroups_ConsumerID]
GO
