/* C�digo 1 � Iniciando o Di�logo entre os Servi�os */
USE MyDatabaseServiceBroker
GO

Declare @MyConversationHandle Uniqueidentifier

Begin Transaction

-- Iniciando um novo di�logo entre os servi�os da sOrigem e sDestino �
BEGIN DIALOG� @MyConversationHandle 
	FROM SERVICE��� [sOrigem]
	TO SERVICE����� 'sDestino'
	ON CONTRACT���� [cProcessaMensagens]
	WITH ENCRYPTION = OFF,
	LIFETIME = 600;
