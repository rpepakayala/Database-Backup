/****** Object:  Table [dbo].[FM_DIY_IDS]    Script Date: 5/15/2018 12:00:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FM_DIY_IDS](
	[ET_UserID] [int] NOT NULL,
	[ET_BUID] [int] NOT NULL,
	[webNumber] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_FM_DIY_IDS] PRIMARY KEY CLUSTERED 
(
	[webNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[FM_DIY_IDS] ADD  CONSTRAINT [DF_FM_DIY_IDS_ET_UserID]  DEFAULT ((0)) FOR [ET_UserID]
ALTER TABLE [dbo].[FM_DIY_IDS] ADD  CONSTRAINT [DF_FM_DIY_IDS_ET_BUID]  DEFAULT ((0)) FOR [ET_BUID]
ALTER TABLE [dbo].[FM_DIY_IDS] ADD  CONSTRAINT [DF_FM_DIY_IDS_Active]  DEFAULT ((0)) FOR [Active]
GO
