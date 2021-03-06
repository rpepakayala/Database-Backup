/****** Object:  StoredProcedure [dbo].[DynamicDescriptionAdd]    Script Date: 5/15/2018 12:10:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.DynamicDescriptionAdd
(
	@DynDescId int = NULL,
	@DynDescFilename varchar(50) = NULL,
	@DynDescCategory varchar(50) = NULL,
	@DynDescDescription varchar(1500) = NULL
)
AS
INSERT INTO DynamicDescription (DynDescId, DynDescFilename, DynDescCategory, DynDescDescription)
 VALUES (@DynDescId, @DynDescFilename, @DynDescCategory, @DynDescDescription);


GO
