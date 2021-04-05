/* Código 2 – Criando e Enviando a Mensagem */
USE MyDatabaseServiceBroker
GO
 
Declare @MyConversationHandle Uniqueidentifier
 
Begin Transaction
 
/* Inicia um diálogo entre os serviços da origem e destino */
 
BEGIN DIALOG  @MyConversationHandle
	FROM SERVICE    [sOrigem]
	TO SERVICE      'sDestino'
	ON CONTRACT     [cProcessaMensagens]
	WITH ENCRYPTION = OFF,
	LIFETIME = 600;
 
/* Declarando a Estrutura e Conteúdo da Mensagem */
Declare @MyMensagemServiceBroker XML
 
SET @MyMensagemServiceBroker = N'<!--?xml version=”1.0??-->
Minha mensagem
Olá esta é uma mensagem de teste no Service Broker';
 
 
/* Enviando uma mensagem no Diálogo */
SEND ON CONVERSATION @MyConversationHandle
MESSAGE TYPE [mtEnvioMensagem] (@MyMensagemServiceBroker)
Commit Transaction
