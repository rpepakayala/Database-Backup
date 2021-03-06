/****** Object:  Table [dbo].[syspolicy_object_sets_internal]    Script Date: 5/15/2018 12:03:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syspolicy_object_sets_internal](
	[object_set_id] [int] IDENTITY(1,1) NOT NULL,
	[object_set_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[facet_id] [int] NULL,
	[is_system] [bit] NOT NULL,
 CONSTRAINT [PK_syspolicy_object_sets] PRIMARY KEY CLUSTERED 
(
	[object_set_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_syspolicy_object_sets_name] UNIQUE NONCLUSTERED 
(
	[object_set_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[syspolicy_object_sets_internal] ADD  DEFAULT ((0)) FOR [is_system]
ALTER TABLE [dbo].[syspolicy_object_sets_internal]  WITH CHECK ADD  CONSTRAINT [FK_syspolicy_object_sets_syspolicy_management_facets] FOREIGN KEY([facet_id])
REFERENCES [dbo].[syspolicy_management_facets] ([management_facet_id])
ON DELETE CASCADE
ALTER TABLE [dbo].[syspolicy_object_sets_internal] CHECK CONSTRAINT [FK_syspolicy_object_sets_syspolicy_management_facets]
GO
