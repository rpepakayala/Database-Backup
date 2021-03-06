/****** Object:  StoredProcedure [dbo].[setConceptDestinationMessages]    Script Date: 5/15/2018 12:09:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[setConceptDestinationMessages]
(
@concept_id varchar(4),
@destination_name varchar(50),
@approx_message_count int
)              
AS
SET NOCOUNT ON;

UPDATE [AvailableDestinations]
SET [approx_message_count] = @approx_message_count
WHERE [concept_id] = @concept_id
AND [destination_name] = @destination_name

GO
