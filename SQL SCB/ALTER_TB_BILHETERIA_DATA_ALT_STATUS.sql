USE [SCB_SPCINE]
GO

ALTER TABLE [dbo].[TB_BILHETERIA]
ADD [BIL_DT_ALT_ADIMP] [DATETIME] NULL,
    [BIL_DT_ALT_STAT_PROT] [DATETIME] NULL
GO