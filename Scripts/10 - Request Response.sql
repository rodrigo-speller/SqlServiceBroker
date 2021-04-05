/* C�digo 3 � Enviando Mensagem */
USE MyDatabaseServiceBroker
GO
 
Declare @MyConversationHandle Uniqueidentifier
 
Begin Transaction
 
/* Inicia um di�logo entre os servi�os da origem e destino */
BEGIN DIALOG @MyConversationHandle
	FROM SERVICE [sOrigem]
	TO SERVICE 'sDestino'
	ON CONTRACT [cProcessaMensagens]
	WITH ENCRYPTION=OFF,
	LIFETIME= 600;
 
/* Declarando a Estrutura e Conte�do da Mensagem */
Declare @MyMensagemServiceBroker XML
SET @MyMensagemServiceBroker = N'<!--?xml version=�1.0??-->
Minha segunda mensagem
Ol� esta � a segunda mensagem de teste no Service Broker
';
 
/* Enviando uma mensagem no Di�logo */
SEND ON CONVERSATION @MyConversationHandle
	MESSAGE TYPE [mtEnvioMensagem](@MyMensagemServiceBroker)
 
Commit Transaction
 
/* C�digo 4 � Respondendo a Mensagem � Interagindo com o Di�logo */
USE MyDatabaseServiceBroker
GO
 
Declare @MyConversationHandle UniqueIdentifier,
@MyMessage_Body XML,
@MyMessage_Type_Name sysname;
 
/* Iniciando o Bloco de Transa��o */
Begin Transaction;
 
/* Realizando o Recebimento da Mensagem */
RECEIVE TOP(1)
	@MyMessage_Type_Name = message_type_name,
	@MyConversationHandle = conversation_handle,
	@MyMessage_Body = message_body
	FROM [qDestino]
 
/* Verifica se a mensagem foi enviada atrav�s da Message Type � mtEnviomensagem */
 
if @MyMessage_Type_Name = N'mtEnvioMensagem'
Begin
    DECLARE @MySourceMessage XML
    SET @MySourceMessage = 'Retorno da Mensagem de Destino foi respondida para Origem.';
    SEND ON CONVERSATION @MyConversationHandle -- Interage no mesmo di�logo
		MESSAGE TYPE [mtRecebimentoMensagem](@MySourceMessage)
 
    /* Finaliza o di�logo encerrando a conversa��o */
    END CONVERSATION @MyConversationHandle
 
End

/* Finaliza o Bloco de Transa��o */
COMMIT Transaction
GO


RECEIVE Cast(message_body as xml) FROM [qDestino];
Go
RECEIVE Cast(message_body as xml) FROM [qOrigem];
Go