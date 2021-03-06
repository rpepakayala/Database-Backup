/****** Object:  Table [dbo].[Navigation]    Script Date: 5/15/2018 11:58:45 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Navigation](
	[NavigationID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentNavigationID] [bigint] NULL,
	[NameID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AltText] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[URL] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NewWindow] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Navigation] PRIMARY KEY CLUSTERED 
(
	[NavigationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [UQ__Navigation__NameID] UNIQUE NONCLUSTERED 
(
	[NameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Navigation] ADD  CONSTRAINT [DF_Navigation_NewWindow]  DEFAULT ((0)) FOR [NewWindow]
ALTER TABLE [dbo].[Navigation] ADD  CONSTRAINT [DF_Navigation_DisplayOrder]  DEFAULT ((1)) FOR [DisplayOrder]
ALTER TABLE [dbo].[Navigation]  WITH CHECK ADD  CONSTRAINT [FK_Navigation_Navigation] FOREIGN KEY([ParentNavigationID])
REFERENCES [dbo].[Navigation] ([NavigationID])
ALTER TABLE [dbo].[Navigation] CHECK CONSTRAINT [FK_Navigation_Navigation]
GO
