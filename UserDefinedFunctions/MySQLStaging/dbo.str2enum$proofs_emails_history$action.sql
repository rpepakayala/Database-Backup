/****** Object:  UserDefinedFunction [dbo].[str2enum$proofs_emails_history$action]    Script Date: 5/15/2018 12:15:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$proofs_emails_history$action 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'viewed' THEN 1
            WHEN 'response' THEN 2
            WHEN 'status' THEN 3
            ELSE 0
         END
   END
GO
