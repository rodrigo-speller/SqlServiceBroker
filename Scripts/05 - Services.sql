/* Código 4 – Criação dos Serviços sOrigem e sDestino */
Use MyDatabaseServiceBroker
Go

CREATE SERVICE [sDestino] ON QUEUE [qDestino] ([cProcessaMensagens])
Go

CREATE SERVICE [sOrigem] ON QUEUE [qOrigem]
Go
