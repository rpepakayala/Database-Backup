/****** Object:  StoredProcedure [dbo].[proc_markWebAsProvisioned]    Script Date: 5/15/2018 12:12:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_markWebAsProvisioned(
    @WebId uniqueidentifier)
AS
    SET NOCOUNT ON
    UPDATE 
        Webs
    SET
        Flags = ~(0x100 | ~Flags)
    WHERE
        Id = @WebId

GO
