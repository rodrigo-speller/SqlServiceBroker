/* C�digo 4 � Cria��o dos Servi�os sOrigem e sDestino */
Use MyDatabaseServiceBroker
Go

CREATE SERVICE [sDestino] ON QUEUE [qDestino] ([cProcessaMensagens])
Go

CREATE SERVICE [sOrigem] ON QUEUE [qOrigem]
Go
