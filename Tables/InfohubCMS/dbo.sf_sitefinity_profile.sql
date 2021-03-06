/****** Object:  Table [dbo].[sf_sitefinity_profile]    Script Date: 5/15/2018 12:02:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_sitefinity_profile](
	[id] [uniqueidentifier] NOT NULL,
	[preferred_language] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[nickname] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[first_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[about] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[posts_count] [int] NULL,
	[is_profile_public] [bit] NULL,
 CONSTRAINT [pk_sf_sitefinity_profile] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[sf_sitefinity_profile]  WITH CHECK ADD  CONSTRAINT [ref_sf_stfnty_prfl_sf_125BEED3] FOREIGN KEY([id])
REFERENCES [dbo].[sf_user_profile] ([id])
ON DELETE CASCADE
ALTER TABLE [dbo].[sf_sitefinity_profile] CHECK CONSTRAINT [ref_sf_stfnty_prfl_sf_125BEED3]
GO
