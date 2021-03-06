/****** Object:  Table [internal].[extended_operation_info]    Script Date: 5/15/2018 12:06:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[extended_operation_info](
	[info_id] [bigint] IDENTITY(1,1) NOT NULL,
	[operation_id] [bigint] NOT NULL,
	[object_name] [nvarchar](260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[object_type] [smallint] NULL,
	[reference_id] [bigint] NULL,
	[status] [int] NOT NULL,
	[start_time] [datetimeoffset](7) NOT NULL,
	[end_time] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_Operation_Info] PRIMARY KEY CLUSTERED 
(
	[info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [internal].[extended_operation_info]  WITH CHECK ADD  CONSTRAINT [FK_OperationInfo_Operations] FOREIGN KEY([operation_id])
REFERENCES [internal].[operations] ([operation_id])
ON DELETE CASCADE
ALTER TABLE [internal].[extended_operation_info] CHECK CONSTRAINT [FK_OperationInfo_Operations]
GO
