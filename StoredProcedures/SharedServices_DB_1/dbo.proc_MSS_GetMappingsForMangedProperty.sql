/****** Object:  StoredProcedure [dbo].[proc_MSS_GetMappingsForMangedProperty]    Script Date: 5/15/2018 12:11:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetMappingsForMangedProperty
@pid int
AS

select cp.Propset, cp.PropertyName, cp.VariantType
    From MSSSchemaPropertyMappings as m
    Inner Join MSSCrawledProperties as cp
          on m.crawledPropertyId = cp.crawledPropertyId
    Where m.pid = @pid
    Order By m.MappingOrder


GO
