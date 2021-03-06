/****** Object:  Table [Fuzzy].[OriginMapping]    Script Date: 5/15/2018 11:59:56 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Fuzzy].[OriginMapping](
	[SourceCustomerType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PreliminaryOriginMatch] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[1stPass_OriginMappingMatch] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[1stPass_OriginKey] [int] NULL,
	[1stPass_OriginName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[1stPass_Similarity] [real] NULL,
	[1stPass_Confidence] [real] NULL,
	[2ndPass_OriginKey] [int] NULL,
	[2ndPass_OriginName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[2ndPass_Similarity] [real] NULL,
	[2ndPass_Confidence] [real] NULL,
	[3rdPass_OriginKey] [int] NULL,
	[3rdPass_OriginName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[3rdPass_SimilarityMap] [real] NULL,
	[3rdPass_Similarity] [real] NULL,
	[3rdPass_Confidence] [real] NULL,
	[Final_OriginKey] [int] NULL,
	[Final_OriginName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Final_Similarity] [real] NULL,
	[Final_Confidence] [real] NULL,
	[Final_Similarity_Rounded]  AS (round([Final_Similarity],(1))),
	[Final_Confidence_Rounded]  AS (round([final_confidence],(1))),
	[FS_Display1]  AS (CONVERT([char](3),right('00'+CONVERT([varchar],CONVERT([int],round([Final_Similarity],(1))*(100),(0)),(0)),(3)),(0))),
	[FS_Display2]  AS (CONVERT([char](3),right('00'+CONVERT([varchar],CONVERT([int],[Final_Similarity]*(100),(0)),(0)),(3)),(0))),
	[FC_Display1]  AS (CONVERT([char](3),right('00'+CONVERT([varchar],CONVERT([int],round([Final_Confidence],(1))*(100),(0)),(0)),(3)),(0))),
	[FC_Display2]  AS (CONVERT([char](3),right('00'+CONVERT([varchar],CONVERT([int],[Final_Confidence]*(100),(0)),(0)),(3)),(0))),
 CONSTRAINT [PK_OriginMapping] PRIMARY KEY NONCLUSTERED 
(
	[SourceCustomerType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
