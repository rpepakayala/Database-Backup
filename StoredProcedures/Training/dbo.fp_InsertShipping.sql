/****** Object:  StoredProcedure [dbo].[fp_InsertShipping]    Script Date: 5/15/2018 12:13:19 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE fp_InsertShipping 
(   @InfoID int,
    @Address1 varchar(50),
    @Address2 varchar(50),
    @City varchar(50),
    @State varchar(2),
    @ZIP varchar(10) )

AS

INSERT INTO FP_Shipping
 ( InfoID,
   Address1,
   Address2,
   City,
   State,
   ZIP,
   Shipped,
   Invoiced )
VALUES
 ( @InfoID,
   @Address1,
   @Address2,
   @City,
   @State,
   @ZIP,
   0,
   0 )

GO
