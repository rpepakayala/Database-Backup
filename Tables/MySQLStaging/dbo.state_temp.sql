/****** Object:  Table [dbo].[state_temp]    Script Date: 5/15/2018 12:04:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[state_temp](
	[state_id] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[state_cd] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[country_cd] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[state_nm] [nvarchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_state_temp_state_id] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[state_temp] ADD  DEFAULT (NULL) FOR [country_cd]
ALTER TABLE [dbo].[state_temp] ADD  DEFAULT (NULL) FOR [state_nm]
GO
