USE SCB_SPCINE
GO

CREATE PROCEDURE dbo.up_ATUALIZA_PROT (@ProtocoloPorID XML, @Erro INT OUTPUT, @MsgErr VARCHAR(255) OUTPUT) AS
BEGIN
	SET NOCOUNT ON

	DECLARE @EMP_CD_ANCINE VARCHAR(20),
			@SAL_CD_ANCINE VARCHAR(20),
			@BIL_DIA_CIN DATE,
			@BIL_PROT VARCHAR(50),
			@BIL_STATUS_PROT VARCHAR(1),
			@MSA_TP_MSG varchar(1),
			@MSA_CD_MSG varchar(4),
			@MSA_DT_HORA_INICIO datetime,
			@MSA_TXT_MSG varchar(500)

	DECLARE @QTD INT = 0

	If(OBJECT_ID('tempdb..##bil_prot_xml') Is Not Null)
	Begin
		Drop Table ##bil_prot_xml
	End

	CREATE TABLE ##bil_prot_xml
	(	EMP_CD_ANCINE VARCHAR(20),
		SAL_CD_ANCINE VARCHAR(20),
		BIL_DIA_CIN DATE,
		BIL_PROT VARCHAR(50),
		BIL_STATUS_PROT VARCHAR(1),
		MSA_TP_MSG varchar(1),
		MSA_CD_MSG varchar(4),
		MSA_DT_HORA_INICIO datetime,
		MSA_TXT_MSG varchar(500)
	)

	INSERT INTO ##bil_prot_xml
	SELECT DISTINCT tmpxml.statusRelatorioBilheteria.value('(registroANCINEExibidor/text())[1]','nvarchar(20)') AS EMP_CD_ANCINE, 
		   tmpxml.statusRelatorioBilheteria.value('(registroANCINESala/text())[1]','nvarchar(20)') AS SAL_CD_ANCINE,
		   tmpxml.statusRelatorioBilheteria.value('(diaCinematografico/text())[1]','date') AS BIL_DIA_CIN,
		   tmpxml.statusRelatorioBilheteria.value('(numeroProtocolo/text())[1]','nvarchar(50)') AS BIL_PROT,
		   tmpxml.statusRelatorioBilheteria.value('(statusProtocolo/text())[1]','nvarchar(1)') AS BIL_STATUS_PROT,
		   tmpxml1.mensagem.value('(tipoMensagem/text())[1]','nvarchar(1)') AS MSA_TP_MSG,
		   tmpxml1.mensagem.value('(codigoMensagem/text())[1]','nvarchar(4)') AS MSA_CD_MSG,
		   tmpxml1.mensagem.value('(dataHoraInicio/text())[1]','datetime') AS MSA_DT_HORA_INICIO,
		   tmpxml1.mensagem.value('(textoMensagem/text())[1]','nvarchar(max)') AS MSA_TXT_MSG
	FROM   @ProtocoloPorID.nodes('/statusRelatorioBilheteria') AS tmpxml(statusRelatorioBilheteria)
	OUTER APPLY tmpxml.statusRelatorioBilheteria.nodes('mensagens/mensagem') AS tmpxml1(mensagem)

	--SELECT * FROM ##bil_prot_xml

	DECLARE cursor_xml SCROLL CURSOR FOR 
		SELECT * FROM ##bil_prot_xml
		
	OPEN cursor_xml
	FETCH NEXT FROM cursor_xml INTO @EMP_CD_ANCINE, @SAL_CD_ANCINE, @BIL_DIA_CIN, @BIL_PROT, @BIL_STATUS_PROT, @MSA_TP_MSG, @MSA_CD_MSG, @MSA_DT_HORA_INICIO, @MSA_TXT_MSG
	WHILE @@FETCH_STATUS = 0
	BEGIN

		IF @QTD = 0
		BEGIN
			UPDATE TB_BILHETERIA
			SET BIL_STATUS_PROT = @BIL_STATUS_PROT, BIL_DT_ALT_STAT_PROT = GETDATE()
			WHERE EMP_CD_ANCINE = @EMP_CD_ANCINE
			AND SAL_CD_ANCINE = @SAL_CD_ANCINE
			AND BIL_DIA_CIN = @BIL_DIA_CIN
			AND BIL_PROT = @BIL_PROT

			SELECT @Erro = @@ERROR

			IF @Erro <> 0
			BEGIN
				SELECT @MsgErr = description
				FROM master..sysmessages
				WHERE error = @Erro
				RETURN
			END

			SELECT @QTD = 1
		END

		IF @MSA_CD_MSG IS NOT NULL
		BEGIN
			INSERT INTO TB_MENSAGEM_ANCINE
			
			SELECT GETDATE(), DATEADD(MINUTE, 1, GETDATE()), B.BIL_ID, @SAL_CD_ANCINE, S.SEA_ID, @MSA_DT_HORA_INICIO, @MSA_TP_MSG, @MSA_CD_MSG, @MSA_TXT_MSG
			
			FROM TB_BILHETERIA B, TB_SESSAO_ANCINE S
			
			WHERE B.EMP_CD_ANCINE  = @EMP_CD_ANCINE
			AND B.SAL_CD_ANCINE    = @SAL_CD_ANCINE
			AND B.BIL_DIA_CIN      = @BIL_DIA_CIN
			AND B.BIL_PROT         = CASE WHEN @BIL_PROT IS NULL THEN B.BIL_PROT ELSE @BIL_PROT END
			AND B.BIL_ID           = CASE WHEN S.BIL_ID IS NULL THEN B.BIL_ID ELSE S.BIL_ID END
			AND S.SEA_DT_HR_INICIO = CASE WHEN @MSA_DT_HORA_INICIO IS NULL THEN S.SEA_DT_HR_INICIO ELSE @MSA_DT_HORA_INICIO END

			SELECT @Erro = @@ERROR
			IF @Erro <> 0
				BEGIN
					SELECT @MsgErr = description
					FROM master..sysmessages
					WHERE error = @Erro
					RETURN
				END
		END

		FETCH NEXT FROM cursor_xml INTO @EMP_CD_ANCINE, @SAL_CD_ANCINE, @BIL_DIA_CIN, @BIL_PROT, @BIL_STATUS_PROT, @MSA_TP_MSG, @MSA_CD_MSG, @MSA_DT_HORA_INICIO, @MSA_TXT_MSG
	END

	CLOSE cursor_xml
	DEALLOCATE cursor_xml
	If(OBJECT_ID('tempdb..##bil_prot_xml') Is Not Null)
	Begin
		Drop Table ##bil_prot_xml
	End

END
GO