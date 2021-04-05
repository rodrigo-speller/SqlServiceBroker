/* Código 3 – Localizando – Mensagem */
USE MyDatabaseServiceBroker
GO

Select CAST(message_body as xml) from qDestino
