/****** Object:  Table [dbo].[Navigation_Role]    Script Date: 5/15/2018 11:58:45 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Navigation_Role](
	[Navigation_RoleID] [bigint] IDENTITY(1,1) NOT NULL,
	[NavigationID] [bigint] NOT NULL,
	[application_role_id] [bigint] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Navigation_Role] PRIMARY KEY CLUSTERED 
(
	[Navigation_RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Navigation_Role]  WITH CHECK ADD  CONSTRAINT [FK_Navigation_Role_Navigation] FOREIGN KEY([NavigationID])
REFERENCES [dbo].[Navigation] ([NavigationID])
ALTER TABLE [dbo].[Navigation_Role] CHECK CONSTRAINT [FK_Navigation_Role_Navigation]
GO
