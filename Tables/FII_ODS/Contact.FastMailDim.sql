/****** Object:  Table [Contact].[FastMailDim]    Script Date: 5/15/2018 11:59:22 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Contact].[FastMailDim](
	[ContactKey] [int] NOT NULL,
	[CustomerKey] [int] NULL,
	[IS_OYB] [bit] NOT NULL,
	[IsModified] [bit] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_CustomerKey] PRIMARY KEY CLUSTERED 
(
	[ContactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Contact].[FastMailDim] ADD  CONSTRAINT [DF_FastMailDim_IsModified]  DEFAULT ((0)) FOR [IsModified]
ALTER TABLE [Contact].[FastMailDim] ADD  CONSTRAINT [DF_LastUpdated]  DEFAULT (getdate()) FOR [LastUpdated]
/****** Object:  Trigger [Contact].[FastMailDim_Update]    Script Date: 5/15/2018 11:59:22 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
Create TRIGGER [Contact].[FastMailDim_Update]
  ON [Contact].[FastMailDim] 
FOR INSERT,UPDATE
AS 
BEGIN
UPDATE Contact.FastMailDim SET Contact.FastMailDim.LastUpdated = GETDATE()
  FROM INSERTED
  WHERE INSERTED.Customerkey = Contact.FastMailDim.CustomerKey

END

GO
