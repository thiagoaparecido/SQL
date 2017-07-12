DECLARE @ProtocoloPorID xml,
		@ERRO INT,
		@MSG VARCHAR(255)



SET @ProtocoloPorID = CONVERT(xml, N'<statusRelatorioBilheteria><registroANCINEExibidor>32360</registroANCINEExibidor><registroANCINESala>5005461</registroANCINESala><diaCinematografico>2017-06-18</diaCinematografico><numeroProtocolo>5005461.1.18062017.009</numeroProtocolo><statusProtocolo>E</statusProtocolo><mensagens><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-18 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-18 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem><mensagem><tipoMensagem>A</tipoMensagem><codigoMensagem>A510</codigoMensagem><dataHoraInicio>2017-06-18 14:00:00</dataHoraInicio><textoMensagem>O PMI de cada categoria de ingressos deve estar entre R$1,00 e R$200</textoMensagem></mensagem><mensagem><tipoMensagem>A</tipoMensagem><codigoMensagem>A510</codigoMensagem><dataHoraInicio>2017-06-18 14:00:00</dataHoraInicio><textoMensagem>O PMI de cada categoria de ingressos deve estar entre R$1,00 e R$200</textoMensagem></mensagem></mensagens></statusRelatorioBilheteria>',1)
--SET @ProtocoloPorID = CONVERT(xml, N'<statusRelatorioBilheteria><registroANCINEExibidor>32360</registroANCINEExibidor><registroANCINESala>5005463</registroANCINESala><diaCinematografico>2017-06-18</diaCinematografico><numeroProtocolo>5005463.1.18062017.001</numeroProtocolo><statusProtocolo>V</statusProtocolo><mensagens/></statusRelatorioBilheteria>',1)

--SET @ProtocoloPorID = CONVERT(xml, N'<registroANCINEExibidor>32360</registroANCINEExibidor><registroANCINESala>5005463</registroANCINESala><diaCinematografico>2017-06-18</diaCinematografico><numeroProtocolo>5005463.1.18062017.001</numeroProtocolo><statusProtocolo>V</statusProtocolo><mensagens /></statusRelatorioBilheteria>',1)

EXECUTE dbo.up_ATUALIZA_PROT 
   @ProtocoloPorID, @ERRO, @MSG

SELECT @ERRO
SELECT @MSG
GO

<?xml version=\"1.0\" encoding=\"UTF8\" standalone=\"yes\"?><statusRelatorioBilheteria><registroANCINEExibidor>32360</registroANCINEExibidor><registroANCINESala>5005461</registroANCINESala><diaCinematografico>2017-06-18</diaCinematografico><numeroProtocolo>5005461.1.18062017.006</numeroProtocolo><statusProtocolo>E</statusProtocolo><mensagens><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-18 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-18 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem><mensagem><tipoMensagem>A</tipoMensagem><codigoMensagem>A510</codigoMensagem><dataHoraInicio>2017-
06-18 14:00:00</dataHoraInicio><textoMensagem>O PMI de cada categoria de ingressos deve estar entre R$1,00 e R$200</textoMensagem></mensagem><mensagem><tipoMensagem>A</tipoMensagem><codigoMensagem>A510</codigoMensagem><dataHoraInicio>2017-06-18 14:00:00</dataHoraInicio><textoMensagem>O PMI de cada categoria de ingressos deve estar entre R$1,00 e R$200</textoMensagem></mensagem></mensagens></statusRelatorioBilheteria>


SELECT TB_SALA.SAL_DESC, TB_MENSAGEM_ANCINE.MSA_TP_MSG, TB_BILHETERIA.* FROM TB_BILHETERIA 
JOIN TB_SALA ON TB_SALA.SAL_CD_ANCINE = TB_BILHETERIA.SAL_CD_ANCINE
LEFT JOIN TB_MENSAGEM_ANCINE ON TB_MENSAGEM_ANCINE.BIL_ID = TB_BILHETERIA.BIL_ID
LEFT JOIN TB_SESSAO_ANCINE ON TB_SESSAO_ANCINE.BIL_ID = TB_BILHETERIA.BIL_ID
WHERE TB_BILHETERIA.BIL_DIA_CIN = '2017-06-12'
ORDER BY TB_SALA.SAL_DESC, TB_SESSAO_ANCINE.SEA_DT_HR_INICIO




SELECT COUNT(*) FROM TB_MENSAGEM_ANCINE
SELECT * FROM TB_MENSAGEM_ANCINE
ORDER BY MSA_DT_MSG ASC

SELECT * FROM TB_BILHETERIA 
--WHERE BIL_ID = 30605
ORDER BY BIL_DT_ALT_STAT_PROT DESC

SELECT * FROM TB_SALA

SELECT * FROM TB_SESSAO_ANCINE WHERE BIL_ID = 30605

SELECT * FROM ##bil_prot_xml
SELECT GETDATE(), DATEADD(SECOND, 1, GETDATE()), * FROM ##bil_prot_xml

<statusRelatorioBilheteria><registroANCINEExibidor>32360</registroANCINEExibidor><registroANCINESala>5005459</registroANCINESala><diaCinematografico>2017-05-16</diaCinematografico><statusProtocolo>N</statusProtocolo><mensagens><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E043</codigoMensagem><textoMensagem>As retificações de relatórios só podem ser realizadas até 30 dias após o respectivo dia cinematográfico. Após esse prazo é necessário entrar em contato com a ANCINE e solicitar autorização para realizar esta retificação</textoMensagem></mensagem></mensagens></statusRelatorioBilheteria>

--<mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem>
--<mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem>
--<mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem>
--<mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem>
--</mensagens></statusRelatorioBilheteria>',1)

--SET @ProtocoloPorID = '<?xml version="1.0" encoding="UTF8" standalone="yes"?><statusRelatorioBilheteria><registroANCINEExibidor>32360</registroANCINEExibidor><registroANCINESala>5005461</registroANCINESala><diaCinematografico>2017-06-10</diaCinematografico><numeroProtocolo>5005461.1.10062017.003</numeroProtocolo><statusProtocolo>E</statusProtocolo><mensagens><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem></mensagens></statusRelatorioBilheteria>'

--SET @ProtocoloPorID = CONVERT(xml, N'<statusRelatorioBilheteria><registroANCINEExibidor>32360</registroANCINEExibidor><registroANCINESala>5005495</registroANCINESala><diaCinematografico>2017-04-11</diaCinematografico><numeroProtocolo>5005495.1.11042017.001</numeroProtocolo><statusProtocolo>E</statusProtocolo><mensagens><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem><mensagem><tipoMensagem>E</tipoMensagem><codigoMensagem>E411</codigoMensagem><dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio><textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem></mensagem></mensagens></statusRelatorioBilheteria>', 1) 

--SELECT @ProtocoloPorID 


SELECT * FROM TB_MENSAGEM_ANCINE

<statusRelatorioBilheteria>
	<registroANCINEExibidor>32360</registroANCINEExibidor>
	<registroANCINESala>5005463</registroANCINESala>
	<diaCinematografico>2017-05-16</diaCinematografico>
	<numeroProtocolo>5005463.1.16052017.001</numeroProtocolo>
	<statusProtocolo>V</statusProtocolo>
		<mensagens>
			<mensagem>
				<tipoMensagem>E</tipoMensagem>
				<codigoMensagem>E411</codigoMensagem>
				<dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio>
				<textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem>
			</mensagem>
			<mensagem>
				<tipoMensagem>E</tipoMensagem>
				<codigoMensagem>E411</codigoMensagem>
				<dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio>
				<textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem>
			</mensagem>
			<mensagem>
				<tipoMensagem>E</tipoMensagem>
				<codigoMensagem>E411</codigoMensagem>
				<dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio>
				<textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem>
			</mensagem>
			<mensagem>
				<tipoMensagem>E</tipoMensagem>
				<codigoMensagem>E411</codigoMensagem>
				<dataHoraInicio>2017-06-10 14:00:00</dataHoraInicio>
				<textoMensagem>Somatório de espectadores de cada categoria é maior que o número de assentos daquele tipo disponibilizados para a sessão</textoMensagem>
			</mensagem>
		</mensagens>
	</statusRelatorioBilheteria>