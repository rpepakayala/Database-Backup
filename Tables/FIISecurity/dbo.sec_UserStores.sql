/****** Object:  Table [dbo].[sec_UserStores]    Script Date: 5/15/2018 12:00:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sec_UserStores](
	[user_id] [bigint] NOT NULL,
	[storeNumber] [bigint] NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[sec_UserStores]  WITH CHECK ADD  CONSTRAINT [FK_UserStores_AuthenticatedUsers] FOREIGN KEY([user_id])
REFERENCES [dbo].[sec_AuthenticatedUsers] ([user_id])
ALTER TABLE [dbo].[sec_UserStores] CHECK CONSTRAINT [FK_UserStores_AuthenticatedUsers]
GO
