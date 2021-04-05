-- C�digo 1 � Criando o Banco de Dados MyDatabaseServiceBroker
Use Master
Go
 
/* 1 � Cria��o do banco de dados */
CREATE DATABASE MyDatabaseServiceBroker
Go
 
/* 2 � Ativa��o do recurso de Service Broker */
ALTER DATABASE MyDatabaseServiceBroker 
SET ENABLE_BROKER
Go
 
/* 3- Verifica��o do Status */
SELECT Name, is_broker_enabled 
FROM sys.databases
WHERE Name = 'MyDatabaseServiceBroker'
Go