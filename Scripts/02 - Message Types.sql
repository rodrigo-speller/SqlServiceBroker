/* Código 1 – Criando os Tipos de Mensagens */
Use MyDatabaseServiceBroker
Go
 
CREATE MESSAGE TYPE [mtEnvioMensagem]
VALIDATION = WELL_FORMED_XML
Go
 
CREATE MESSAGE TYPE [mtRecebimentoMensagem]
VALIDATION = WELL_FORMED_XML
Go