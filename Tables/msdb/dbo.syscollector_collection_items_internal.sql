/****** Object:  Table [dbo].[syscollector_collection_items_internal]    Script Date: 5/15/2018 12:03:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syscollector_collection_items_internal](
	[collection_set_id] [int] NOT NULL,
	[collection_item_id] [int] IDENTITY(1,1) NOT NULL,
	[collector_type_uid] [uniqueidentifier] NOT NULL,
	[name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[name_id] [int] NULL,
	[frequency] [int] NOT NULL,
	[parameters] [xml] NULL,
 CONSTRAINT [PK_syscollector_collection_items_internal] PRIMARY KEY CLUSTERED 
(
	[collection_set_id] ASC,
	[collection_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_syscollector_collection_items_internal_name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[syscollector_collection_items_internal]  WITH CHECK ADD  CONSTRAINT [FK_syscollector_collection_items_internal_syscollector_collection_sets_internal] FOREIGN KEY([collection_set_id])
REFERENCES [dbo].[syscollector_collection_sets_internal] ([collection_set_id])
ON DELETE CASCADE
ALTER TABLE [dbo].[syscollector_collection_items_internal] CHECK CONSTRAINT [FK_syscollector_collection_items_internal_syscollector_collection_sets_internal]
ALTER TABLE [dbo].[syscollector_collection_items_internal]  WITH CHECK ADD  CONSTRAINT [FK_syscollector_collection_items_internal_syscollector_collector_types_internal] FOREIGN KEY([collector_type_uid])
REFERENCES [dbo].[syscollector_collector_types_internal] ([collector_type_uid])
ON DELETE CASCADE
ALTER TABLE [dbo].[syscollector_collection_items_internal] CHECK CONSTRAINT [FK_syscollector_collection_items_internal_syscollector_collector_types_internal]
/****** Object:  Trigger [dbo].[syscollector_collection_item_parameter_update_trigger]    Script Date: 5/15/2018 12:03:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER [dbo].[syscollector_collection_item_parameter_update_trigger] on [dbo].[syscollector_collection_items_internal]
FOR UPDATE
AS
BEGIN
    DECLARE @collection_set_id int
    DECLARE @collection_item_id int

    -- remove the TSQL query collection item that was updated so packages will be regenerated 
    -- base on the new parameters
    IF (NOT UPDATE (parameters))
       RETURN

    -- clean up the SSIS packages that are left behind
    DECLARE inserted_cursor CURSOR LOCAL FOR
        SELECT collection_set_id, collection_item_id
        FROM inserted
    
    OPEN inserted_cursor
    FETCH inserted_cursor INTO @collection_set_id, @collection_item_id

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DELETE FROM dbo.syscollector_tsql_query_collector 
        WHERE collection_set_id = @collection_set_id
        AND collection_item_id = @collection_item_id

        FETCH inserted_cursor INTO @collection_set_id, @collection_item_id
    END

    CLOSE inserted_cursor
    DEALLOCATE inserted_cursor
END

GO
