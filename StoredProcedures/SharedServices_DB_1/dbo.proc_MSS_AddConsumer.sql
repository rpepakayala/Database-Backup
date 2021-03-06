/****** Object:  StoredProcedure [dbo].[proc_MSS_AddConsumer]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddConsumer(
    @ConsumerName nvarchar( 60 ) )
AS
    IF EXISTS ( SELECT * FROM dbo.MSSRegisteredConsumers WHERE ConsumerName = @ConsumerName )
        RETURN 1

    INSERT INTO
        dbo.MSSRegisteredConsumers
    VALUES (
        @ConsumerName,
        0 )

    RETURN @@ERROR

GO
