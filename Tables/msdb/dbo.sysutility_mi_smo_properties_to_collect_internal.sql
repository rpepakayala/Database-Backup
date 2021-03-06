/****** Object:  Table [dbo].[sysutility_mi_smo_properties_to_collect_internal]    Script Date: 5/15/2018 12:03:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysutility_mi_smo_properties_to_collect_internal](
	[object_type] [int] NOT NULL,
	[property_name] [nvarchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[object_type] ASC,
	[property_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sysutility_mi_smo_properties_to_collect_internal]  WITH CHECK ADD  CONSTRAINT [FK_sysutility_mi_smo_properties] FOREIGN KEY([object_type])
REFERENCES [dbo].[sysutility_mi_smo_objects_to_collect_internal] ([object_type])
ON DELETE CASCADE
ALTER TABLE [dbo].[sysutility_mi_smo_properties_to_collect_internal] CHECK CONSTRAINT [FK_sysutility_mi_smo_properties]
GO
