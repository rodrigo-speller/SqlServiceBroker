/* Código 1 – Iniciando o Diálogo entre os Serviços */
USE MyDatabaseServiceBroker
GO

Declare @MyConversationHandle Uniqueidentifier

Begin Transaction

-- Iniciando um novo diálogo entre os serviços da sOrigem e sDestino –
BEGIN DIALOG  @MyConversationHandle 
	FROM SERVICE    [sOrigem]
	TO SERVICE      'sDestino'
	ON CONTRACT     [cProcessaMensagens]
	WITH ENCRYPTION = OFF,
	LIFETIME = 600;
