/****** Object:  Table [dbo].[appointment_types]    Script Date: 5/15/2018 12:03:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[appointment_types](
	[appointment_type_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[duration] [int] NOT NULL,
 CONSTRAINT [PK_appointment_types_appointment_type_id] PRIMARY KEY CLUSTERED 
(
	[appointment_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[appointment_types] ADD  DEFAULT (NULL) FOR [name]
ALTER TABLE [dbo].[appointment_types] ADD  DEFAULT ((0)) FOR [duration]
GO
