/****** Object:  Table [dbo].[eula_acceptance]    Script Date: 5/15/2018 12:04:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[eula_acceptance](
	[eula_acceptance_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[employee_data_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[eula_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[accepted_on] [datetime2](0) NULL,
 CONSTRAINT [PK_eula_acceptance_eula_acceptance_id] PRIMARY KEY CLUSTERED 
(
	[eula_acceptance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [employee_data_id]    Script Date: 5/15/2018 12:04:08 PM ******/
CREATE NONCLUSTERED INDEX [employee_data_id] ON [dbo].[eula_acceptance]
(
	[employee_data_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [eula_accepatence_fkey]    Script Date: 5/15/2018 12:04:08 PM ******/
CREATE NONCLUSTERED INDEX [eula_accepatence_fkey] ON [dbo].[eula_acceptance]
(
	[eula_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[eula_acceptance] ADD  DEFAULT (NULL) FOR [accepted_on]
GO
