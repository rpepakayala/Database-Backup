/****** Object:  StoredProcedure [dbo].[getConceptDestinations]    Script Date: 5/15/2018 12:09:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON




CREATE PROCEDURE [dbo].[getConceptDestinations]
(
@concept_id varchar(3)
)	
AS
SET NOCOUNT ON;

SELECT [destination_name], [num_consolidators] 
FROM [AvailableDestinations]
WHERE concept_id = @concept_id

GO
