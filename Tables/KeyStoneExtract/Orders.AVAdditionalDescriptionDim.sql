/****** Object:  Table [Orders].[AVAdditionalDescriptionDim]    Script Date: 5/15/2018 12:02:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[AVAdditionalDescriptionDim](
	[AVAdditionalDescriptionKey] [int] NOT NULL,
	[AVAdditionalDescriptionName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_AVAdditionalDescriptionKey] PRIMARY KEY CLUSTERED 
(
	[AVAdditionalDescriptionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Orders].[AVAdditionalDescriptionDim] ADD  CONSTRAINT [DF_AVAdditionalDescription_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
