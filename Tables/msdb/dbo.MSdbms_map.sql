/****** Object:  Table [dbo].[MSdbms_map]    Script Date: 5/15/2018 12:02:59 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSdbms_map](
	[map_id] [int] IDENTITY(1,1) NOT NULL,
	[src_dbms_id] [int] NOT NULL,
	[dest_dbms_id] [int] NOT NULL,
	[src_datatype_id] [int] NOT NULL,
	[src_len_min] [bigint] NULL,
	[src_len_max] [bigint] NULL,
	[src_prec_min] [bigint] NULL,
	[src_prec_max] [bigint] NULL,
	[src_scale_min] [bigint] NULL,
	[src_scale_max] [bigint] NULL,
	[src_nullable] [bit] NULL,
	[default_datatype_mapping_id] [int] NULL,
 CONSTRAINT [pk_MSdbms_map] PRIMARY KEY CLUSTERED 
(
	[map_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[MSdbms_map] ADD  DEFAULT (NULL) FOR [src_len_min]
ALTER TABLE [dbo].[MSdbms_map] ADD  DEFAULT (NULL) FOR [src_len_max]
ALTER TABLE [dbo].[MSdbms_map] ADD  DEFAULT (NULL) FOR [src_prec_min]
ALTER TABLE [dbo].[MSdbms_map] ADD  DEFAULT (NULL) FOR [src_prec_max]
ALTER TABLE [dbo].[MSdbms_map] ADD  DEFAULT (NULL) FOR [src_scale_min]
ALTER TABLE [dbo].[MSdbms_map] ADD  DEFAULT (NULL) FOR [src_scale_max]
ALTER TABLE [dbo].[MSdbms_map] ADD  DEFAULT (NULL) FOR [src_nullable]
ALTER TABLE [dbo].[MSdbms_map] ADD  DEFAULT (NULL) FOR [default_datatype_mapping_id]
ALTER TABLE [dbo].[MSdbms_map]  WITH CHECK ADD  CONSTRAINT [fk_MSdbms_map_default_datatype_mapping_id] FOREIGN KEY([default_datatype_mapping_id])
REFERENCES [dbo].[MSdbms_datatype_mapping] ([datatype_mapping_id])
ALTER TABLE [dbo].[MSdbms_map] CHECK CONSTRAINT [fk_MSdbms_map_default_datatype_mapping_id]
ALTER TABLE [dbo].[MSdbms_map]  WITH CHECK ADD  CONSTRAINT [fk_MSdbms_map_dest_dbms_id] FOREIGN KEY([dest_dbms_id])
REFERENCES [dbo].[MSdbms] ([dbms_id])
ALTER TABLE [dbo].[MSdbms_map] CHECK CONSTRAINT [fk_MSdbms_map_dest_dbms_id]
ALTER TABLE [dbo].[MSdbms_map]  WITH CHECK ADD  CONSTRAINT [fk_MSdbms_map_src_datatype_id] FOREIGN KEY([src_datatype_id])
REFERENCES [dbo].[MSdbms_datatype] ([datatype_id])
ALTER TABLE [dbo].[MSdbms_map] CHECK CONSTRAINT [fk_MSdbms_map_src_datatype_id]
ALTER TABLE [dbo].[MSdbms_map]  WITH CHECK ADD  CONSTRAINT [fk_MSdbms_map_src_dbms_id] FOREIGN KEY([src_dbms_id])
REFERENCES [dbo].[MSdbms] ([dbms_id])
ALTER TABLE [dbo].[MSdbms_map] CHECK CONSTRAINT [fk_MSdbms_map_src_dbms_id]
GO
