/* C�digo 2 � Criando e Enviando a Mensagem */
USE MyDatabaseServiceBroker
GO
 
Declare @MyConversationHandle Uniqueidentifier
 
Begin Transaction
 
/* Inicia um di�logo entre os servi�os da origem e destino */
 
BEGIN DIALOG  @MyConversationHandle
	FROM SERVICE    [sOrigem]
	TO SERVICE      'sDestino'
	ON CONTRACT     [cProcessaMensagens]
	WITH ENCRYPTION = OFF,
	LIFETIME = 600;
 
/* Declarando a Estrutura e Conte�do da Mensagem */
Declare @MyMensagemServiceBroker XML
 
SET @MyMensagemServiceBroker = N'<!--?xml version=�1.0??-->
Minha mensagem
Ol� esta � uma mensagem de teste no Service Broker';
 
 
/* Enviando uma mensagem no Di�logo */
SEND ON CONVERSATION @MyConversationHandle
MESSAGE TYPE [mtEnvioMensagem] (@MyMensagemServiceBroker)
Commit Transaction
