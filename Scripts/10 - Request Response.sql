/* Código 3 – Enviando Mensagem */
USE MyDatabaseServiceBroker
GO
 
Declare @MyConversationHandle Uniqueidentifier
 
Begin Transaction
 
/* Inicia um diálogo entre os serviços da origem e destino */
BEGIN DIALOG @MyConversationHandle
	FROM SERVICE [sOrigem]
	TO SERVICE 'sDestino'
	ON CONTRACT [cProcessaMensagens]
	WITH ENCRYPTION=OFF,
	LIFETIME= 600;
 
/* Declarando a Estrutura e Conteúdo da Mensagem */
Declare @MyMensagemServiceBroker XML
SET @MyMensagemServiceBroker = N'<!--?xml version=”1.0??-->
Minha segunda mensagem
Olá esta é a segunda mensagem de teste no Service Broker
';
 
/* Enviando uma mensagem no Diálogo */
SEND ON CONVERSATION @MyConversationHandle
	MESSAGE TYPE [mtEnvioMensagem](@MyMensagemServiceBroker)
 
Commit Transaction
 
/* Código 4 – Respondendo a Mensagem – Interagindo com o Diálogo */
USE MyDatabaseServiceBroker
GO
 
Declare @MyConversationHandle UniqueIdentifier,
@MyMessage_Body XML,
@MyMessage_Type_Name sysname;
 
/* Iniciando o Bloco de Transação */
Begin Transaction;
 
/* Realizando o Recebimento da Mensagem */
RECEIVE TOP(1)
	@MyMessage_Type_Name = message_type_name,
	@MyConversationHandle = conversation_handle,
	@MyMessage_Body = message_body
	FROM [qDestino]
 
/* Verifica se a mensagem foi enviada através da Message Type – mtEnviomensagem */
 
if @MyMessage_Type_Name = N'mtEnvioMensagem'
Begin
    DECLARE @MySourceMessage XML
    SET @MySourceMessage = 'Retorno da Mensagem de Destino foi respondida para Origem.';
    SEND ON CONVERSATION @MyConversationHandle -- Interage no mesmo diálogo
		MESSAGE TYPE [mtRecebimentoMensagem](@MySourceMessage)
 
    /* Finaliza o diálogo encerrando a conversação */
    END CONVERSATION @MyConversationHandle
 
End

/* Finaliza o Bloco de Transação */
COMMIT Transaction
GO


RECEIVE Cast(message_body as xml) FROM [qDestino];
Go
RECEIVE Cast(message_body as xml) FROM [qOrigem];
Go