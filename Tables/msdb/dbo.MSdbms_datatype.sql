/****** Object:  Table [dbo].[MSdbms_datatype]    Script Date: 5/15/2018 12:02:59 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSdbms_datatype](
	[datatype_id] [int] IDENTITY(1,1) NOT NULL,
	[dbms_id] [int] NOT NULL,
	[type] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[createparams] [int] NOT NULL,
 CONSTRAINT [pk_MSdbms_datatype] PRIMARY KEY CLUSTERED 
(
	[datatype_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[MSdbms_datatype] ADD  DEFAULT ((0)) FOR [createparams]
ALTER TABLE [dbo].[MSdbms_datatype]  WITH CHECK ADD  CONSTRAINT [fk_MSdbms_datatype_dbms_id] FOREIGN KEY([dbms_id])
REFERENCES [dbo].[MSdbms] ([dbms_id])
ALTER TABLE [dbo].[MSdbms_datatype] CHECK CONSTRAINT [fk_MSdbms_datatype_dbms_id]
GO
