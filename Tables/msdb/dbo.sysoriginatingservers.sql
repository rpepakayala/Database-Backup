/****** Object:  Table [dbo].[sysoriginatingservers]    Script Date: 5/15/2018 12:03:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysoriginatingservers](
	[originating_server_id] [int] NULL,
	[originating_server] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[master_server] [bit] NULL,
UNIQUE CLUSTERED 
(
	[originating_server_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[originating_server] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sysoriginatingservers] ADD  DEFAULT ((1)) FOR [originating_server_id]
ALTER TABLE [dbo].[sysoriginatingservers] ADD  DEFAULT ((1)) FOR [master_server]
ALTER TABLE [dbo].[sysoriginatingservers]  WITH CHECK ADD  CONSTRAINT [CK_master_server_MustBe_1] CHECK  (([master_server]=(1)))
ALTER TABLE [dbo].[sysoriginatingservers] CHECK CONSTRAINT [CK_master_server_MustBe_1]
ALTER TABLE [dbo].[sysoriginatingservers]  WITH CHECK ADD  CONSTRAINT [CK_originating_server_id_MustBe_1] CHECK  (([originating_server_id]=(1)))
ALTER TABLE [dbo].[sysoriginatingservers] CHECK CONSTRAINT [CK_originating_server_id_MustBe_1]
/****** Object:  Trigger [dbo].[trig_sysoriginatingservers_delete]    Script Date: 5/15/2018 12:03:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE TRIGGER [dbo].[trig_sysoriginatingservers_delete]
ON [dbo].[sysoriginatingservers]
FOR DELETE
AS
BEGIN
  SET NOCOUNT ON
  -- Only a single MSX server entry can exist in this table. ie. originating_server_id = 1 and master_server = 1. 
  IF((EXISTS (SELECT *
           FROM deleted AS d
                JOIN dbo.sysjobs AS j ON d.originating_server_id = j.originating_server_id)) OR
    (EXISTS (SELECT *
           FROM deleted AS d
                JOIN dbo.sysschedules AS s ON d.originating_server_id = s.originating_server_id)))
  BEGIN
    RAISERROR(14380, -1, -1)
   ROLLBACK TRANSACTION
    RETURN
  END
END

GO
