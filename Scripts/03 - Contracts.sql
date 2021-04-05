/* Código 2 – Criando contrato e definido o Target e Initiator */
Use MyDatabaseServiceBroker
Go
 
CREATE CONTRACT [cProcessaMensagens] ( 
   [mtEnvioMensagem] SENT BY initiator,
   [mtRecebimentoMensagem] SENT BY target
);

Go
