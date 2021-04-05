/* Código 2 – Realizando a Leitura e Recebimento de Dados */
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

/* Apresentando o Retorno da Mensagem */
SELECT @MyMessage_Body As MyMessage
 
/* Confirmando o Bloco de Transação */
Commit