/****** Object:  View [dbo].[syscollector_config_store]    Script Date: 5/15/2018 12:14:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[syscollector_config_store]
AS
    SELECT
        s.parameter_name,
        s.parameter_value
    FROM 
        [dbo].[syscollector_config_store_internal] s

GO
