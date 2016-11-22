CREATE DATABASE  IF NOT EXISTS `pet_shop` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `pet_shop`;
-- MySQL dump 10.13  Distrib 5.5.52, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: pet_shop
-- ------------------------------------------------------
-- Server version	5.6.31-0ubuntu0.14.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anamnese`
--

DROP TABLE IF EXISTS `anamnese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anamnese` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `peso` int(11) DEFAULT NULL COMMENT 'Peso do animal em gramas, maior que 0',
  `tamanho` int(11) DEFAULT NULL COMMENT 'Tamanho do animal em centímetros, maior que 0',
  `temperatura` int(11) DEFAULT NULL COMMENT 'Temperatura do animal em graus, maior que 0',
  `servico_agendado_id` int(11) NOT NULL COMMENT 'Serviço (consulta) no qual a anamnese foi feita',
  `queixa` varchar(100) DEFAULT NULL,
  `tempo_evolucao` int(11) DEFAULT NULL,
  `tratamento` tinyint(1) DEFAULT NULL,
  `medicacao_continua` tinyint(1) DEFAULT NULL,
  `alimentacao` varchar(100) DEFAULT NULL,
  `fezes_normais` tinyint(1) DEFAULT NULL,
  `urina_normal` tinyint(1) DEFAULT NULL,
  `convulsao` tinyint(1) DEFAULT NULL,
  `desmaio` tinyint(1) DEFAULT NULL,
  `tosse` tinyint(1) DEFAULT NULL,
  `espirro` tinyint(1) DEFAULT NULL,
  `cansaco_facil` tinyint(1) DEFAULT NULL,
  `ambiente_vive` varchar(100) DEFAULT NULL,
  `contato_animais` tinyint(1) DEFAULT NULL,
  `acesso_rua` tinyint(1) DEFAULT NULL,
  `castrado` tinyint(1) DEFAULT NULL,
  `doencas_anteriores` varchar(100) DEFAULT NULL,
  `pulga` tinyint(1) DEFAULT NULL,
  `carrapato` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_anamnese_servico_agendado1_idx` (`servico_agendado_id`),
  CONSTRAINT `fk_anamnese_servico_agendado1` FOREIGN KEY (`servico_agendado_id`) REFERENCES `servico_agendado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anamnese`
--

LOCK TABLES `anamnese` WRITE;
/*!40000 ALTER TABLE `anamnese` DISABLE KEYS */;
INSERT INTO `anamnese` VALUES (1,10,26,22,3,NULL,5,0,0,'',1,1,0,0,1,1,1,'',1,0,1,'',1,0),(2,10,33,20,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `anamnese` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`anamnese_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`anamnese`
FOR EACH ROW
BEGIN
	DECLARE servico VARCHAR(50);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
	
    IF NEW.peso IS NOT NULL THEN
		IF (NEW.peso <= 0) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nPeso deve ser maior que 0 gramas.");
		END IF;
	END IF;
        
	IF NEW.tamanho IS NOT NULL THEN
		IF (NEW.tamanho <= 0) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nTamanho deve ser maior que 0 centímetros.");
		END IF;
	END IF;
	
	IF NEW.temperatura IS NOT NULL THEN
		IF (NEW.temperatura <= 0) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nTemperatura deve ser maior que 0 graus.");
		END IF;
	END IF;
    
    IF NEW.tempo_evolucao IS NOT NULL THEN
		IF (NEW.tempo_evolucao <= 0) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\Tempo de Evolução deve ser maior que 0 dias.");
		END IF;
	END IF;
        
	SELECT nome INTO servico FROM tipo_servico WHERE id = NEW.servico_agendado_id;
	IF(servico <> 'consulta') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nAnamnese não deve ser realizada fora de uma consulta.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`anamnese_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`anamnese`
FOR EACH ROW
BEGIN
	DECLARE servico VARCHAR(50);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
	
    IF NEW.peso IS NOT NULL THEN
		IF (NEW.peso <= 0) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nPeso deve ser maior que 0 gramas.");
		END IF;
	END IF;
        
	IF NEW.tamanho IS NOT NULL THEN
		IF (NEW.tamanho <= 0) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nTamanho deve ser maior que 0 centímetros.");
		END IF;
	END IF;
	
	IF NEW.temperatura IS NOT NULL THEN
		IF (NEW.temperatura <= 0) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nTemperatura deve ser maior que 0 graus.");
		END IF;
	END IF;
    
    IF NEW.tempo_evolucao IS NOT NULL THEN
		IF (NEW.tempo_evolucao <= 0) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\Tempo de Evolução deve ser maior que 0 dias.");
		END IF;
	END IF;
        
	SELECT nome INTO servico FROM tipo_servico WHERE id = NEW.servico_agendado_id;
	IF(servico <> 'consulta') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nAnamnese não deve ser realizada fora de uma consulta.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `animais_dia`
--

DROP TABLE IF EXISTS `animais_dia`;
/*!50001 DROP VIEW IF EXISTS `animais_dia`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `animais_dia` (
  `nome` tinyint NOT NULL,
  `data_hora` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Nome do animal',
  `sexo` char(1) NOT NULL COMMENT 'Sexo do Animal (''M'' ou ''F'')',
  `data_hora_cadastro` datetime NOT NULL COMMENT 'Controla o momento em que o animal foi cadastrado',
  `data_nascimento` datetime DEFAULT NULL COMMENT 'Data de nascimento do animal',
  `pessoa_tem_funcao_id` int(11) NOT NULL COMMENT 'Pessoa a qual este animal pertence',
  `raca_id` int(11) NOT NULL COMMENT 'Código de identificação da raça do animal',
  `porte_id` int(11) NOT NULL COMMENT 'Código de identificação do porte atula do animal',
  PRIMARY KEY (`id`),
  KEY `fk_animal_pessoa_tem_funcao1_idx` (`pessoa_tem_funcao_id`),
  KEY `fk_animal_raca1_idx` (`raca_id`),
  KEY `fk_animal_porte1_idx` (`porte_id`),
  CONSTRAINT `fk_animal_pessoa_tem_funcao1` FOREIGN KEY (`pessoa_tem_funcao_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_porte1` FOREIGN KEY (`porte_id`) REFERENCES `porte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_raca1` FOREIGN KEY (`raca_id`) REFERENCES `raca` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (1,'Meggy','F','2016-09-10 02:48:58','2009-05-09 00:00:00',1,154,4),(2,'Nina','F','2016-09-10 02:48:58','2013-05-11 00:00:00',2,163,3),(3,'Luna','F','2016-09-10 02:48:58','2015-12-21 00:00:00',2,192,2),(4,'Suzy','F','2016-09-10 02:48:58','2006-10-03 00:00:00',2,55,5),(5,'Pucca','F','2016-09-10 02:48:58','2006-10-03 00:00:00',2,55,5),(6,'Dolly','F','2016-09-10 02:48:58','2013-11-22 00:00:00',2,192,3),(7,'Ivie','F','2016-09-10 02:48:58','2010-02-27 00:00:00',2,146,5),(8,'Kika','F','2016-09-10 02:48:58','2007-03-07 00:00:00',2,55,3),(9,'Téo','M','2016-09-10 02:48:58','2014-07-13 00:00:00',2,97,3),(10,'CF','F','2016-09-10 02:48:58','2013-05-11 00:00:00',4,128,1),(11,'CM','M','2016-09-10 02:48:58','2013-05-11 00:00:00',4,128,1),(12,'Funny','M','2016-09-10 02:48:58','2013-05-11 00:00:00',5,17,5);
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`animal_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`animal`
FOR EACH ROW
BEGIN

	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE tipo_pessoa VARCHAR(50);
        
	SET invalid = 0;
	SET error_message = "";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nNome deve conter apenas letras.");
    END IF;
    
    
    IF(NEW.sexo <> 'M' AND NEW.sexo <> 'F') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nSexo deve ser M ou F.");
    END IF;
    
    IF(NEW.data_nascimento > NOW()) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nImpossível cadastrar data de nascimento no futuro.");
    END IF;
    
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id;
    IF(tipo_pessoa <> 'cliente' AND tipo_pessoa <> 'cliente-especial') THEN
		SET error_message = CONCAT(error_message, "\nPessoa deve ser cliente ou cliente-especial para ter um animal.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`animal_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`animal`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE tipo_pessoa VARCHAR(50);
        
	SET invalid = 0;
	SET error_message = "";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nNome deve conter apenas letras.");
    END IF;
    
    
    IF(NEW.sexo <> 'M' AND NEW.sexo <> 'F') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nSexo deve ser M ou F.");
    END IF;
    
    IF(NEW.data_nascimento > NOW()) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nImpossível cadastrar data de nascimento no futuro.");
    END IF;
    
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id;
    IF(tipo_pessoa <> 'cliente' AND tipo_pessoa <> 'cliente-especial') THEN
		SET error_message = CONCAT(error_message, "\nPessoa deve ser cliente ou cliente-especial para ter um animal.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `animal_tem_restricao`
--

DROP TABLE IF EXISTS `animal_tem_restricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal_tem_restricao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `restricao_id` int(11) NOT NULL COMMENT 'Relaciona o animal com a restrição cadastrada',
  `animal_id` int(11) NOT NULL COMMENT 'Código de identificação do animal',
  PRIMARY KEY (`id`),
  KEY `fk_animal_tem_restricao_restricao1_idx` (`restricao_id`),
  KEY `fk_animal_tem_restricao_animal1_idx` (`animal_id`),
  CONSTRAINT `fk_animal_tem_restricao_animal1` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_tem_restricao_restricao1` FOREIGN KEY (`restricao_id`) REFERENCES `restricao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal_tem_restricao`
--

LOCK TABLES `animal_tem_restricao` WRITE;
/*!40000 ALTER TABLE `animal_tem_restricao` DISABLE KEYS */;
INSERT INTO `animal_tem_restricao` VALUES (1,1,1),(2,1,2),(3,2,3),(4,3,4),(5,3,5),(6,2,6);
/*!40000 ALTER TABLE `animal_tem_restricao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aplicacao`
--

DROP TABLE IF EXISTS `aplicacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aplicacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `data_hora` datetime NOT NULL COMMENT 'Dia e horário da aplicação',
  `aplicado` tinyint(1) NOT NULL COMMENT 'Controle se já foi aplicada ou não',
  `dose` int(11) NOT NULL COMMENT 'Dose aplicada',
  `vacina_tem_lote_id` int(11) NOT NULL COMMENT 'Código de identificação da vacina aplicada',
  `servico_agendado_id` int(11) NOT NULL COMMENT 'Serviço associado (consulta)',
  PRIMARY KEY (`id`),
  KEY `fk_aplicacao_servico_agendado1_idx` (`servico_agendado_id`),
  KEY `fk_aplicacao_vacina_tem_lote1_idx` (`vacina_tem_lote_id`),
  CONSTRAINT `fk_aplicacao_servico_agendado1` FOREIGN KEY (`servico_agendado_id`) REFERENCES `servico_agendado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_aplicacao_vacina_tem_lote1` FOREIGN KEY (`vacina_tem_lote_id`) REFERENCES `vacina_tem_lote` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aplicacao`
--

LOCK TABLES `aplicacao` WRITE;
/*!40000 ALTER TABLE `aplicacao` DISABLE KEYS */;
INSERT INTO `aplicacao` VALUES (1,'2016-09-06 11:00:00',1,1,1,3),(2,'2016-09-15 11:00:00',0,2,2,3);
/*!40000 ALTER TABLE `aplicacao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`aplicacao_BEFORE_INSERT` 
BEFORE INSERT ON `aplicacao` 
FOR EACH ROW
BEGIN
DECLARE vencimento_data DATE;
	DECLARE servico VARCHAR(50);
    DECLARE money DECIMAL(10,2);
    DECLARE money_service DECIMAL(10,2);
    DECLARE quantity INT;
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
        
	SELECT nome INTO servico FROM tipo_servico WHERE id = NEW.servico_agendado_id;
	IF(servico <> 'consulta') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nVacina não pode ser aplicado fora de uma consulta.");
	END IF;
        
	SELECT l.vencimento, l.preco, vtl.quantidade
		INTO vencimento_data, money, quantity
        FROM vacina_tem_lote as vtl 
        INNER JOIN lote as l 
        ON vtl.lote_id = l.id
        WHERE vtl.id = NEW.vacina_tem_lote_id;
        
	IF (quantity = 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade de Vacinas insuficientes.");
	END IF;
        
	IF (vencimento_data < NOW()) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nVacina vencida não pode ser aplicada.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
    
    SELECT sa.preco INTO money_service FROM servico_agendado as sa WHERE sa.id = NEW.servico_agendado_id;
    SET money_service = money_service + money;
    SET quantity = quantity - 1;
    
    UPDATE servico_agendado as sa SET sa.preco = money_service WHERE sa.id = NEW.servico_agendado_id;
    UPDATE vacina_tem_lote as vtl SET vtl.quantidade = quantity WHERE vtl.id = NEW.vacina_tem_lote_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`aplicacao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`aplicacao`
FOR EACH ROW
BEGIN
	DECLARE vencimento_data DATE;
	DECLARE servico VARCHAR(50);
    DECLARE money DECIMAL(10,2);
    DECLARE money_service DECIMAL(10,2);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
        
	SELECT nome INTO servico FROM tipo_servico WHERE id = NEW.servico_agendado_id;
	IF(servico <> 'consulta') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nVacina não pode ser aplicado fora de uma consulta.");
	END IF;
        
	SELECT l.vencimento, l.preco
		INTO vencimento_data, money
        FROM vacina_tem_lote as vtl 
        INNER JOIN lote as l 
        ON vtl.lote_id = l.id
        WHERE vtl.id = NEW.vacina_tem_lote_id;
        
	IF (vencimento_data < NOW()) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nVacina vencida não pode ser aplicada.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`aplicacao_BEFORE_DELETE` 
BEFORE DELETE ON `aplicacao` 
FOR EACH ROW
BEGIN

	DECLARE money DECIMAL(10,2);
    DECLARE money_service DECIMAL(10,2);
	DECLARE quantity INT;
    
    SELECT l.preco, vtl.quantidade
		INTO money, quantity
        FROM vacina_tem_lote as vtl 
        INNER JOIN lote as l 
        ON vtl.lote_id = l.id
        WHERE vtl.id = OLD.vacina_tem_lote_id;

	
    SELECT sa.preco INTO money_service FROM servico_agendado as sa WHERE sa.id = OLD.servico_agendado_id;
    SET money_service = money_service - money;
    SET quantity = quantity + 1;
    
    UPDATE servico_agendado as sa SET sa.preco = money_service WHERE sa.id = OLD.servico_agendado_id;
    UPDATE vacina_tem_lote as vtl SET vtl.quantidade = quantity WHERE vtl.id = OLD.vacina_tem_lote_id;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `configuracao`
--

DROP TABLE IF EXISTS `configuracao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `quantidade_animais` int(11) NOT NULL DEFAULT '0' COMMENT 'Quantidade em unidades máxima de animais por período, a partir deste número todo agendamento será avisado para o usuário como ''overbooking''',
  `periodos_dia` int(11) NOT NULL DEFAULT '0' COMMENT 'Quantidade em unidades de períodos em um dia',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracao`
--

LOCK TABLES `configuracao` WRITE;
/*!40000 ALTER TABLE `configuracao` DISABLE KEYS */;
INSERT INTO `configuracao` VALUES (1,25,2);
/*!40000 ALTER TABLE `configuracao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`configuracao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`configuracao`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.quantidade_animais < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade de Animais não pode ser negativo.");
	END IF;
		
	IF (NEW.periodos_dia < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPeriodos por dia não pode ser negativo.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`configuracao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`configuracao`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.quantidade_animais < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade de Animais não pode ser negativo.");
	END IF;
		
	IF (NEW.periodos_dia < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPeriodos por dia não pode ser negativo.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `especie`
--

DROP TABLE IF EXISTS `especie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especie` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Nome da espécie',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especie`
--

LOCK TABLES `especie` WRITE;
/*!40000 ALTER TABLE `especie` DISABLE KEYS */;
INSERT INTO `especie` VALUES (1,'cachorro'),(2,'gato');
/*!40000 ALTER TABLE `especie` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`especie_BEFORE_INSERT` BEFORE INSERT ON `especie` FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.nome) THEN
		SET error_message = "\nEspécie deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`especie_BEFORE_UPDATE` BEFORE UPDATE ON `especie` FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.nome) THEN
		SET error_message = "\nEspécie deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `funcao`
--

DROP TABLE IF EXISTS `funcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Função da pessoa no sistema. Somente o administrador pode alterar\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcao`
--

LOCK TABLES `funcao` WRITE;
/*!40000 ALTER TABLE `funcao` DISABLE KEYS */;
INSERT INTO `funcao` VALUES (1,'cliente'),(2,'cliente-especial'),(3,'funcionario'),(4,'administrador'),(7,'F'),(8,'FF'),(9,'FFF'),(10,'S');
/*!40000 ALTER TABLE `funcao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`funcao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`funcao`
FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.nome) THEN
		SET error_message = "\nFunção deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`funcao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`funcao`
FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.nome) THEN
		SET error_message = "\nFunção deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `grupo_de_item`
--

DROP TABLE IF EXISTS `grupo_de_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_de_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Descrição da categoria',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_de_item`
--

LOCK TABLES `grupo_de_item` WRITE;
/*!40000 ALTER TABLE `grupo_de_item` DISABLE KEYS */;
INSERT INTO `grupo_de_item` VALUES (1,'Petisco'),(2,'Brinquedo Morder'),(3,'Roupa'),(4,'Brinquedo Pular');
/*!40000 ALTER TABLE `grupo_de_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(100) NOT NULL COMMENT 'Nome do produto',
  `preco` decimal(10,2) NOT NULL COMMENT 'Preço de compra do produto',
  `quantidade` int(11) NOT NULL COMMENT 'Quantidade unitária em estoque',
  `data_hora_cadastro` datetime NOT NULL COMMENT 'Controla o momento em que o produto foi cadastrado',
  `grupo_de_item_id` int(11) NOT NULL COMMENT 'Produto pertece à um grupo',
  PRIMARY KEY (`id`),
  KEY `fk_item_grupo_de_item1_idx` (`grupo_de_item_id`),
  CONSTRAINT `fk_item_grupo_de_item1` FOREIGN KEY (`grupo_de_item_id`) REFERENCES `grupo_de_item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Bolacha com Carne Pct 10un',23.00,2,'2016-09-10 03:30:17',1),(2,'Bolacha com Vegetais Pct 10un',21.00,3,'2016-09-10 03:30:17',1),(3,'Osso Pequeno',5.00,5,'2016-09-10 03:30:17',1),(4,'Osso Borracha',8.00,11,'2016-09-10 03:30:17',2),(5,'Roupa Flor Pequena',15.00,1,'2016-09-10 03:30:17',3),(6,'Roupa Bolinha Amarela Media ',25.00,3,'2016-09-10 03:30:17',3),(7,'Roupa Vermelha Grande',30.00,5,'2016-09-10 03:30:17',3),(8,'Roupa Verde Pequena',17.00,8,'2016-09-10 03:30:17',3),(9,'Bola Verde',3.00,32,'2016-09-10 03:30:17',4),(10,'Bola Vermelha com Espinhos',3.50,21,'2016-09-10 03:30:17',4),(11,'Bola Apito',4.50,12,'2016-09-10 03:30:17',4);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`item`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreco não pode ser negativo.");
	END IF;
		
	IF (NEW.quantidade < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade não pode ser negativa.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`item`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreco não pode ser negativo.");
	END IF;
		
	IF (NEW.quantidade < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade não pode ser negativa.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `item_de_venda`
--

DROP TABLE IF EXISTS `item_de_venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_de_venda` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `preco` decimal(10,2) NOT NULL COMMENT 'Valor em reais do produto. Preço > 0',
  `quantidade` int(11) NOT NULL COMMENT 'Quantidade pedida, em unidades',
  `item_id` int(11) NOT NULL COMMENT 'Produto associado com o item',
  `pedido_id` int(11) NOT NULL COMMENT 'Item de venda pertece à um pedido',
  PRIMARY KEY (`id`),
  KEY `fk_item_de_venda_item1_idx` (`item_id`),
  KEY `fk_item_de_venda_pedido1_idx` (`pedido_id`),
  CONSTRAINT `fk_item_de_venda_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_de_venda_pedido1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_de_venda`
--

LOCK TABLES `item_de_venda` WRITE;
/*!40000 ALTER TABLE `item_de_venda` DISABLE KEYS */;
INSERT INTO `item_de_venda` VALUES (1,10.00,2,3,1),(2,8.00,1,4,1),(3,4.50,1,11,1),(4,50.00,2,6,2),(5,45.00,3,5,2),(6,10.00,2,3,2),(8,10.00,1,1,9),(9,10.00,2,2,9),(10,10.00,3,3,9),(11,10.00,4,4,9);
/*!40000 ALTER TABLE `item_de_venda` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_de_venda_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`item_de_venda`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE money DECIMAL(10,2);
    DECLARE quantity INT;
    DECLARE item_name VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
	END IF;
        
	IF (NEW.quantidade < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade não pode ser negativa.");
	END IF;
    
    SELECT i.quantidade, i.nome INTO quantity, item_name FROM item i WHERE i.id = NEW.item_id;
    
    IF (NEW.quantidade > quantity) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade insuficiente para ");
        SET error_message = CONCAT(error_message, item_name);
        SET error_message = CONCAT(error_message, ".");
	END IF;
	
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
        
	SELECT p.valor INTO money FROM pedido p WHERE p.id = NEW.pedido_id;
	SET money = money + NEW.preco;
    SET quantity = quantity - NEW.quantidade;
	
	UPDATE pedido as p SET p.valor = money WHERE p.id = NEW.pedido_id;
    UPDATE item as i SET i.quantidade = quantity WHERE i.id = NEW.item_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_de_venda_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`item_de_venda`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE money DECIMAL(10,2);
    DECLARE quantity INT;
    DECLARE item_name VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
	END IF;
        
	IF (NEW.quantidade < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade não pode ser negativa.");
	END IF;
    
    SELECT i.quantidade, i.nome INTO quantity, item_name FROM item i WHERE i.id = NEW.item_id;
    
    IF ( (NEW.quantidade - OLD.quantidade) > quantity) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade insuficiente para ");
        SET error_message = CONCAT(error_message, item_name);
        SET error_message = CONCAT(error_message, ".");
	END IF;
	
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
        
	SELECT p.valor INTO money FROM pedido p WHERE p.id = NEW.pedido_id;
	SET money = money + NEW.preco;
    SET quantity = quantity - (NEW.quantidade - OLD.quantidade);
        
	UPDATE pedido as p SET p.valor = money WHERE p.id = NEW.pedido_id;
    UPDATE item as i SET i.quantidade = quantity WHERE i.id = NEW.item_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_de_venda_BEFORE_DELETE` 
BEFORE DELETE ON `item_de_venda` 
FOR EACH ROW
BEGIN
	DECLARE money DECIMAL(10,2);
    DECLARE quantity INT;
        
	SELECT i.quantidade INTO quantity FROM item i WHERE i.id = OLD.item_id;
	SET quantity = quantity + OLD.quantidade;
    
	SELECT p.valor INTO money FROM pedido p WHERE p.id = OLD.pedido_id;
	SET money = money - OLD.preco;
        
	UPDATE pedido as p SET p.valor = money WHERE p.id = OLD.pedido_id;
    UPDATE item as i SET i.quantidade = quantity WHERE i.id = OLD.item_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lembrete`
--

DROP TABLE IF EXISTS `lembrete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lembrete` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `descricao` varchar(200) NOT NULL COMMENT 'Descrição do lembrete',
  `data_hora` datetime NOT NULL COMMENT 'Data e Hora da atividade',
  `executado` varchar(45) NOT NULL COMMENT 'Controle se o lembrete já foi executado',
  `pessoa_id` int(9) NOT NULL COMMENT 'Pessao a qual este lembrete se destina',
  PRIMARY KEY (`id`),
  KEY `fk_lembrete_pessoa1_idx` (`pessoa_id`),
  CONSTRAINT `fk_lembrete_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lembrete`
--

LOCK TABLES `lembrete` WRITE;
/*!40000 ALTER TABLE `lembrete` DISABLE KEYS */;
INSERT INTO `lembrete` VALUES (2,'Confirmar Retorno Dolly(6)','2016-09-12 00:00:00','0',3),(3,'Retirar Lixo','2016-09-15 00:00:00','0',3),(4,'Reunião Sócios','2016-09-15 00:00:00','0',6),(5,'Confirmar Retorno Dolly(1)','2016-11-30 09:00:00','1',3);
/*!40000 ALTER TABLE `lembrete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mensagem` varchar(500) NOT NULL,
  `tabela` varchar(50) NOT NULL,
  `json` varchar(500) NOT NULL,
  `metodo` varchar(10) NOT NULL,
  `data_hora` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','pessoa','{u\'uf\': u\'PA\', u\'id\': 17}','POST','2016-11-04 00:48:20'),(2,'(1644, u\'Nenhuma informa\\xe7\\xe3o foi alterada\')','pessoa','{u\'bairro\': u\'Alameda\', u\'id\': 1}','PUT','2016-11-07 22:25:56'),(3,'(1644, u\'Nenhuma informa\\xe7\\xe3o foi alterada\')','pessoa','{u\'bairro\': u\'Alameda\', u\'id\': 1}','PUT','2016-11-07 22:27:26'),(4,'(1054, u\"Unknown column \'bairrp\' in \'field list\'\")','pessoa','{u\'bairro\': u\'Alameda\', u\'id\': 1}','PUT','2016-11-07 22:29:05'),(5,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','transacao','{}','POST','2016-11-08 08:52:02'),(6,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','servicoContratado','{u\'pessoa_tem_funcao\': 3, u\'preco\': 0, u\'transacao_id\': 7}','POST','2016-11-08 08:53:33'),(7,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'observacao\': u\'SERVICO URGENTE\', u\'recorrente\': 0, u\'executado\': 0, u\'data_hora\': u\'2016-11-11 09:00:00\', u\'servico_id\': 2}','POST','2016-11-08 08:57:31'),(8,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'observacao\': u\'SERVICO URGENTE\', u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'2016-11-11 09:00:00\', u\'servico_id\': 2}','POST','2016-11-08 08:57:54'),(9,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'observacao\': u\'SERVICO URGENTE\', u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'2016-11-15 09:00:00\', u\'servico_id\': 2}','POST','2016-11-08 08:58:23'),(10,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'observacao\': u\'SERVICO URGENTE\', u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'2016-11-15\', u\'servico_id\': 2}','POST','2016-11-08 09:01:31'),(11,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'observacao\': u\'SERVICO URGENTE\', u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'2016-11-15 09:00:00\', u\'servico_id\': 2}','POST','2016-11-08 09:03:50'),(12,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'2016-11-15 09:00:00\', u\'servico_id\': 2}','POST','2016-11-08 09:06:50'),(13,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'2016-11-15 09:00:00\', u\'servico_id\': 2}','POST','2016-11-08 09:09:35'),(14,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'2016-11-15 09:00:00\', u\'servico_id\': 2}','POST','2016-11-08 09:09:38'),(15,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'asdasd\', u\'servico_id\': 2}','POST','2016-11-08 09:10:49'),(16,'(1644, u\'data hora inv\\xe1lido!\')','servicoAgendado','{u\'animal_id\': 3, u\'servico_contratado_id\': 5, u\'pago\': 0, u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 34, u\'data_hora\': u\'2016-11-15 09:00:00\', u\'servico_id\': 2}','POST','2016-11-08 09:11:23'),(17,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','servicoAgendado','{}','POST','2016-11-08 09:34:12'),(18,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','servicoAgendado','{u\'animal_id\': 3, u\'pago\': 0, u\'recorrente\': 0, u\'executado\': 0, u\'preco\': 50, u\'servico_id\': 4, u\'servico_contratado\': 5, u\'pessoa_tem_funcao_funcionario_id\': 3}','POST','2016-11-08 23:20:24'),(19,'(1644, u\'\\nFun\\xe7\\xe3o deve conter apenas letras.\')','funcao','{u\'id\': 5, u\'nome\': u\'FUNCAO 2\'}','PUT','2016-11-19 21:28:04'),(20,'(1644, u\'\\nFun\\xe7\\xe3o deve conter apenas letras.\')','funcao','{u\'nome\': u\'FUNCAO 2\'}','POST','2016-11-19 21:30:27'),(21,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','funcao','{u\'nome\': u\'FUNCAO\'}','DELETE','2016-11-19 21:30:36'),(22,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','permissao','{u\'nome\': u\'MODULO2\'}','POST','2016-11-19 21:32:04'),(23,'(1644, u\'\\nM\\xf3dulo deve conter apenas letras.\')','permissao','{u\'modulo\': u\'MODULO2\'}','POST','2016-11-19 21:32:12'),(24,'(1644, u\'\\nM\\xf3dulo deve conter apenas letras.\')','permissao','{u\'modulo\': u\'MODULO2\', u\'id\': 5}','PUT','2016-11-19 21:32:36'),(25,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','redeSocial','{u\'modulo\': u\'NOVA REDE 2\', u\'id\': 5}','POST','2016-11-19 21:33:43'),(26,'(1644, u\'\\nNome deve conter apenas letras.\')','redeSocial','{u\'id\': 5, u\'nome\': u\'NOVA REDE 2\'}','POST','2016-11-19 21:33:48'),(27,'(1644, u\'Email j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'registro\': u\'12766576177\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'id\': 1, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': None, u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'email\': u\'andre@gmail.com\', u\'orgao_expedidor\': None}','POST','2016-11-19 21:50:39'),(28,'(1644, u\'Registro j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'registro\': u\'12766576177\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'id\': 1, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': None, u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'email\': u\'andre2@gmail.com\', u\'orgao_expedidor\': None}','POST','2016-11-19 21:51:05'),(29,'(1054, u\"Unknown column \'p_orgao_expedidor\' in \'field list\'\")','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'registro\': u\'89658888755\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'id\': 1, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': None, u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'email\': u\'andre2@gmail.com\', u\'orgao_expedidor\': None}','POST','2016-11-19 21:51:30'),(30,'(1644, u\'Email j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'registro\': u\'89658888755\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'email\': u\'andre2@gmail.com\', u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': None, u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'id\': 1, u\'orgao_expedidor\': None}','POST','2016-11-19 21:52:13'),(31,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'registro\': u\'89658888755\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': None, u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'id\': 1, u\'orgao_expedidor\': None}','POST','2016-11-19 21:52:21'),(32,'(1644, u\'Registro j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'registro\': u\'89658888755\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': None, u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'id\': 1, u\'orgao_expedidor\': None}','PUT','2016-11-19 21:53:45'),(33,'(1644, u\'RG j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': u\'496423630\', u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'id\': 1, u\'orgao_expedidor\': None}','PUT','2016-11-19 21:54:57'),(34,'(1644, u\'RG j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': u\'496423630\', u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'id\': 1, u\'orgao_expedidor\': None}','PUT','2016-11-19 22:05:47'),(35,'(1644, u\'RG j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': u\'496423633\', u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'id\': 1, u\'orgao_expedidor\': None}','PUT','2016-11-19 22:07:35'),(36,'(1644, u\'Func\\xe3o n\\xe3o cadastrada\')','funcao','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': u\'496423630\', u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'id\': 16, u\'orgao_expedidor\': None}','PUT','2016-11-19 22:11:06'),(37,'(1644, u\'RG j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'data_hora_cadastro\': u\'Sat, 10 Sep 2016 02:41:21 GMT\', u\'complemento\': u\'Apartamento 31\', u\'nome\': u\'Andre Cadamuro Garcia\', u\'bairro\': u\'Alameda\', u\'cidade\': u\'Ivaipor\\xe3\', u\'inscricao_estadual\': None, u\'logradouro\': u\'Rua Jo\\u015be Luis Lopez\', u\'numero\': 910, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'rg\': u\'496423630\', u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'id\': 16, u\'orgao_expedidor\': None}','PUT','2016-11-19 22:11:15'),(38,'(1054, u\"Unknown column \'p_pessoa_tem_funcao_id\' in \'where clause\'\")','pessoaTemRedeSocial','{u\'pessoa_id\': 4, u\'rede_social_id\': 2, u\'perfil\': u\'Cesar Santos\', u\'id\': 5}','PUT','2016-11-19 22:16:41'),(39,'(1054, u\"Unknown column \'p_pessoa_tem_funcao_id\' in \'where clause\'\")','pessoaTemRedeSocial','{u\'pessoa_id\': 4, u\'rede_social_id\': 2, u\'perfil\': u\'Cesar 992\', u\'id\': 5}','PUT','2016-11-19 22:16:45'),(40,'(1054, u\"Unknown column \'pessoa_tem_rede_social.pessoa_tem_funcao_id\' in \'where clause\'\")','pessoaTemRedeSocial','{u\'pessoa_id\': 4, u\'rede_social_id\': 2, u\'perfil\': u\'Cesar 992\', u\'id\': 5}','PUT','2016-11-19 22:18:33'),(41,'(1644, u\'Pessoa j\\xe1 possui Rede Social\')','pessoaTemRedeSocial','{u\'pessoa_id\': 4, u\'rede_social_id\': 2, u\'perfil\': u\'Cesar 992\', u\'id\': 5}','PUT','2016-11-19 22:19:14'),(42,'(1054, u\"Unknown column \'p_password\' in \'field list\'\")','pessoaTemFuncao','{u\'pessoa_id\': 16, u\'password\': u\'USER\', u\'funcao_id\': 2, u\'id\': 7}','PUT','2016-11-19 22:40:05'),(43,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','pessoaTemFuncao','{u\'pessoa_id\': 3, u\'id\': 1, u\'permissao_id\': 4}','POST','2016-11-19 22:42:20'),(44,'(1644, u\'Permiss\\xe3o j\\xe1 atribu\\xedda \\xe0 Pessoa\')','pessoaTemPermissao','{u\'pessoa_id\': 3, u\'id\': 1, u\'permissao_id\': 4}','POST','2016-11-19 22:42:55'),(45,'(1644, u\'Permiss\\xe3o j\\xe1 atribu\\xedda \\xe0 Pessoa\')','pessoaTemPermissao','{u\'pessoa_id\': 3, u\'id\': 1, u\'permissao_id\': 3}','POST','2016-11-19 22:43:03'),(46,'(1644, u\'Permiss\\xe3o j\\xe1 atribu\\xedda \\xe0 Pessoa\')','pessoaTemPermissao','{u\'pessoa_id\': 3, u\'id\': 1, u\'permissao_id\': 2}','POST','2016-11-19 22:43:07'),(47,'(1644, u\'Permiss\\xe3o j\\xe1 atribu\\xedda \\xe0 Pessoa\')','pessoaTemPermissao','{u\'pessoa_id\': 3, u\'id\': 1, u\'permissao_id\': 1}','POST','2016-11-19 22:43:10'),(48,'(1644, u\'Permiss\\xe3o n\\xe3o cadastrada\')','pessoaTemPermissao','{u\'pessoa_id\': 3, u\'id\': 1, u\'permissao_id\': 5}','POST','2016-11-19 22:43:13'),(49,'(1644, u\'Pessoa n\\xe3o possui Restri\\xe7\\xe3o\')','pessoaTemPermissao','{u\'pessoa_id\': 3, u\'id\': 4, u\'permissao_id\': 4}','PUT','2016-11-19 22:43:53'),(50,'(1644, u\'Esp\\xe9cie j\\xe1 cadastrada\')','especie','{u\'id\': 1, u\'nome\': u\'cachorro\'}','POST','2016-11-19 22:45:10'),(51,'(1644, u\'Esp\\xe9cie j\\xe1 cadastrada\')','especie','{u\'id\': 3, u\'nome\': u\'ave\'}','PUT','2016-11-19 22:45:22'),(52,'(1644, u\'\\nEsp\\xe9cie deve conter apenas letras.\')','especie','{u\'id\': 3, u\'nome\': u\'av2\'}','PUT','2016-11-19 22:45:28'),(53,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','porte','{u\'id\': 3, u\'nome\': u\'avew\'}','POST','2016-11-19 22:46:02'),(54,'(1644, u\'Porte j\\xe1 cadastrado\')','porte','{u\'tamanho_minimo\': 1, u\'nome\': u\'Mini\', u\'tamanho_maximo\': 28, u\'peso_maximo\': 6, u\'peso_minimo\': 0, u\'id\': 1}','POST','2016-11-19 22:46:13'),(55,'(1644, u\'\\nPeso m\\xednimo n\\xe3o pode ser menor ou igual a zero.\')','porte','{u\'tamanho_minimo\': 1, u\'nome\': u\'EXTRAG\', u\'tamanho_maximo\': 28, u\'peso_maximo\': 6, u\'peso_minimo\': 0, u\'id\': 1}','POST','2016-11-19 22:46:18'),(56,'(1644, u\'Porte j\\xe1 cadastrado\')','porte','{u\'tamanho_minimo\': 1, u\'nome\': u\'EXTRAG\', u\'tamanho_maximo\': 28, u\'peso_maximo\': 6, u\'peso_minimo\': 3, u\'id\': 12}','PUT','2016-11-19 22:46:34'),(57,'(1109, u\"Unknown table \'OLD\' in field list\")','porte','{u\'tamanho_minimo\': 1, u\'nome\': u\'EXTRAG\', u\'tamanho_maximo\': 28, u\'peso_maximo\': 6, u\'peso_minimo\': 3, u\'id\': 12}','PUT','2016-11-19 22:48:53'),(58,'(1644, u\'Ra\\xe7a j\\xe1 cadastrada\')','raca','{u\'especie_id\': 4, u\'porte_id\': 2, u\'nome\': u\'Chihuahua\'}','POST','2016-11-19 22:50:43'),(59,'(1644, u\'Esp\\xe9cie n\\xe3o cadastrada\')','raca','{u\'especie_id\': 4, u\'porte_id\': 2, u\'nome\': u\'Chihuahuauaua\'}','POST','2016-11-19 22:50:52'),(60,'(1644, u\'Ra\\xe7a j\\xe1 cadastrada\')','raca','{u\'especie_id\': 2, u\'id\': 193, u\'porte_id\': 2, u\'nome\': u\'Chihuahuauaua\'}','PUT','2016-11-19 22:51:07'),(61,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','raca','{u\'id\': 5, u\'descricao\': None, u\'nome\': u\'Alergia a Shampoo Vermelho ssssss\'}','POST','2016-11-19 22:51:58'),(62,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','raca','{u\'id\': 5, u\'descricao\': u\'\', u\'nome\': u\'Alergia a Shampoo Vermelho ssssss\'}','POST','2016-11-19 22:52:05'),(63,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','raca','{u\'id\': 5, u\'descricao\': u\'\', u\'nome\': u\'Alergia a Shampoo Vermelho ssssss\'}','POST','2016-11-19 22:53:06'),(64,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','raca','{u\'id\': 5, u\'descricao\': None, u\'nome\': u\'Alergia a Shampoo Vermelho ssssss\'}','POST','2016-11-19 22:54:09'),(65,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','raca','{u\'descricao\': None, u\'nome\': u\'Alergia a Shampoo Vermelho ssssss\'}','POST','2016-11-19 22:54:20'),(66,'(1644, u\'Restri\\xe7\\xe3o n\\xe3o cadastrada\')','animalTemRestricao','{u\'animal_id\': 2, u\'restricao_id\': 3, u\'id\': 7}','PUT','2016-11-19 23:00:32'),(67,'(1644, u\'Restri\\xe7\\xe3o n\\xe3o cadastrada\')','animalTemRestricao','{u\'animal_id\': 2, u\'restricao_id\': 4, u\'id\': 7}','PUT','2016-11-19 23:01:34'),(68,'(1644, u\'Servico j\\xe1 cadastrado\')','servico','{u\'id\': 11, u\'nome\': u\'Taxa GRATIS\'}','POST','2016-11-19 23:07:39'),(69,'(1644, u\'Servi\\xe7o j\\xe1 cadastrado\')','servico','{u\'id\': 11, u\'nome\': u\'Taxa GRATI 2S\'}','PUT','2016-11-19 23:07:51'),(70,'(1644, u\'Servi\\xe7o n\\xe3o cadastrado\')','servico','{u\'id\': 13, u\'nome\': u\'Taxa GRATI 2\'}','DELETE','2016-11-19 23:08:10'),(71,'(1644, u\'Servi\\xe7o j\\xe1 atribu\\xeddo \\xe0 Porte\')','servicoTemPorte','{u\'preco\': 0, u\'porte_id\': 7, u\'servico_id\': 3}','POST','2016-11-19 23:09:17'),(72,'(1644, u\'Servi\\xe7o j\\xe1 atribu\\xeddo \\xe0 Porte\')','servicoTemPorte','{u\'preco\': 0, u\'porte_id\': 9, u\'servico_id\': 3}','POST','2016-11-19 23:09:23'),(73,'(1644, u\'Servi\\xe7o j\\xe1 atribu\\xeddo \\xe0 Porte\')','servicoTemPorte','{u\'preco\': 0, u\'porte_id\': 10, u\'servico_id\': 3}','POST','2016-11-19 23:09:26'),(74,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','servicoTemPorte','{u\'preco\': 10, u\'porte_id\': 11, u\'servico_id\': 3}','PUT','2016-11-19 23:09:46'),(75,'(1644, u\'Lote j\\xe1 est\\xe1 cadastrado\')','lote','{u\'vencimento\': u\'2016-01-01\', u\'preco\': 22, u\'id\': 2, u\'numero\': u\'F423423\'}','POST','2016-11-20 09:24:05'),(76,'(1644, u\'\\nVencimento n\\xe3o pode ser no passado.\')','lote','{u\'vencimento\': u\'2016-01-01\', u\'preco\': 22, u\'id\': 2, u\'numero\': u\'FGDGDG\'}','POST','2016-11-20 09:24:12'),(77,'(1644, u\'Lote n\\xe3o cadastrado\')','lote','{u\'vencimento\': u\'2017-01-01\', u\'preco\': 22, u\'id\': 4, u\'numero\': u\'FHAHDUASHDU\'}','DELETE','2016-11-20 09:28:23'),(78,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','vacina','{u\'total_doses\': 54, u\'nome\': u\'V9\', u\'id\': 1, u\'intervalo\': 1}','POST','2016-11-20 09:28:53'),(79,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','vacina','{u\'total_doses\': 54, u\'nome\': u\'V9\', u\'id\': 1, u\'intervalo\': 1}','POST','2016-11-20 09:29:07'),(80,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','vacina','{u\'nome\': u\'V9\', u\'doses\': 54, u\'id\': 1, u\'intervalo\': 1}','POST','2016-11-20 09:29:49'),(81,'(1644, u\'Vacina j\\xe1 cadastrada\')','vacina','{u\'dose\': 54, u\'nome\': u\'V9\', u\'id\': 3, u\'intervalo\': 1}','PUT','2016-11-20 09:30:08'),(82,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','vacinaTemLote','{u\'lot_id\': 2, u\'quantidade\': 10, u\'id\': 1, u\'vacina_id\': 1}','POST','2016-11-20 09:38:06'),(83,'(1644, u\'Lote j\\xe1 atribu\\xeddo \\xe0 Vacina\')','vacinaTemLote','{u\'vacina_id\': 1, u\'quantidade\': 10, u\'id\': 1, u\'lote_id\': 2}','POST','2016-11-20 09:38:31'),(84,'(1644, u\'Lote n\\xe3o cadastrada\')','vacinaTemLote','{u\'vacina_id\': 1, u\'quantidade\': 10, u\'id\': 1, u\'lote_id\': 1}','POST','2016-11-20 09:38:37'),(85,'(1451, u\'Cannot delete or update a parent row: a foreign key constraint fails (`pet_shop`.`aplicacao`, CONSTRAINT `fk_aplicacao_vacina_tem_lote1` FOREIGN KEY (`vacina_tem_lote_id`) REFERENCES `vacina_tem_lote` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION)\')','vacinaTemLote','{u\'quantidade\': 10, u\'id\': 2}','DELETE','2016-11-20 09:39:44'),(86,'(1054, u\"Unknown column \'vtl.quantity\' in \'field list\'\")','aplicacao','{u\'aplicado\': False, u\'vacina_tem_lote_id\': 1, u\'servico_agendado_id\': 3, u\'data_hora\': u\'2016-11-21\', u\'dose\': 1}','POST','2016-11-20 09:43:52'),(87,'(1644, u\'\\nQuantidade n\\xe3o pode ser negativa.\')','vacinaTemLote','{u\'quantidade\': -1, u\'id\': 1}','PUT','2016-11-20 09:45:57'),(88,'(1644, u\'\\nQuantidade de vacina insuficiente em lote.\')','aplicacao','{u\'aplicado\': False, u\'vacina_tem_lote_id\': 1, u\'servico_agendado_id\': 3, u\'data_hora\': u\'2016-11-21\', u\'dose\': 1}','POST','2016-11-20 09:46:01'),(89,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','aplicacao','{u\'aplicado\': False, u\'data_hora\': u\'2016-11-10\'}','PUT','2016-11-20 09:46:44'),(90,'(1054, u\"Unknown column \'p_vacina_id\' in \'field list\'\")','aplicacao','{u\'aplicado\': False, u\'id\': 3, u\'data_hora\': u\'2016-11-10\'}','PUT','2016-11-20 09:47:04'),(91,'(1054, u\"Unknown column \'sc.id\' in \'where clause\'\")','aplicacao','{u\'aplicado\': True, u\'id\': 3, u\'data_hora\': u\'2016-11-10\'}','DELETE','2016-11-20 09:48:16'),(92,'(1054, u\"Unknown column \'vtl.quantity\' in \'field list\'\")','aplicacao','{u\'aplicado\': True, u\'id\': 3, u\'data_hora\': u\'2016-11-10\'}','DELETE','2016-11-20 09:49:48'),(93,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','aplicacao','{u\'aplicado\': True, u\'vacina_tem_lote_id\': 1, u\'servico_agendado_id\': 25, u\'id\': 3, u\'data_hora\': u\'2016-11-10\'}','POST','2016-11-20 09:51:10'),(94,'(1644, u\'\\nVacina n\\xe3o pode ser aplicado fora de uma consulta.\')','aplicacao','{u\'aplicado\': True, u\'vacina_tem_lote_id\': 1, u\'servico_agendado_id\': 25, u\'dose\': 1, u\'data_hora\': u\'2016-11-10\', u\'id\': 3}','POST','2016-11-20 09:51:40'),(95,'(1644, u\'Aplica\\xe7\\xe3o n\\xe3o cadastrada\')','aplicacao','{u\'aplicado\': True, u\'vacina_tem_lote_id\': 1, u\'servico_agendado_id\': 3, u\'dose\': 1, u\'data_hora\': u\'2016-11-10\', u\'id\': 3}','DELETE','2016-11-20 09:53:30'),(96,'(1644, u\'Aplica\\xe7\\xe3o n\\xe3o cadastrada\')','aplicacao','{u\'aplicado\': True, u\'vacina_tem_lote_id\': 1, u\'servico_agendado_id\': 3, u\'dose\': 1, u\'data_hora\': u\'2016-11-10\', u\'id\': 4}','DELETE','2016-11-20 10:12:55'),(97,'(1644, u\'\\nQuantidade de Vacinas n\\xe3o suficientes.\')','aplicacao','{u\'aplicado\': True, u\'vacina_tem_lote_id\': 1, u\'servico_agendado_id\': 3, u\'dose\': 1, u\'data_hora\': u\'2016-11-10\', u\'id\': 4}','POST','2016-11-20 10:13:09'),(98,'(1644, u\'Aplica\\xe7\\xe3o n\\xe3o cadastrada\')','aplicacao','{u\'aplicado\': True, u\'vacina_tem_lote_id\': 1, u\'servico_agendado_id\': 3, u\'dose\': 1, u\'data_hora\': u\'2016-11-10\', u\'id\': 7}','DELETE','2016-11-20 10:33:56'),(99,'(1318, u\'Incorrect number of arguments for PROCEDURE pet_shop.insAnamnese; expected 23, got 22\')','anamnese','{u\'cansaco_facil\': False, u\'carrapato\': False, u\'tosse\': True, u\'acesso_rua\': False, u\'queixa\': u\'\', u\'fezes_normais\': True, u\'doencas_anteriores\': u\'\', u\'temperatura\': 22, u\'espirro\': True, u\'alimentacao\': u\'\', u\'pulga\': True, u\'id\': 1, u\'urina_normal\': True, u\'tratamento\': False, u\'convulsao\': False, u\'servico_agendado_id\': 3, u\'ambiente_vive\': u\'\', u\'medicacao_continua\': False, u\'tempo_evolucao\': 5, u\'castrado\': True, u\'tamanho\': 26, u\'peso\': 10, u\'desmaio\': False, u\'contato_animais\': True}','POST','2016-11-20 10:56:38'),(100,'(1318, u\'Incorrect number of arguments for PROCEDURE pet_shop.insAnamnese; expected 23, got 22\')','anamnese','{u\'cansaco_facil\': False, u\'carrapato\': False, u\'tosse\': True, u\'acesso_rua\': False, u\'queixa\': u\'\', u\'fezes_normais\': True, u\'doencas_anteriores\': u\'\', u\'temperatura\': 22, u\'espirro\': True, u\'alimentacao\': u\'\', u\'pulga\': True, u\'id\': 1, u\'urina_normal\': True, u\'tratamento\': False, u\'convulsao\': False, u\'servico_agendado_id\': 3, u\'ambiente_vive\': u\'\', u\'medicacao_continua\': False, u\'tempo_evolucao\': 5, u\'castrado\': True, u\'tamanho\': 26, u\'peso\': 10, u\'desmaio\': False, u\'contato_animais\': True}','POST','2016-11-20 10:59:55'),(101,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','anamnese','{u\'cansaco_facil\': False, u\'carrapato\': False, u\'tosse\': True, u\'acesso_rua\': False, u\'queixa\': u\'\', u\'fezes_normais\': True, u\'doencas_anteriores\': u\'\', u\'temperatura\': 22, u\'espirro\': True, u\'alimentacao\': u\'\', u\'pulga\': True, u\'id\': 1, u\'urina_normal\': True, u\'tratamento\': False, u\'convulsao\': False, u\'servico_agendado_id\': 3, u\'ambiente_vive\': u\'\', u\'medicacao_continua\': False, u\'tempo_evolucao\': 5, u\'castrado\': True, u\'tamanho\': 26, u\'peso\': 10, u\'desmaio\': False, u\'contato_animais\': True}','POST','2016-11-20 11:00:03'),(102,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','anamnese','{u\'cansaco_facil\': False, u\'carrapato\': False, u\'tosse\': True, u\'acesso_rua\': False, u\'queixa\': u\'\', u\'fezes_normais\': True, u\'doencas_anteriores\': u\'\', u\'temperatura\': 22, u\'espirro\': True, u\'alimentacao\': u\'\', u\'pulga\': True, u\'id\': 1, u\'urina_normal\': True, u\'tratamento\': False, u\'convulsao\': False, u\'servico_agendado_id\': 3, u\'ambiente_vive\': u\'\', u\'medicacao_continua\': False, u\'tempo_evolucao\': 5, u\'castrado\': True, u\'tamanho\': 26, u\'peso\': 10, u\'desmaio\': False, u\'contato_animais\': True}','POST','2016-11-20 11:06:00'),(103,'(1644, u\'Grupo de Item j\\xe1 cadastrado\')','grupoDeItem','{u\'nome\': u\'Petisco\'}','POST','2016-11-20 22:57:03'),(104,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','grupoDeItem','{u\'nome\': u\'Petisco 3\'}','PUT','2016-11-20 22:57:17'),(105,'(1451, u\'Cannot delete or update a parent row: a foreign key constraint fails (`pet_shop`.`item_de_venda`, CONSTRAINT `fk_item_de_venda_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION)\')','item','{u\'quantidade\': 12, u\'grupo_de_item_id\': 2, u\'preco\': 4.5, u\'id\': 11, u\'nome\': u\'Bola Apito\'}','DELETE','2016-11-20 23:01:29'),(106,'(1644, u\'Item j\\xe1 cadastrado\')','item','{u\'quantidade\': 12, u\'grupo_de_item_id\': 2, u\'preco\': 4.5, u\'id\': 11, u\'nome\': u\'Bola Apito\'}','POST','2016-11-20 23:01:35'),(107,'(1644, u\'Item j\\xe1 cadastrado\')','item','{u\'quantidade\': 10, u\'grupo_de_item_id\': 2, u\'preco\': 4.5, u\'id\': 12, u\'nome\': u\'Bola Apito 2\'}','PUT','2016-11-20 23:02:19'),(108,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','itemDeVenda','{u\'item_id\': 3, u\'quantidade\': 200, u\'preco\': 10, u\'id\': 1}','POST','2016-11-20 23:03:26'),(109,'(1644, u\'\\nQuantidade insuficiente para Osso Pequeno.\')','itemDeVenda','{u\'item_id\': 3, u\'quantidade\': 200, u\'preco\': 10, u\'id\': 1, u\'pedido_id\': 2}','POST','2016-11-20 23:04:05'),(110,'(1048, u\"Column \'servico_tem_porte_id\' cannot be null\")','servicoAgendado','{u\'animal_id\': 2, u\'servico_contratado_id\': 1, u\'servico_id\': 10, u\'observacao\': u\'\', u\'recorrente\': False, u\'executado\': True, u\'preco\': 28, u\'data_hora\': u\'2016-11-22 10:00:00\', u\'pago\': True}','POST','2016-11-20 23:27:59'),(111,'(1048, u\"Column \'servico_tem_porte_id\' cannot be null\")','servicoAgendado','{u\'animal_id\': 2, u\'servico_contratado_id\': 1, u\'servico_id\': 8, u\'observacao\': u\'\', u\'recorrente\': False, u\'executado\': True, u\'preco\': 28, u\'data_hora\': u\'2016-11-22 10:00:00\', u\'pago\': True}','POST','2016-11-20 23:30:49'),(112,'(1054, u\"Unknown column \'servico_id\' in \'field list\'\")','servicoAgendado','{u\'animal_id\': 2, u\'servico_contratado_id\': 1, u\'servico_id\': 1, u\'observacao\': u\'\', u\'recorrente\': False, u\'executado\': True, u\'preco\': 28, u\'data_hora\': u\'2016-11-22 10:00:00\', u\'pago\': True, u\'id\': 26}','PUT','2016-11-20 23:31:33'),(113,'(1054, u\"Unknown column \'c_servico_tem_porte\' in \'field list\'\")','servicoAgendado','{u\'animal_id\': 2, u\'servico_contratado_id\': 1, u\'servico_id\': 1, u\'observacao\': u\'\', u\'recorrente\': False, u\'executado\': True, u\'preco\': 28, u\'data_hora\': u\'2016-11-22 10:00:00\', u\'pago\': True, u\'id\': 26}','PUT','2016-11-20 23:36:01'),(114,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','servicoContratado','{u\'valor\': 22, u\'pessoa_tem_funcao_cliente_id\': 1, u\'pessoa_tem_funcao_funcionario_id\': 3, u\'desconto\': 2}','DELETE','2016-11-20 23:41:16'),(115,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','servicoContratado','{u\'valor\': 22, u\'pessoa_tem_funcao_cliente_id\': 1, u\'pessoa_tem_funcao_funcionario_id\': 3, u\'desconto\': 2}','POST','2016-11-20 23:41:21'),(116,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','pedido','{u\'valor\': 22, u\'pessoa_tem_funcao_cliente_id\': 1, u\'pessoa_tem_funcao_funcionario_id\': 3, u\'desconto\': 2}','POST','2016-11-20 23:41:26'),(117,'(1644, u\'\\nDesconto n\\xe3o pode ser maior que valor.\')','pedido','{u\'valor\': 0, u\'pessoa_tem_funcao_cliente_id\': 1, u\'pessoa_tem_funcao_funcionario_id\': 3, u\'transacao_id\': 1, u\'desconto\': 2}','POST','2016-11-20 23:41:52'),(118,'(1644, u\'\\nDesconto n\\xe3o pode ser maior que valor.\')','pedido','{u\'valor\': 10, u\'pessoa_tem_funcao_cliente_id\': 1, u\'pessoa_tem_funcao_funcionario_id\': 3, u\'transacao_id\': 1, u\'desconto\': 11}','POST','2016-11-20 23:42:10'),(119,'(1644, u\'\\nValor n\\xe3o pode ser negativo.\')','transacao','{u\'id\': 66, u\'tipo\': u\'C\', u\'valor\': -1}','PUT','2016-11-20 23:46:55'),(120,'(1644, u\'Esp\\xe9cie j\\xe1 cadastrada\')','especie','{u\'nome\': u\'cachorro\'}','POST','2016-11-21 20:40:10'),(121,'(1644, u\'\\nPeso m\\xednimo n\\xe3o pode ser menor ou igual a zero.\')','porte','{u\'tamanho_minimo\': 1, u\'peso_maximo\': 100, u\'peso_minimo\': 0, u\'tamanho_maximo\': 100, u\'nome\': u\'TESTE\'}','POST','2016-11-21 20:43:03'),(122,'(1644, u\'Porte j\\xe1 cadastrado\')','porte','{u\'tamanho_minimo\': 1, u\'nome\': u\'TESTE\', u\'tamanho_maximo\': 1000, u\'peso_maximo\': 1000, u\'peso_minimo\': 1, u\'id\': 12}','POST','2016-11-21 20:43:16'),(123,'(1644, u\'Porte j\\xe1 cadastrado\')','porte','{u\'tamanho_minimo\': 1, u\'nome\': u\'Todos\', u\'tamanho_maximo\': 10, u\'peso_maximo\': 10, u\'peso_minimo\': 1, u\'id\': 12}','PUT','2016-11-21 20:44:08'),(124,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','raca','{u\'tamanho_minimo\': 1, u\'nome\': u\'Todos\', u\'tamanho_maximo\': 10, u\'peso_maximo\': 10, u\'peso_minimo\': 1, u\'id\': 12}','POST','2016-11-21 20:48:33'),(125,'(1644, u\'Ra\\xe7a j\\xe1 cadastrada\')','raca','{u\'especie_id\': 1, u\'id\': 193, u\'porte_id\': 2, u\'nome\': u\'Chihuahua\'}','PUT','2016-11-21 20:50:48'),(126,'(1644, u\'\\nRa\\xe7a deve conter apenas letras.\')','raca','{u\'especie_id\': 1, u\'id\': 193, u\'porte_id\': 2, u\'nome\': u\'TESTE 2\'}','PUT','2016-11-21 20:50:55'),(127,'(1644, u\'\\nFun\\xe7\\xe3o deve conter apenas letras.\')','funcao','{u\'nome\': u\'TESTE 2\'}','POST','2016-11-21 20:58:58'),(128,'(1644, u\'Fun\\xe7\\xe3o j\\xe1 cadastrada\')','funcao','{u\'id\': 11, u\'nome\': u\'Cliente\'}','PUT','2016-11-21 20:59:16'),(129,'(1644, u\'Grupo de Item j\\xe1 cadastrado\')','grupoDeItem','{u\'id\': 5, u\'nome\': u\'Roupa\'}','PUT','2016-11-21 21:01:07'),(130,'(1644, u\'Item j\\xe1 cadastrado\')','item','{u\'quantidade\': 2, u\'preco\': 23, u\'grupo_de_item_id\': 1, u\'nome\': u\'Bolacha com Carne Pct 10un\'}','POST','2016-11-21 21:03:45'),(131,'(1644, u\'Item j\\xe1 cadastrado\')','item','{u\'quantidade\': 2, u\'preco\': 23, u\'grupo_de_item_id\': 1, u\'nome\': u\'Bolacha com Carne Pct 10un 2\'}','POST','2016-11-21 21:03:52'),(132,'(1644, u\'Item j\\xe1 cadastrado\')','item','{u\'quantidade\': 3, u\'preco\': 23, u\'grupo_de_item_id\': 1, u\'nome\': u\'Bolacha com Carne Pct 10un 2\'}','POST','2016-11-21 21:03:57'),(133,'(1644, u\'Item j\\xe1 cadastrado\')','item','{u\'quantidade\': 3, u\'nome\': u\'Bolacha com Carne Pct 10un 2\', u\'preco\': 23, u\'id\': 12, u\'grupo_de_item_id\': 1}','POST','2016-11-21 21:04:34'),(134,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','item','{u\'vencimento\': u\'2016-11-11\', u\'preco\': 22, u\'numero\': u\'F423423\'}','DELETE','2016-11-21 21:06:10'),(135,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','item','{u\'vencimento\': u\'2016-11-11\', u\'preco\': 22, u\'numero\': u\'F423423\'}','POST','2016-11-21 21:06:14'),(136,'(1644, u\'Lote j\\xe1 est\\xe1 cadastrado\')','lote','{u\'vencimento\': u\'2016-11-11\', u\'preco\': 22, u\'numero\': u\'F423423\'}','POST','2016-11-21 21:06:23'),(137,'(1644, u\'\\nVencimento n\\xe3o pode ser no passado.\')','lote','{u\'vencimento\': u\'2016-11-11\', u\'preco\': 22, u\'numero\': u\'FGHJJL\'}','POST','2016-11-21 21:06:35'),(138,'(1054, u\"Unknown column \'nome\' in \'field list\'\")','lote','{u\'vencimento\': u\'2016-11-30\', u\'preco\': 22, u\'id\': 4, u\'numero\': u\'FGHJJL\'}','PUT','2016-11-21 21:06:51'),(139,'(1644, u\'Lote j\\xe1 cadastrado\')','lote','{u\'vencimento\': u\'2016-12-30\', u\'preco\': 22, u\'id\': 4, u\'numero\': u\'F423423\'}','PUT','2016-11-21 21:07:56'),(140,'(1644, u\'Necess\\xe1rio informar c\\xf3digo de registro\')','permissao','{u\'modulo\': u\'Venda\'}','DELETE','2016-11-21 21:08:27'),(141,'(1644, u\'Permiss\\xe3o j\\xe1 cadastrada\')','permissao','{u\'modulo\': u\'Venda\'}','POST','2016-11-21 21:08:30'),(142,'(1644, u\'\\nM\\xf3dulo deve conter apenas letras.\')','permissao','{u\'modulo\': u\'Venda 2\'}','POST','2016-11-21 21:08:32'),(143,'(1054, u\"Unknown column \'nome\' in \'field list\'\")','permissao','{u\'modulo\': u\'Compra Estoque\', u\'id\': 5}','PUT','2016-11-21 21:08:47'),(144,'(1644, u\'M\\xf3dulo j\\xe1 cadastrado\')','permissao','{u\'modulo\': u\'Cadastro\', u\'id\': 5}','PUT','2016-11-21 21:09:22'),(145,'(1644, u\'Vacina n\\xe3o possui cadastro\')','vacina','{u\'modulo\': u\'Cadastro\', u\'id\': 5}','DELETE','2016-11-21 21:09:43'),(146,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','vacina','{u\'total_doses\': 10, u\'nome\': u\'Gripe Canina\', u\'intervalo\': 36}','POST','2016-11-21 21:10:12'),(147,'(1644, u\'Vacina j\\xe1 cadastrada\')','vacina','{u\'dose\': 10, u\'nome\': u\'Gripe Canina\', u\'intervalo\': 36}','POST','2016-11-21 21:11:37'),(148,'(1644, u\'Rede Social j\\xe1 cadastrada\')','redeSocial','{u\'nome\': u\'WhatsApp\'}','POST','2016-11-21 21:12:41'),(149,'(1644, u\'Rede Social j\\xe1 cadastrada\')','redeSocial','{u\'id\': 4, u\'nome\': u\'Facebook\'}','PUT','2016-11-21 21:13:06'),(150,'(1644, u\'Email j\\xe1 est\\xe1 sendo utilizado por outra pessoa\')','pessoa','{u\'registro\': u\'32126366880\', u\'complemento\': u\'Apartamento\\xe1\\xe0\\xc9\\xc9\\xc8 31\', u\'nome\': u\'Andr\\xe9 Cadamuro Garcia\', u\'bairro\': u\'Alam\\xcada\', u\'cidade\': u\'Ivaipor\\xe3\', u\'logradouro\': u\'Rua Jo?e Luis Lopez\', u\'numero\': 910, u\'id\': 17, u\'ponto_de_referencia\': u\'Farm\\xe1cia\', u\'cep\': u\'33009440\', u\'pais\': u\'Brasil\', u\'uf\': u\'PR\', u\'estado\': u\'Paran\\xe1\', u\'email\': u\'andre22231@gmail.com\'}','PUT','2016-11-21 21:15:16'),(151,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','servicoAgendado','{u\'animal_id\': 2, u\'recorrente\': False, u\'executado\': False, u\'preco\': 28, u\'data_hora\': u\'Tue, 06 Sep 2016 09:00:00 GMT\', u\'pago\': False, u\'cancelado\': False, u\'servico__id\': 8, u\'servico_contratado\': 1, u\'pessoa_tem_funcao_funcionario_id\': 3}','POST','2016-11-21 21:43:29'),(152,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','servicoAgendado','{u\'animal_id\': 2, u\'recorrente\': False, u\'executado\': False, u\'preco\': 28, u\'data_hora\': u\'2016-11-30 09:00:00\', u\'pago\': False, u\'cancelado\': False, u\'servico__id\': 8, u\'servico_contratado\': 1, u\'pessoa_tem_funcao_funcionario_id\': 3}','POST','2016-11-21 21:43:44'),(153,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','servicoAgendado','{u\'animal_id\': 2, u\'servico_contratado_id\': 1, u\'recorrente\': False, u\'executado\': False, u\'preco\': 28, u\'data_hora\': u\'2016-11-30 09:00:00\', u\'pago\': False, u\'cancelado\': False, u\'servico__id\': 8, u\'pessoa_tem_funcao_funcionario_id\': 3}','POST','2016-11-21 21:44:04'),(154,'(1644, u\'Imposs\\xedvel inserir campo nulo\')','servicoAgendado','{u\'animal_id\': 2, u\'servico_contratado_id\': 1, u\'recorrente\': False, u\'executado\': False, u\'preco\': 28, u\'data_hora\': u\'2016-11-30 09:00:00\', u\'pago\': False, u\'cancelado\': False, u\'servico__id\': 8}','POST','2016-11-21 21:44:40'),(155,'(1048, u\"Column \'servico_tem_porte_id\' cannot be null\")','servicoAgendado','{u\'animal_id\': 2, u\'servico_contratado_id\': 1, u\'servico_id\': 8, u\'recorrente\': False, u\'executado\': False, u\'preco\': 28, u\'data_hora\': u\'2016-11-30 09:00:00\', u\'pago\': False, u\'cancelado\': False}','POST','2016-11-21 21:44:47');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote`
--

DROP TABLE IF EXISTS `lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lote` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `numero` varchar(50) NOT NULL COMMENT 'Número do lote cadastrado',
  `vencimento` date NOT NULL COMMENT 'Data de Vencimento deste lote',
  `preco` decimal(10,2) NOT NULL COMMENT 'Preço base à ser vendido deste lote',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote`
--

LOCK TABLES `lote` WRITE;
/*!40000 ALTER TABLE `lote` DISABLE KEYS */;
INSERT INTO `lote` VALUES (2,'F423423','2016-12-23',22.00),(3,'G421615','2028-07-11',71.00);
/*!40000 ALTER TABLE `lote` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`lote_BEFORE_INSERT` BEFORE INSERT ON `lote` FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
    
	SET invalid = 0;
	SET error_message = "";
    
    IF (NEW.vencimento <= NOW()) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nVencimento não pode ser no passado.");
    END IF;
    
    IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`lote_BEFORE_UPDATE` BEFORE UPDATE ON `lote` FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
    
	SET invalid = 0;
	SET error_message = "";
    
    IF (NEW.vencimento <= NOW()) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nVencimento não pode ser no passado.");
    END IF;
    
    IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `oauth`
--

DROP TABLE IF EXISTS `oauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `data_hora` datetime NOT NULL COMMENT 'Data e Hora que o token foi gerado',
  `vencimento` datetime NOT NULL COMMENT 'Data e hora em que o token se torna inválido',
  `token` varchar(100) NOT NULL COMMENT 'Token de autentificação',
  `refresh_token` varchar(100) DEFAULT NULL COMMENT 'Token para atualizar a autenticação',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth`
--

LOCK TABLES `oauth` WRITE;
/*!40000 ALTER TABLE `oauth` DISABLE KEYS */;
INSERT INTO `oauth` VALUES (1,'2016-11-13 22:17:28','2016-11-14 01:17:28','2ce896e5-196a-4c9f-aa8f-318f4a9c2327','f87d79ab-03fe-4d3e-9d67-9e72b2404e79'),(2,'2016-11-14 19:45:04','2016-11-14 22:45:04','249a1d3e-755b-47fe-84af-0e0d7409331c','46b74327-b9d2-48d2-9df9-6eed47bb1550'),(3,'2016-11-14 19:54:24','2016-11-14 22:54:24','eac17414-3771-473b-8f3a-f3190d3c7144','a27b7c23-8dcc-4299-a1a9-0636b7bd5062'),(4,'2016-11-14 19:57:31','2016-11-14 22:57:31','e4afde13-056f-488c-bfbe-2ef0c094a12d','0adadacf-bd58-43fd-9820-b6de54f264a5'),(5,'2016-11-14 20:12:44','2016-11-14 23:12:44','ae3a17f5-e2d4-4823-a222-f1af184963f5','625b6b26-97a4-437e-a310-51bf161d8b23'),(6,'2016-11-14 20:13:58','2016-11-14 23:13:58','995e67ca-d8aa-450c-9517-50f11d6bb22a','1104e092-af55-47f3-ae2d-a76013597136'),(7,'2016-11-14 20:14:30','2016-11-14 23:14:30','e9e26e7d-071b-4047-ad50-4d6ce0401533','f9694d64-e1f0-471a-9365-3d9c5bb95166'),(8,'2016-11-14 20:16:04','2016-11-14 23:16:04','71db9e3c-0e5e-401c-81c0-c53b494d93d4','0747d28a-a086-4c9c-9b1c-0f39f073735e'),(9,'2016-11-14 20:17:22','2016-11-14 23:17:22','7fc87d39-3cec-4e00-b1a4-01194f55c963','6bf133e5-825b-4a7b-b0ec-5940dbaff7e6'),(10,'2016-11-14 20:17:38','2016-11-14 23:17:38','4b975134-3276-4601-8c2f-635f6b3e6557','b03fea96-8848-45bf-aa54-cbc176eac689'),(11,'2016-11-14 20:28:35','2016-11-14 23:28:35','c9047374-98fe-4555-be3c-53eab2d2dc85','40fe7415-5236-4431-96c3-8c1753bba342'),(12,'2016-11-14 20:29:06','2016-11-14 23:29:06','c0b0ea7c-8784-4b87-b189-2fb46612e4ca','7d1c4a7d-2925-4da2-b7d3-c560b0edf35e'),(13,'2016-11-14 20:30:03','2016-11-14 23:30:03','46deacca-fb46-4951-a44d-585a6de5c555','3a7456d6-a4e6-44b5-b040-b7a3b93fc593'),(14,'2016-11-14 20:35:41','2016-11-14 23:35:41','889afd3a-bee9-49c2-bd96-8a75d24e9cd0','48698fd7-be90-4e4a-8fe7-1ab6d2307b28'),(15,'2016-11-14 20:36:31','2016-11-14 23:36:31','7abfa392-205f-45de-901d-796d33ac2ce3','6620e418-cd12-4351-bef2-ec629bf62fd2'),(16,'2016-11-14 20:36:38','2016-11-14 23:36:38','469c0c6a-4af1-43cd-abbf-ca32978a2c28','0fab639e-ece5-432a-8ecc-7036123d13b0'),(17,'2016-11-14 20:38:38','2016-11-14 23:38:38','4a7492f7-ac0e-437f-aaf3-15d15821e4e4','531cb199-16e1-4876-a4b3-c051c7c6ff0e'),(18,'2016-11-14 20:38:40','2016-11-14 23:38:40','1271fe14-560a-4ca7-9767-c979ffe2cfb8','ef159744-2b15-4fa2-a808-53201260cdb3'),(19,'2016-11-14 20:38:56','2016-11-14 23:38:56','543091c4-958e-4c55-bfb7-37dab091b04a','982ffdd5-ff6d-4df9-b56a-59f1fc0e7a40'),(20,'2016-11-14 20:39:14','2016-11-14 23:39:14','2b9d56d4-5efb-4fa5-b1ab-aa85bf5d281c','36b75385-8dbe-4b3c-8e9d-1ee982bde661'),(21,'2016-11-14 20:39:26','2016-11-14 23:39:26','067c6f93-b875-4c9f-bcaa-c08601a8ca43','1c4d37b3-5ca7-4ee0-9355-2b4bf2d55f57'),(22,'2016-11-14 20:39:46','2016-11-14 23:39:46','7c2ec47b-2f05-41bc-aafa-c14ec38c25dd','d1911310-f9e7-4263-a84c-9967019fbfaf'),(23,'2016-11-14 20:40:16','2016-11-14 23:40:16','b5b6d69b-3c72-482d-9599-baed3641fbf2','119861f9-7957-4039-bb80-dd0fdfa06dda'),(24,'2016-11-14 21:09:33','2016-11-15 00:09:33','ac4114c3-877b-4fb1-95ff-82a37067db3c','45c1a157-d949-4a82-b37d-9310774da597'),(25,'2016-11-14 21:09:37','2016-11-15 00:09:37','eaca25c5-a967-46ee-86fe-fdf660ff1371','4877d0f2-5330-45e7-be9c-7c986240d2f5'),(26,'2016-11-14 21:09:38','2016-11-15 00:09:38','09776284-0bd7-4add-bb50-c48bac46b7d7','a4d8690d-d8e2-4872-b54a-9a3f7672fc9e'),(27,'2016-11-14 21:10:45','2016-11-15 00:10:45','8b6a72f7-88b9-498e-a9e3-f49f4fa41d68','21b161f8-b7ed-4475-ac37-5f14b9e3c038'),(28,'2016-11-14 21:11:16','2016-11-15 00:11:16','8cf30ab8-7600-4ca7-9321-e82fa6078261','eb497f2e-9e9b-4d5c-aa36-f71a16fbf157'),(29,'2016-11-14 21:12:09','2016-11-15 00:12:09','2ef66179-98e1-4ff3-a3a9-88dfd0960369','7930cfa0-3170-4d00-8ecb-d57512e2c19b'),(30,'2016-11-14 21:40:11','2016-11-15 00:40:11','ff964dae-f823-4808-be80-a5223d53db85','3d9ace3b-4526-45f1-87f5-0820a645e449'),(31,'2016-11-14 21:41:13','2016-11-15 00:41:13','7dd2c07d-5085-47de-9f2d-4ab752c5d690','7950d358-9a04-4cf6-bb90-90fc36c95577'),(32,'2016-11-14 21:52:57','2016-11-15 00:52:57','b5a76087-7ad4-4366-82c5-b928b5050586','770f6044-3371-4a5c-a839-eb234239f7df'),(33,'2016-11-14 21:54:58','2016-11-15 00:54:58','9c457fde-8ec0-4c46-a497-dd249d8e50eb','b870bd7b-0ff9-4989-9d66-2e73e087d516'),(34,'2016-11-14 21:56:37','2016-11-15 00:56:37','2fb6c195-7d7d-4487-90df-6bf01a127436','de5ac784-4bf3-4ffe-b65f-0de02fed7e88'),(35,'2016-11-14 21:57:42','2016-11-15 00:57:42','a8fe50a8-a0cc-4d2e-9b72-0dfb454b4596','f95c14da-ef6a-40ea-821a-c0b2f28780af'),(36,'2016-11-14 21:59:26','2016-11-15 00:59:26','35c312c5-a45b-483a-b0bb-d56a74b9be69','b1b77ba1-43f4-4fda-9c1f-28a332cd1a86'),(37,'2016-11-14 22:03:08','2016-11-15 01:03:08','748b1ecd-390f-44e1-9dfd-71d8d0058476','66120106-acea-4adf-b6ea-c63a23107f8f'),(38,'2016-11-14 22:04:38','2016-11-15 01:04:38','984ff67a-80a8-4f81-93c1-720951201447','da8758d6-67b0-48fc-88eb-25fd26eb8614'),(39,'2016-11-14 22:04:52','2016-11-15 01:04:52','07f9fa21-f0f8-4c76-9881-7eba4e751d0d','f7125733-a337-4b75-a7f4-1e68d6af3621'),(40,'2016-11-14 22:05:13','2016-11-15 01:05:13','f747e3bd-4ed6-4702-8d40-6fdf866146de','704c0045-4682-465c-bf3b-c070400b92a0'),(41,'2016-11-14 23:11:36','2016-11-15 02:11:36','2e60240e-f168-43f6-bcd1-223d1aef4782','1e399d9a-4780-4e10-a6a2-2b680c3f74bc'),(42,'2016-11-14 23:14:28','2016-11-15 02:14:28','fe10d71d-e215-42b7-a994-552e67610695','e8f9bd3f-9deb-45db-9792-785897af3f75'),(43,'2016-11-14 23:19:09','2016-11-15 02:19:09','3cae5815-a017-4ccf-86ee-d08e6a06b29d','46182e4f-2ef9-446a-aad8-af449a7e5c7f'),(44,'2016-11-14 23:42:54','2016-11-15 02:42:54','6a206b63-f91c-495a-9247-031fa2c52e85','07d53495-e733-4870-8c46-d981eea911ba'),(45,'2016-11-15 00:02:36','2016-11-15 03:02:36','88603019-9077-4e49-bd70-96523ab420f5','82263e2b-3312-4c9e-8b9c-97370629a094'),(46,'2016-11-15 09:25:46','2016-11-15 12:25:46','e7d3ccea-810a-4fae-a5a0-2b07f83ba6d7','70559400-ca27-4fc4-a556-db7073699ec0');
/*!40000 ALTER TABLE `oauth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `valor` decimal(10,2) NOT NULL COMMENT 'Valor total do pedido',
  `desconto` decimal(10,2) NOT NULL COMMENT 'Desconto dado no total do pedido',
  `transacao_id` int(11) NOT NULL COMMENT 'Identificação da transação associada',
  `cliente_id` int(11) DEFAULT NULL COMMENT 'Cliente que realizou o pedido',
  `funcionario_id` int(11) NOT NULL COMMENT 'Funcionario que realizou o pedido',
  PRIMARY KEY (`id`),
  KEY `fk_pedido_transacao1_idx` (`transacao_id`),
  KEY `fk_pedido_pessoa_tem_funcao1_idx` (`cliente_id`),
  KEY `fk_pedido_pessoa_tem_funcao2_idx` (`funcionario_id`),
  CONSTRAINT `fk_pedido_pessoa_tem_funcao1` FOREIGN KEY (`cliente_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_pessoa_tem_funcao2` FOREIGN KEY (`funcionario_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_transacao1` FOREIGN KEY (`transacao_id`) REFERENCES `transacao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,22.00,2.00,3,1,3),(2,105.00,5.00,2,2,3),(3,0.00,0.00,7,1,3),(4,0.00,0.00,1,1,3),(5,10.00,0.00,1,1,3),(9,40.00,0.00,70,1,3);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pedido_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`pedido`
FOR EACH ROW
BEGIN
	DECLARE pessoa_cliente VARCHAR(50);
	DECLARE pessoa_funcionario VARCHAR(50);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	DECLARE money DECIMAL(10,2);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.valor < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nValor não pode ser negativo.");
	END IF;
        
	IF (NEW.desconto < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nDesconto não pode ser negativo.");
	END IF;
    
    IF (NEW.desconto > NEW.valor) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nDesconto não pode ser maior que valor.");
	END IF;
        
	SELECT nome INTO pessoa_funcionario FROM tipo_funcao WHERE id = NEW.funcionario_id;
	IF(pessoa_funcionario <> 'funcionario' AND pessoa_funcionario <> 'fornecedor') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nFuncionário inválido.");
	END IF;
        
	SELECT nome INTO pessoa_cliente FROM tipo_funcao WHERE id = NEW.cliente_id;
	IF(pessoa_cliente <> 'cliente' AND pessoa_cliente <> 'cliente-especial') THEN
		SET invalid = invalid + 1;
		SET error_message = CONCAT(error_message, "\nCliente inválido.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
        
	SELECT t.valor INTO money FROM transacao t WHERE t.id = NEW.transacao_id;
	SET money = money + (NEW.valor - NEW.desconto);
        
	UPDATE transacao as t SET t.valor = money WHERE t.id = NEW.transacao_id;
        
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pedido_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`pedido`
FOR EACH ROW
BEGIN
	DECLARE pessoa_cliente VARCHAR(50);
	DECLARE pessoa_funcionario VARCHAR(50);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	DECLARE money DECIMAL(10,2);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.valor < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nValor não pode ser negativo.");
	END IF;
        
	IF (NEW.desconto < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nDesconto não pode ser negativo.");
	END IF;
    
    IF (NEW.desconto > NEW.valor) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nDesconto não pode ser maior que valor.");
	END IF;
        
	SELECT nome INTO pessoa_funcionario FROM tipo_funcao WHERE id = NEW.funcionario_id;
	IF(pessoa_funcionario <> 'funcionario' AND pessoa_funcionario <> 'fornecedor') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nFuncionário inválido.");
	END IF;
        
	SELECT nome INTO pessoa_cliente FROM tipo_funcao WHERE id = NEW.cliente_id;
	IF(pessoa_cliente <> 'cliente' AND pessoa_cliente <> 'cliente-especial') THEN
		SET invalid = invalid + 1;
		SET error_message = CONCAT(error_message, "\nCliente inválido.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
        
	SELECT t.valor INTO money FROM transacao t WHERE t.id = NEW.transacao_id;
	SET money = money + ((NEW.valor - OLD.valor) - (NEW.desconto - OLD.desconto));
        
	UPDATE transacao as t SET t.valor = money WHERE t.id = NEW.transacao_id;
        
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pedido_BEFORE_DELETE` 
BEFORE DELETE ON `pedido` 
FOR EACH ROW
BEGIN
	DECLARE money DECIMAL(10,2);
    
    SELECT t.valor INTO money FROM transacao t WHERE t.id = OLD.transacao_id;
	SET money = money - (OLD.valor - OLD.desconto);
        
	UPDATE transacao as t SET t.valor = money WHERE t.id = OLD.transacao_id;
        

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `permissao`
--

DROP TABLE IF EXISTS `permissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `modulo` varchar(50) NOT NULL COMMENT 'Descrição da permissão, somente o administrador pode alterar',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissao`
--

LOCK TABLES `permissao` WRITE;
/*!40000 ALTER TABLE `permissao` DISABLE KEYS */;
INSERT INTO `permissao` VALUES (1,'Cadastro'),(2,'Venda'),(3,'Servico'),(4,'Consulta');
/*!40000 ALTER TABLE `permissao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`permissao_BEFORE_INSERT` BEFORE INSERT ON `permissao` FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.modulo) THEN
		SET error_message = "\nMódulo deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`permissao_BEFORE_UPDATE` BEFORE UPDATE ON `permissao` FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.modulo) THEN
		SET error_message = "\nMódulo deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(100) NOT NULL COMMENT 'Nome da pessoa',
  `data_hora_cadastro` datetime NOT NULL COMMENT 'Controla o momento em que o usuário foi cadastrado',
  `email` varchar(50) NOT NULL COMMENT 'Email de contato, que deve ser válidado',
  `registro` varchar(14) NOT NULL COMMENT 'Número de registro (CPF ou CNPJ), sem máscaras e apenas dígitos',
  `logradouro` varchar(100) NOT NULL COMMENT 'Logradouro em que a pessoa mora (Ex: Rua, Avenida)',
  `numero` int(11) NOT NULL COMMENT 'Número do local presente no logradouro',
  `complemento` varchar(50) DEFAULT NULL COMMENT 'Complemento do endereço',
  `cep` varchar(8) NOT NULL COMMENT 'CEP do endereço',
  `ponto_de_referencia` varchar(200) DEFAULT NULL COMMENT 'Ponto de referência para ajudar na busca do endereço',
  `cidade` varchar(100) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `rg` varchar(10) DEFAULT NULL,
  `inscricao_estadual` varchar(10) DEFAULT NULL,
  `orgao_expedidor` varchar(10) DEFAULT NULL,
  `bairro` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `registro_UNIQUE` (`registro`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (1,'Andre Cadamuro Garcia','2016-09-10 02:41:21','andre@gmail.com','12766576177','Rua Jo?e Luis Lopez',910,'Apartamento 31','33009440','Farmácia','Ivaiporã','Paraná','PR','Brasil','496423630',NULL,NULL,'Alameda'),(2,'Alessandra Bitobrovec','2016-09-10 02:41:21','alessandra@gmail.com','79488137134','Rua das Rosas',13,NULL,'76017920',NULL,'Candeal','Bahia','BA','Brasil',NULL,NULL,NULL,'Jardim'),(3,'Layon de Souza Onofre','2016-09-10 02:41:21','layon@gmail.com','85548552724','Rua Hermito Pascoal',1609,NULL,'16018900',NULL,'Juvenília','Minas Gerais','MG','Brasil',NULL,NULL,NULL,'Vila'),(4,'Cesar dos Santos','2016-09-10 02:41:21','cesar@gmail.com','14076987454','Rua Luterana dos Sétimos Dias',302,'Centro Comercial','01113892',NULL,'Conceição do Castelo','Espírito Santo','ES','Brasil',NULL,NULL,NULL,'Centro'),(5,'Aurelio Hiroshi Ozawa','2016-09-10 02:41:21','aurelio@gmail.com','99285047505','Rua Gerundina',1,NULL,'95768291',NULL,'Jumirim','São Paulo','SP','Brasil',NULL,NULL,NULL,'Parque'),(6,'Janaína Clock','2016-09-10 02:41:21','janaina@gmail.com','50976701081','Rua Estevan Suarez',1,NULL,'11293451',NULL,'Fernandópolis','São Paulo','SP','Brasil',NULL,NULL,NULL,'Centro'),(15,'NOVO NOVO FUNCIONARIO','2016-11-01 01:05:23','novo_func@gmail.com','43743576708','Logradouro',1234,'compl','77987000','Ponto','Mantenópolis','Espírito Santo','ES','Brasil',NULL,NULL,NULL,'Vila'),(16,'Andre Cadamuro Garcia','2016-11-19 21:52:05','andre2@gmail.com','89658888755','Rua Jo?e Luis Lopez',910,'Apartamento 31','33009440','Farmácia','Ivaiporã','Paraná','PR','Brasil','496423633',NULL,NULL,'Alameda');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_BEFORE_INSERT` 
BEFORE INSERT ON `pessoa` 
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nNome deve conter apenas letras.");
	END IF;
        
	IF NOT email_valido(NEW.email) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nEmail inválido.");
	END IF;
        
	IF NOT (cpf_valido(NEW.registro) OR cnpj_valido(NEW.registro)) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nRegistro inválido.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`pessoa`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nNome deve conter apenas letras.");
	END IF;
        
	IF NOT email_valido(NEW.email) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nEmail inválido.");
	END IF;
        
	IF NOT (cpf_valido(NEW.registro) OR cnpj_valido(NEW.registro)) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nRegistro inválido.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pessoa_tem_funcao`
--

DROP TABLE IF EXISTS `pessoa_tem_funcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa_tem_funcao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `pessoa_id` int(11) NOT NULL COMMENT 'Relaciona uma pessoa à uma função, como cliente ou funcionário',
  `funcao_id` int(11) NOT NULL COMMENT 'Função da pessoa',
  `oauth_id` int(11) DEFAULT NULL COMMENT 'Código da autentificação atual desta pessoa',
  `password` varchar(100) DEFAULT NULL COMMENT 'Password desta pessoa criptografada',
  PRIMARY KEY (`id`),
  KEY `fk_pessoa_has_funcao_funcao1_idx` (`funcao_id`),
  KEY `fk_pessoa_has_funcao_pessoa1_idx` (`pessoa_id`),
  KEY `fk_oauth1_idx` (`oauth_id`),
  CONSTRAINT `fk_oauth1` FOREIGN KEY (`oauth_id`) REFERENCES `oauth` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_has_funcao_funcao1` FOREIGN KEY (`funcao_id`) REFERENCES `funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_has_funcao_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_tem_funcao`
--

LOCK TABLES `pessoa_tem_funcao` WRITE;
/*!40000 ALTER TABLE `pessoa_tem_funcao` DISABLE KEYS */;
INSERT INTO `pessoa_tem_funcao` VALUES (1,1,1,NULL,NULL),(2,2,1,NULL,NULL),(3,3,3,NULL,NULL),(4,4,2,NULL,NULL),(5,5,2,NULL,NULL),(6,6,4,NULL,NULL);
/*!40000 ALTER TABLE `pessoa_tem_funcao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_tem_funcao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`pessoa_tem_funcao`
FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
	DECLARE funcao_nome VARCHAR(50);
    DECLARE verifica VARCHAR(10);
    DECLARE pessoa_registro VARCHAR(15);
    DECLARE invalid INT;

	SET invalid = 0;
	SET error_message = "";

	SELECT nome INTO funcao_nome
		FROM funcao
		WHERE id = NEW.funcao_id;

    SELECT registro INTO pessoa_registro
		FROM pessoa
		WHERE id = NEW.pessoa_id;
    
	CASE funcao_nome
		WHEN "cliente" THEN SELECT "cpf" INTO verifica;
        WHEN "cliente-especial" THEN SELECT "cpf" INTO verifica;
        WHEN "funcionario" THEN SELECT "cpf" INTO verifica;
        WHEN "fornecedor" THEN SELECT "cnpj" INTO verifica;
        WHEN "terceiro" THEN SELECT "cnpj" INTO verifica;
        WHEN "administrador" THEN SELECT "cpf" INTO verifica;
        ELSE SELECT "erro" INTO verifica;
	END CASE;
    
    IF(verifica = "cpf") THEN
		IF NOT cpf_valido(pessoa_registro) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nRegistro deve ser CPF, CNPJ encontrado."); 
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = error_message;
        END IF;
    ELSEIF(verifica = "cnpj") THEN
		IF NOT cnpj_valido(pessoa_registro) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nRegistro deve ser CNPJ, CPF encontrado."); 
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = error_message;
        END IF;
    ELSE
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nTipo de registro não definido.");
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_tem_funcao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`pessoa_tem_funcao`
FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
	DECLARE funcao_nome VARCHAR(50);
    DECLARE verifica VARCHAR(10);
    DECLARE pessoa_registro VARCHAR(15);
    DECLARE invalid INT;

	SET invalid = 0;
	SET error_message = "";

	SELECT nome INTO funcao_nome
		FROM funcao
		WHERE id = NEW.funcao_id;

    SELECT registro INTO pessoa_registro
		FROM pessoa
		WHERE id = NEW.pessoa_id;
    
	CASE funcao_nome
		WHEN "cliente" THEN SELECT "cpf" INTO verifica;
        WHEN "cliente-especial" THEN SELECT "cpf" INTO verifica;
        WHEN "funcionario" THEN SELECT "cpf" INTO verifica;
        WHEN "fornecedor" THEN SELECT "cnpj" INTO verifica;
        WHEN "terceiro" THEN SELECT "cnpj" INTO verifica;
        WHEN "administrador" THEN SELECT "cpf" INTO verifica;
        ELSE SELECT "erro" INTO verifica;
	END CASE;
    
    IF(verifica = "cpf") THEN
		IF NOT cpf_valido(pessoa_registro) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nRegistro deve ser CPF, CNPJ encontrado."); 
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = error_message;
        END IF;
    ELSEIF(verifica = "cnpj") THEN
		IF NOT cnpj_valido(pessoa_registro) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nRegistro deve ser CNPJ, CPF encontrado."); 
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = error_message;
        END IF;
    ELSE
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nTipo de registro não definido.");
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pessoa_tem_permissao`
--

DROP TABLE IF EXISTS `pessoa_tem_permissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa_tem_permissao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `pessoa_tem_funcao_id` int(11) NOT NULL COMMENT 'Dá à uma pessoa alguma permissão no sistema, como funcionário ser banhista',
  `permissoes_id` int(11) NOT NULL COMMENT 'Permissão da pessoa',
  PRIMARY KEY (`id`),
  KEY `fk_pessoa_tem_funcao_has_permissoes_permissoes1_idx` (`permissoes_id`),
  KEY `fk_pessoa_tem_funcao_has_permissoes_pessoa_tem_funcao1_idx` (`pessoa_tem_funcao_id`),
  CONSTRAINT `fk_pessoa_tem_funcao_has_permissoes_permissoes1` FOREIGN KEY (`permissoes_id`) REFERENCES `permissao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_tem_funcao_has_permissoes_pessoa_tem_funcao1` FOREIGN KEY (`pessoa_tem_funcao_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_tem_permissao`
--

LOCK TABLES `pessoa_tem_permissao` WRITE;
/*!40000 ALTER TABLE `pessoa_tem_permissao` DISABLE KEYS */;
INSERT INTO `pessoa_tem_permissao` VALUES (1,3,1),(2,3,2),(3,3,3),(5,3,4);
/*!40000 ALTER TABLE `pessoa_tem_permissao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_tem_permissoes_BEFORE_INSERT`
BEFORE INSERT ON `pessoa_tem_permissao` FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE tipo_pessoa VARCHAR(50);
        
	SET invalid = 0;
	SET error_message = "";
    
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id;
    IF(tipo_pessoa <> 'funcionario' AND tipo_pessoa <> 'administrador') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPessoa deve ser funcioária ou administradora para ter permissões.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_tem_permissoes_BEFORE_UPDATE`
BEFORE UPDATE ON `pessoa_tem_permissao` FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE tipo_pessoa VARCHAR(50);
        
	SET invalid = 0;
	SET error_message = "";
    
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id;
    IF(tipo_pessoa <> 'funcionario' AND tipo_pessoa <> 'administrador') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPessoa deve ser funcioária ou administradora para ter permissões.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pessoa_tem_rede_social`
--

DROP TABLE IF EXISTS `pessoa_tem_rede_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa_tem_rede_social` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `perfil` varchar(200) NOT NULL COMMENT 'Como encontrar a pessoa na rede social',
  `rede_social_id` int(11) NOT NULL COMMENT 'Rede social desta relação',
  `pessoa_id` int(11) NOT NULL COMMENT 'Pessoa desta relação',
  PRIMARY KEY (`id`),
  KEY `fk_pessoa_tem_rede_social_rede_social1_idx` (`rede_social_id`),
  KEY `fk_pessoa_tem_rede_social_pessoa1_idx` (`pessoa_id`),
  CONSTRAINT `fk_pessoa_tem_rede_social_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_tem_rede_social_rede_social1` FOREIGN KEY (`rede_social_id`) REFERENCES `rede_social` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_tem_rede_social`
--

LOCK TABLES `pessoa_tem_rede_social` WRITE;
/*!40000 ALTER TABLE `pessoa_tem_rede_social` DISABLE KEYS */;
INSERT INTO `pessoa_tem_rede_social` VALUES (1,'Andre Garcia',1,1),(2,'(22)99831123',2,1),(3,'Alessandra Bitobrovec',1,2),(4,'Cesar Santos',1,4);
/*!40000 ALTER TABLE `pessoa_tem_rede_social` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `porte`
--

DROP TABLE IF EXISTS `porte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `porte` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Descrição do porte',
  `tamanho_minimo` int(11) DEFAULT NULL COMMENT 'Tamanho mínimo do porte em centímetros',
  `tamanho_maximo` int(11) DEFAULT NULL COMMENT 'Tamanho máximo do porte em centímetros',
  `peso_minimo` int(11) DEFAULT NULL COMMENT 'peso mínimo do porte em gramas',
  `peso_maximo` int(11) DEFAULT NULL COMMENT 'Peso máximo do porte em gramas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `porte`
--

LOCK TABLES `porte` WRITE;
/*!40000 ALTER TABLE `porte` DISABLE KEYS */;
INSERT INTO `porte` VALUES (1,'Mini',1,28,0,6),(2,'Mini Peludo',1,28,0,6),(3,'Pequeno',29,35,7,15),(4,'Médio',36,49,16,25),(5,'Médio Peludo',36,49,16,25),(6,'Grande',50,69,26,45),(7,'Grande Peludo',50,69,26,45),(8,'Extra',70,100,46,60),(9,'Pelo Curto',1,100,0,100),(10,'Pelo Longo',1,100,0,100),(11,'Todos',1,100,0,100);
/*!40000 ALTER TABLE `porte` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`porte_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`porte`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
    
    IF(NEW.tamanho_minimo <= 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nTamanho mínimo não pode menor ou igual a zero.");
    END IF;
    
    IF(NEW.tamanho_maximo <= NEW.tamanho_minimo) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nTamanho máximo não pode ser menor ou igual ao tamanho mínimo.");
	END IF;
        
	IF(NEW.peso_minimo <= 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPeso mínimo não pode ser menor ou igual a zero.");
    END IF;
    
    IF(NEW.peso_maximo <= NEW.peso_minimo) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPeso máximo não pode ser menor ou igual ao peso mínimo.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`porte_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`porte`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
    
    IF(NEW.tamanho_minimo <= 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nTamanho mínimo não pode menor ou igual a zero.");
    END IF;
    
    IF(NEW.tamanho_maximo <= NEW.tamanho_minimo) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nTamanho máximo não pode ser menor ou igual ao tamanho mínimo.");
	END IF;
        
	IF(NEW.peso_minimo <= 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPeso mínimo não pode ser menor ou igual a zero.");
    END IF;
    
    IF(NEW.peso_maximo <= NEW.peso_minimo) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPeso máximo não pode ser menor ou igual ao peso mínimo.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `raca`
--

DROP TABLE IF EXISTS `raca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raca` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Nome da raça',
  `especie_id` int(11) NOT NULL COMMENT 'A raça pertence à alguma espécie',
  `porte_id` int(11) NOT NULL COMMENT 'Código do Porte desta raça',
  PRIMARY KEY (`id`),
  KEY `fk_raca_especie1_idx` (`especie_id`),
  KEY `fk_raca_porte1_idx` (`porte_id`),
  CONSTRAINT `fk_raca_especie1` FOREIGN KEY (`especie_id`) REFERENCES `especie` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_raca_porte1` FOREIGN KEY (`porte_id`) REFERENCES `porte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raca`
--

LOCK TABLES `raca` WRITE;
/*!40000 ALTER TABLE `raca` DISABLE KEYS */;
INSERT INTO `raca` VALUES (1,'Affenpinscher',1,2),(2,'Airedale Terrier',1,7),(3,'Akita',1,7),(4,'Akita Americano',1,7),(5,'American Staffordshire Terrier',1,5),(6,'Australian Shepherd',1,7),(7,'Basenji',1,4),(8,'Basset Fulvo da Bretanha',1,3),(9,'Basset Hound',1,3),(10,'Beagle',1,4),(11,'Beagle-Harrier',1,4),(12,'Bearded Collie',1,7),(13,'Bedlington Terrier',1,5),(14,'Bichon Bolonhês',1,2),(15,'Bichon Frisé',1,2),(16,'Bichon Havanês',1,2),(17,'Blue Heeler',1,5),(18,'Boerboel',1,6),(19,'Boiadeiro Bernês',1,8),(20,'Boiadeiro de Entlebuch',1,4),(21,'Boiadeiro da Flandres',1,7),(22,'Border Collie',1,7),(23,'Border Terrier',1,4),(24,'Borzoi',1,7),(25,'Boston Terrier',1,4),(26,'Boxer',1,6),(27,'Braco Alemão Pelo Curto',1,6),(28,'Braco Alemão Pelo Duro',1,6),(29,'Braco Húngaro de Pelo Curto',1,6),(30,'Braco Italiano',1,6),(31,'Buldogue Americano',1,4),(32,'Buldogue Francês',1,3),(33,'Buldogue Inglês',1,5),(34,'Bull Terrier',1,4),(35,'Bulmastife',1,6),(36,'Cairn Terrier',1,2),(37,'Cane Corso',1,6),(38,'Cão de Água Português',1,5),(39,'Cão de Crista Chinês',1,2),(40,'Cão de Santo Humberto',1,6),(41,'Cão D\'água Espanhol',1,5),(42,'Cão D\'água Português',1,7),(43,'Cão Lobo Checoslovaco',1,7),(44,'Cão Pelado Mexicano',1,3),(45,'Cão Pelado Peruano',1,4),(46,'Cavalier King Charles Spaniel',1,3),(47,'Cesky Terrier',1,3),(48,'Chesapeake Bay Retriever',1,6),(49,'Chihuahua',1,1),(50,'Chow-chow Pelo Curto',1,7),(51,'Chow-chow Pelo Longo',1,7),(52,'Cirneco do Etna',1,4),(53,'Clumber Spaniel',1,5),(54,'Cocker Spaniel Americano',1,5),(55,'Cocker Spaniel Inglês',1,5),(56,'Collie',1,7),(57,'Coton de Tuléar',1,3),(58,'Dachshund',1,3),(59,'Dálmata',1,6),(60,'Dandie Dinmont Terrier',1,2),(61,'Dobermann',1,6),(62,'Dogue Argentino',1,6),(63,'Dogue Canárop',1,6),(64,'Dogue Alemão',1,8),(65,'Dogue de Bordeaux',1,6),(66,'Elkhound Norueguês Cinza',1,4),(67,'Fila Brasileiro',1,6),(68,'Flat-Coated Retriever',1,7),(69,'Fox Terrier Pelo Duro',1,5),(70,'Fox Terrier Pelo Liso',1,4),(71,'Foxhound Inglês',1,5),(72,'Galgo Afegão',1,7),(73,'Galgo Espanhol',1,6),(74,'Galgo Escocês',1,8),(75,'Galgo Irlandês',1,8),(76,'Galgo Italiano',1,3),(77,'Golden Retriever',1,7),(78,'Grande Boiadeiro Suiço',1,7),(79,'Grande Münsterländer',1,7),(80,'Greyhound',1,8),(81,'Grifo da Bélgica',1,2),(82,'Grifo de Bruxelas',1,2),(83,'Husky Siberiano',1,7),(84,'Ibizan Hound',1,6),(85,'Irish Soft Coated Wheaten Terrier',1,5),(86,'Irish Wolfhound',1,8),(87,'Jack Russell Terrier',1,3),(88,'Kerry Blue Terrier',1,5),(89,'King Charles',1,3),(90,'Komondor',1,7),(91,'Kuvasz',1,7),(92,'Labradoodle',1,5),(93,'Labrador Retriever',1,6),(94,'Lagotto Romagnolo',1,5),(95,'Lakeland Terrier',1,3),(96,'Leonberger',1,8),(97,'Lhasa Apso',1,3),(98,'Malamute do Alasca',1,7),(99,'Maltês',1,2),(100,'Mastim Espanhol',1,8),(101,'Mastim Inglês',1,8),(102,'Mastim Tibetano',1,7),(103,'Mastim Napolitano',1,6),(104,'Mudi',1,5),(105,'Nordic Spitz',1,5),(106,'Norfolk Terrier',1,2),(107,'Norwich Terrier',1,2),(108,'Old English Sheepdog',1,7),(109,'Papillon',1,2),(110,'Parson Russell Terrier',1,3),(111,'Pastor Alemão',1,7),(112,'Pastor Australiano',1,7),(113,'Pastor-de-Beauce',1,7),(114,'Pastor Belga',1,7),(115,'Pastor Bergamasco',1,7),(116,'Pastor Branco Suiço',1,7),(117,'Pastor Briard',1,7),(118,'Pastor da Ásia Central',1,7),(119,'Pastor de Shetland',1,5),(120,'Pastor dos Pirineus',1,8),(121,'Pastor Maremano Abruzês',1,7),(122,'Pastor Polonês',1,5),(123,'Pequeno Basset Griffon da Vendéia',1,3),(124,'Pequeno Cão Leão',1,3),(125,'Pequinês',1,2),(126,'Perdigueiro Português',1,6),(127,'Pharaoh Hound',1,6),(128,'Pinscher Miniatura',1,1),(129,'Pit Bul',1,6),(130,'Podengo Canário',1,6),(131,'Podengo Português',1,5),(132,'Pointer Inglês',1,6),(133,'Poodle Anão',1,3),(134,'Poodle Médio',1,5),(135,'Poodle Standard',1,7),(136,'Poodle Toy',1,2),(137,'Pug',1,3),(138,'Puli',1,5),(139,'Pumi',1,5),(140,'Rhodesian Ridgeback',1,6),(141,'Rottweiler',1,6),(142,'Saluki',1,8),(143,'Samoieda',1,7),(144,'São Bernardo',1,8),(145,'Schipperke',1,3),(146,'Schnauzer',1,5),(147,'Schnauzer Gigante',1,7),(148,'Schnauzer Miniatura',1,3),(149,'Scottish Terrier',1,2),(150,'Sealyham Terrier',1,2),(151,'Sem Raça Definida Mini',1,1),(152,'Sem Raça Definida Mini Peludo',1,2),(153,'Sem Raça Definida Pequeno',1,3),(154,'Sem Raça Definida Médio',1,4),(155,'Sem Raça Definida Médio Peludo',1,5),(156,'Sem Raça Definida Grande',1,6),(157,'Sem Raça Definida Grande Peludo',1,7),(158,'Sem Raça Definida Extra',1,8),(159,'Setter Inglês',1,7),(160,'Setter Irlandês',1,7),(161,'Shar-pei',1,4),(162,'Shiba',1,5),(163,'Shih-Tzu',1,2),(164,'Silky Terrier Australuano',1,2),(165,'Skye Terrier',1,2),(166,'Smoushond Holandês',1,5),(167,'Spaniel Bretão',1,5),(168,'Spinone Italiano',1,7),(169,'Spitz Alemão Anão',1,2),(170,'Spitz Finlandês',1,5),(171,'Spitz Japonês Anão',1,2),(172,'Springer Spaniel Inglês',1,5),(173,'Stabyhoun',1,5),(174,'Staffordshire Bull Terrier',1,4),(175,'Terra Nova',1,8),(176,'Terrier Alemão de Caça Jagd',1,3),(177,'Terrier Brasileiro',1,4),(178,'Terrier Escocês',1,2),(179,'Terrier Irlandês de Glen do Imaal',1,3),(180,'Terrier Preto da Rússia',1,7),(181,'Terrier Tibetano',1,7),(182,'Tosa Inu',1,5),(183,'Vulpino Italiano',1,3),(184,'Weimaraner',1,6),(185,'Welsh Corgi Cardigan',1,2),(186,'Welsh Corgi Pembroke',1,1),(187,'Welsh Springer Spaniel',1,5),(188,'Welsh Terrier',1,5),(189,'West Highland White Terrier',1,2),(190,'Whippet',1,6),(191,'Xoloitzcuintli',1,4),(192,'Yorkshire Terrier',1,2);
/*!40000 ALTER TABLE `raca` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`raca_BEFORE_INSERT` BEFORE INSERT ON `raca` FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.nome) THEN
		SET error_message = "\nRaça deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`raca_BEFORE_UPDATE` BEFORE UPDATE ON `raca` FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.nome) THEN
		SET error_message = "\nRaça deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rede_social`
--

DROP TABLE IF EXISTS `rede_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rede_social` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Nome da rede social',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rede_social`
--

LOCK TABLES `rede_social` WRITE;
/*!40000 ALTER TABLE `rede_social` DISABLE KEYS */;
INSERT INTO `rede_social` VALUES (1,'Facebook'),(2,'WhatsApp'),(3,'Instagram');
/*!40000 ALTER TABLE `rede_social` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`rede_social_BEFORE_INSERT` BEFORE INSERT ON `rede_social` FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.nome) THEN
		SET error_message = "\nNome deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`rede_social_BEFORE_UPDATE` BEFORE UPDATE ON `rede_social` FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.nome) THEN
		SET error_message = "\nNome deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `restricao`
--

DROP TABLE IF EXISTS `restricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restricao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `restricao` varchar(50) NOT NULL COMMENT 'Nome da restrição',
  `descricao` varchar(200) DEFAULT NULL COMMENT 'Informações da restrição',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restricao`
--

LOCK TABLES `restricao` WRITE;
/*!40000 ALTER TABLE `restricao` DISABLE KEYS */;
INSERT INTO `restricao` VALUES (1,'Pelagem Escura','Animal não pode ficar exposto ao sol'),(2,'Alergia Água quente','Animal apresenta manchas quando lavado com água quente'),(3,'Não Cortar Unhas','Animal não deve ter as unhas cortadas'),(5,'Alergia a Shampoo Vermelho',NULL);
/*!40000 ALTER TABLE `restricao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`restricao_BEFORE_INSERT` 
BEFORE INSERT ON `restricao` 
FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.restricao) THEN
		SET error_message = "\nRestrição deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`restricao_BEFORE_UPDATE` 
BEFORE UPDATE ON `restricao` 
FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
    
	IF NOT nome_valido(NEW.restricao) THEN
		SET error_message = "\nRestrição deve conter apenas letras.";
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Nome do serviço',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

LOCK TABLES `servico` WRITE;
/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
INSERT INTO `servico` VALUES (1,'Banho'),(2,'Tosa'),(3,'Pacote'),(4,'Remoção de Pelo Morto'),(5,'Taxa de Desembolo'),(6,'Tosa Higiênica'),(7,'Hidratação'),(8,'Adicional Toalha'),(9,'Escovação de Dentes'),(10,'Consulta');
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico_agendado`
--

DROP TABLE IF EXISTS `servico_agendado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico_agendado` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `preco` decimal(10,2) NOT NULL COMMENT 'Valor total do serviço',
  `recorrente` tinyint(1) NOT NULL COMMENT 'Se vai ser realizado mais vezes',
  `data_hora` datetime NOT NULL COMMENT 'Dia e Horário do agendamento',
  `servico_tem_porte_id` int(11) NOT NULL COMMENT 'Código do conjunto servico-porte correspondente',
  `animal_id` int(11) NOT NULL COMMENT 'Animal que vai receber o serviço',
  `servico_contratado_id` int(11) NOT NULL COMMENT 'O serviço agendado pertence à um contrato',
  `executado` tinyint(1) NOT NULL COMMENT 'Controla se já foi executado ou não',
  `pago` tinyint(1) NOT NULL COMMENT 'Controla se já foi realizado seu pagamento',
  `observacao` varchar(200) DEFAULT NULL COMMENT 'Informações adicionais',
  `data_hora_executado` datetime DEFAULT NULL COMMENT 'Momento em que foi executado',
  `funcionario_executa_id` int(11) DEFAULT NULL COMMENT 'Funcionário que executou o serviço',
  `cancelado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_servico_agendado_animal1_idx` (`animal_id`),
  KEY `fk_servico_agendado_servico_contratado1_idx` (`servico_contratado_id`),
  KEY `fk_servico_agendado_pessoa_tem_funcao1_idx` (`funcionario_executa_id`),
  KEY `fk_servico_agendado_servico_tem_porte1_idx` (`servico_tem_porte_id`),
  CONSTRAINT `fk_servico_agendado_animal1` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_pessoa_tem_funcao1` FOREIGN KEY (`funcionario_executa_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_servico_contratado1` FOREIGN KEY (`servico_contratado_id`) REFERENCES `servico_contratado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_servico_tem_porte1` FOREIGN KEY (`servico_tem_porte_id`) REFERENCES `servico_tem_porte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_agendado`
--

LOCK TABLES `servico_agendado` WRITE;
/*!40000 ALTER TABLE `servico_agendado` DISABLE KEYS */;
INSERT INTO `servico_agendado` VALUES (1,28.00,0,'2016-09-06 09:00:00',14,2,1,1,1,NULL,'2016-09-06 10:31:00',3,0),(2,28.00,0,'2016-09-06 10:00:00',14,3,1,1,1,NULL,'2016-09-06 11:00:00',3,0),(3,100.00,0,'2016-09-06 10:00:00',62,2,1,1,1,NULL,'2016-09-06 11:00:00',3,0),(4,50.00,0,'2016-09-12 09:00:00',8,3,2,0,1,NULL,NULL,NULL,0),(5,20.00,0,'2016-09-12 10:00:00',33,4,2,0,1,NULL,NULL,NULL,0),(6,36.00,0,'2016-09-12 13:00:00',28,5,2,0,1,NULL,NULL,NULL,0),(7,7.00,0,'2016-09-12 14:00:00',19,6,2,0,1,NULL,NULL,NULL,0),(8,171.00,0,'2016-09-15 11:00:00',62,1,3,0,1,NULL,NULL,NULL,0),(19,10.00,0,'2016-11-12 00:00:00',23,1,8,0,0,NULL,NULL,NULL,0),(20,10.00,0,'2016-11-12 00:00:00',23,1,8,0,0,NULL,NULL,NULL,0),(21,10.00,0,'2016-11-12 00:00:00',23,1,8,0,0,NULL,NULL,NULL,0),(24,55.00,0,'2016-11-15 08:00:00',22,1,55,0,0,NULL,NULL,NULL,0),(25,55.00,0,'2016-11-15 09:00:00',22,1,56,0,0,NULL,NULL,NULL,0),(27,31.00,0,'2016-11-21 00:00:00',21,1,61,0,0,'sdasadsad',NULL,NULL,0);
/*!40000 ALTER TABLE `servico_agendado` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_agendado_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`servico_agendado`
FOR EACH ROW
BEGIN
	DECLARE numero_animais INT;
	DECLARE tipo_pessoa VARCHAR(50);
    DECLARE tipo_pessoa_execut VARCHAR(50);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	DECLARE money DECIMAL(10,2);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
	END IF;
    
    IF NEW.funcionario_executa_id IS NOT NULL THEN
		SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.funcionario_executa_id;
		IF(tipo_pessoa <> 'funcionario') THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nPessoa deve ser um funcionário para executar um serviço.");
		END IF;
	END IF;
    
    IF NEW.data_hora_executado IS NOT NULL THEN
		IF(NEW.data_hora_executado > NOW()) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nImpossível cadastrar data e hora executado no futuro.");
		END IF;
	END IF;

    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
        
	SELECT sc.preco INTO money FROM servico_contratado sc WHERE sc.id = NEW.servico_contratado_id;
    SET money = money + NEW.preco;
        
    UPDATE servico_contratado as sc SET sc.preco = money WHERE sc.id = NEW.servico_contratado_id;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_agendado_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`servico_agendado`
FOR EACH ROW
BEGIN
	DECLARE numero_animais INT;
	DECLARE tipo_pessoa VARCHAR(50);
    DECLARE tipo_pessoa_execut VARCHAR(50);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	DECLARE money DECIMAL(10,2);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
	END IF;
		
    IF NEW.funcionario_executa_id IS NOT NULL THEN
		SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.funcionario_executa_id;
		IF(tipo_pessoa <> 'funcionario') THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nPessoa deve ser um funcionário para executar um serviço.");
		END IF;
	END IF;
    
    IF NEW.data_hora_executado IS NOT NULL THEN
		IF(NEW.data_hora_executado > NOW()) THEN
			SET invalid = 1;
			SET error_message = CONCAT(error_message, "\nImpossível cadastrar data e hora executado no futuro.");
		END IF;
	END IF;

    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
        
        SELECT sc.preco INTO money FROM servico_contratado sc WHERE sc.id = NEW.servico_contratado_id;
        SET money = money + (NEW.preco - OLD.preco);
        
        UPDATE servico_contratado as sc SET sc.preco = money WHERE sc.id = NEW.servico_contratado_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_agendado_BEFORE_DELETE` 
BEFORE DELETE ON `servico_agendado` 
FOR EACH ROW
BEGIN
	DECLARE money DECIMAL(10,2);
    
    SELECT sc.preco INTO money FROM servico_contratado sc WHERE sc.id = OLD.servico_contratado_id;
	SET money = money - OLD.preco;
        
	UPDATE servico_contratado as sc SET sc.preco = money WHERE sc.id = OLD.servico_contratado_id;


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `servico_contratado`
--

DROP TABLE IF EXISTS `servico_contratado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico_contratado` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `pessoa_tem_funcao_id_funcionario` int(11) NOT NULL COMMENT 'Funcionário que realizou o agendamento',
  `preco` decimal(10,2) NOT NULL COMMENT 'Valor total do contrato',
  `data_hora` datetime NOT NULL COMMENT 'Controla o momento em que o contrato foi cadastrado',
  `transacao_id` int(11) NOT NULL COMMENT 'Código da transação gerada por este contrato',
  PRIMARY KEY (`id`),
  KEY `fk_servico_contratado_pessoa_tem_funcao1_idx` (`pessoa_tem_funcao_id_funcionario`),
  KEY `fk_servico_contratado_transacao1_idx` (`transacao_id`),
  CONSTRAINT `fk_servico_contratado_pessoa_tem_funcao1` FOREIGN KEY (`pessoa_tem_funcao_id_funcionario`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_contratado_transacao1` FOREIGN KEY (`transacao_id`) REFERENCES `transacao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_contratado`
--

LOCK TABLES `servico_contratado` WRITE;
/*!40000 ALTER TABLE `servico_contratado` DISABLE KEYS */;
INSERT INTO `servico_contratado` VALUES (1,3,156.00,'2016-09-10 02:52:52',1),(2,3,113.00,'2016-09-10 02:52:52',2),(3,3,171.00,'2016-09-10 02:52:52',3),(4,3,0.00,'2016-09-10 02:52:52',4),(8,3,30.00,'2016-11-11 00:03:14',17),(9,3,0.00,'2016-11-15 09:50:40',18),(10,3,0.00,'2016-11-15 10:00:25',19),(11,3,0.00,'2016-11-15 10:04:32',20),(12,3,0.00,'2016-11-15 10:04:40',21),(13,3,0.00,'2016-11-15 10:08:51',22),(14,3,0.00,'2016-11-15 10:12:19',23),(15,3,0.00,'2016-11-15 10:12:59',24),(16,3,0.00,'2016-11-15 10:15:23',25),(17,3,0.00,'2016-11-15 10:16:39',26),(18,3,0.00,'2016-11-15 10:18:22',27),(19,3,0.00,'2016-11-15 10:20:04',28),(20,3,0.00,'2016-11-15 10:22:09',29),(21,3,0.00,'2016-11-15 10:23:08',30),(22,3,0.00,'2016-11-15 10:25:01',31),(23,3,0.00,'2016-11-15 10:27:22',32),(24,3,0.00,'2016-11-15 10:27:53',33),(25,3,0.00,'2016-11-15 10:29:16',34),(26,3,0.00,'2016-11-15 10:29:34',35),(27,3,0.00,'2016-11-15 10:30:29',36),(28,3,0.00,'2016-11-15 10:33:25',37),(29,3,0.00,'2016-11-15 10:34:31',38),(30,3,0.00,'2016-11-15 10:38:12',39),(31,3,0.00,'2016-11-15 10:42:56',40),(32,3,0.00,'2016-11-15 10:47:32',41),(33,3,0.00,'2016-11-15 10:48:23',42),(34,3,0.00,'2016-11-15 10:49:16',43),(35,3,0.00,'2016-11-15 10:49:55',44),(36,3,0.00,'2016-11-15 10:50:45',45),(37,3,0.00,'2016-11-15 10:51:08',46),(38,3,0.00,'2016-11-15 10:51:46',47),(39,3,0.00,'2016-11-15 10:52:11',48),(40,3,0.00,'2016-11-15 10:53:08',49),(41,3,0.00,'2016-11-15 10:54:13',50),(42,3,0.00,'2016-11-15 10:55:17',51),(43,3,0.00,'2016-11-15 10:55:47',52),(44,3,0.00,'2016-11-15 10:56:25',53),(45,3,0.00,'2016-11-15 10:57:06',54),(46,3,0.00,'2016-11-15 10:59:34',55),(47,3,0.00,'2016-11-15 11:00:19',56),(48,3,0.00,'2016-11-15 11:01:44',57),(49,3,0.00,'2016-11-15 11:02:19',58),(50,3,0.00,'2016-11-15 11:03:07',59),(51,3,0.00,'2016-11-15 11:04:48',60),(52,3,0.00,'2016-11-15 11:06:24',61),(53,3,0.00,'2016-11-15 11:07:32',62),(54,3,0.00,'2016-11-15 11:09:06',63),(55,3,55.00,'2016-11-15 11:12:53',64),(56,3,55.00,'2016-11-15 11:13:26',65),(57,3,0.00,'2016-11-15 18:07:30',64),(58,3,0.00,'2016-11-15 18:50:48',64),(59,3,0.00,'2016-11-21 23:44:53',71),(60,3,0.00,'2016-11-21 23:47:18',72),(61,3,31.00,'2016-11-21 23:47:40',73);
/*!40000 ALTER TABLE `servico_contratado` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_contratado_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`servico_contratado`
FOR EACH ROW
BEGIN
	DECLARE tipo_pessoa VARCHAR(50);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	DECLARE money DECIMAL(10,2);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
	END IF;
		
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id_funcionario;
	IF(tipo_pessoa <> 'funcionario') THEN
		SET invalid = invalid + 1;
		SET error_message = CONCAT(error_message, "\nPessoa deve ser um funcionário para agendar um serviço.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
        
	SELECT t.valor INTO money FROM transacao as t WHERE t.id = NEW.transacao_id;
	SET money = money + NEW.preco;
        
	UPDATE transacao as t SET t.valor = money WHERE t.id = NEW.transacao_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_contratado_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`servico_contratado`
FOR EACH ROW
BEGIN
DECLARE tipo_pessoa VARCHAR(50);
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	DECLARE money DECIMAL(10,2);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
	END IF;
		
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id_funcionario;
	IF(tipo_pessoa <> 'funcionario') THEN
		SET invalid = invalid + 1;
		SET error_message = CONCAT(error_message, "\nPessoa deve ser um funcionário para agendar um serviço.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
        
        SELECT t.valor INTO money FROM transacao as t WHERE t.id = NEW.transacao_id;
        SET money = money + (NEW.preco - OLD.preco);
        
        UPDATE transacao as t SET t.valor = money WHERE t.id = NEW.transacao_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_contratado_BEFORE_DELETE` 
BEFORE DELETE ON `servico_contratado` 
FOR EACH ROW
BEGIN
	
    DECLARE money DECIMAL(10,2);

	SELECT t.valor INTO money FROM transacao as t WHERE t.id = OLD.transacao_id;
	SET money = money - OLD.preco;
        
	UPDATE transacao as t SET t.valor = money WHERE t.id = OLD.transacao_id;


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `servico_tem_porte`
--

DROP TABLE IF EXISTS `servico_tem_porte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico_tem_porte` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `servico_id` int(11) NOT NULL COMMENT 'Código do serviço relacionado',
  `porte_id` int(11) NOT NULL COMMENT 'Código do porte relacionado',
  `preco` varchar(45) NOT NULL COMMENT 'Preço do serviço para aquele porte',
  PRIMARY KEY (`id`),
  KEY `fk_servico_tem_porte_servico_id_idx` (`servico_id`),
  KEY `fk_servico_tem_porte_porte_id_idx` (`porte_id`),
  CONSTRAINT `fk_servico_tem_porte_porte` FOREIGN KEY (`porte_id`) REFERENCES `porte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_tem_porte_servico` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_tem_porte`
--

LOCK TABLES `servico_tem_porte` WRITE;
/*!40000 ALTER TABLE `servico_tem_porte` DISABLE KEYS */;
INSERT INTO `servico_tem_porte` VALUES (1,1,1,'21.00'),(2,3,1,'75.00'),(3,4,1,'7.00'),(4,5,1,'10.00'),(5,6,1,'7.00'),(6,7,1,'15.00'),(7,1,2,'26.00'),(8,2,2,'50.00'),(9,3,2,'95.00'),(10,4,2,'7.00'),(11,5,2,'10.00'),(12,6,2,'7.00'),(13,7,2,'15.00'),(14,1,3,'28.00'),(15,2,3,'55.00'),(16,3,3,'95.00'),(17,4,3,'7.00'),(18,5,3,'10.00'),(19,6,3,'7.00'),(20,7,3,'15.00'),(21,1,4,'31.00'),(22,2,4,'55.00'),(23,3,4,'100.00'),(24,4,4,'10.00'),(25,5,4,'15.00'),(26,6,4,'7.00'),(27,7,4,'20.00'),(28,1,5,'36.00'),(29,2,5,'65.00'),(30,3,5,'120.00'),(31,4,5,'10.00'),(32,6,5,'7.00'),(33,7,5,'20.00'),(34,2,6,'75.00'),(35,3,6,'140.00'),(36,4,6,'15.00'),(37,5,6,'30.00'),(38,6,6,'10.00'),(39,7,6,'30.00'),(40,1,7,'50.00'),(41,2,7,'85.00'),(42,3,7,'160.00'),(43,4,7,'15.00'),(44,5,7,'30.00'),(45,6,7,'10.00'),(46,7,7,'30.00'),(47,1,8,'72.00'),(48,2,8,'100.00'),(49,3,8,'250.00'),(50,4,8,'25.00'),(51,5,8,'30.00'),(52,6,8,'10.00'),(53,7,8,'30.00'),(54,1,9,'27.00'),(55,2,9,'55.00'),(56,3,9,'86.00'),(57,1,10,'30.00'),(58,2,10,'60.00'),(59,3,10,'100.00'),(60,8,11,'2.00'),(61,9,11,'3.00'),(62,10,11,'100.00');
/*!40000 ALTER TABLE `servico_tem_porte` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_tem_porte_BEFORE_INSERT` BEFORE INSERT ON `servico_tem_porte` FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_tem_porte_BEFORE_UPDATE` BEFORE UPDATE ON `servico_tem_porte` FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";

	IF (NEW.preco < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nPreço não pode ser negativo.");
	END IF;
        
	IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `numero` varchar(9) NOT NULL COMMENT 'Número do telefone. Somente dígitos. Tamanho máximo ''9'' permite números de outros estados',
  `codigo_area` varchar(3) NOT NULL COMMENT 'Código de área da região',
  `codigo_pais` varchar(3) NOT NULL COMMENT 'Código do país',
  `pessoa_id` int(11) NOT NULL COMMENT 'Telefone pertence à uma pessoa',
  PRIMARY KEY (`id`),
  KEY `fk_telefone_pessoa1_idx` (`pessoa_id`),
  CONSTRAINT `fk_telefone_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefone`
--

LOCK TABLES `telefone` WRITE;
/*!40000 ALTER TABLE `telefone` DISABLE KEYS */;
INSERT INTO `telefone` VALUES (1,'33229933','22','055',1),(2,'999883213','22','055',1),(3,'92335421','16','055',2),(4,'77475928','78','055',3),(5,'11987483','78','055',3),(6,'938474373','08','055',4),(7,'66647347','31','055',5),(8,'551437141','31','055',5),(9,'12312465','99','055',6);
/*!40000 ALTER TABLE `telefone` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`telefone_BEFORE_INSERT` BEFORE INSERT ON `telefone` FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	
    SET invalid = 0;
	SET error_message = "";

    IF NOT (SELECT NEW.codigo_pais REGEXP '^0[0-9]{2}$') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nCódigo do país deve ter apenas dígitos.");
	END IF;
    
    IF NOT (SELECT NEW.codigo_area REGEXP '^0[0-9]{2}$') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nCódigo da área deve ter apenas dígitos.");
	END IF;
    
    IF NOT (SELECT New.numero REGEXP '^[0-9]{8,9}$') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nNúmero deve ter apenas dígitos.");
	END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`telefone_BEFORE_UPDATE` BEFORE UPDATE ON `telefone` FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	
    SET invalid = 0;
	SET error_message = "";

    IF NOT (SELECT NEW.codigo_pais REGEXP '^0[0-9]{2}$') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nCódigo do país deve ter apenas dígitos.");
	END IF;
    
    IF NOT (SELECT NEW.codigo_area REGEXP '^0[0-9]{2}$') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nCódigo da área deve ter apenas dígitos.");
	END IF;
    
    IF NOT (SELECT New.numero REGEXP '^[0-9]{8,9}$') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nNúmero deve ter apenas dígitos.");
	END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `tipo_funcao`
--

DROP TABLE IF EXISTS `tipo_funcao`;
/*!50001 DROP VIEW IF EXISTS `tipo_funcao`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `tipo_funcao` (
  `nome` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `tipo_servico`
--

DROP TABLE IF EXISTS `tipo_servico`;
/*!50001 DROP VIEW IF EXISTS `tipo_servico`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `tipo_servico` (
  `nome` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transacao`
--

DROP TABLE IF EXISTS `transacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `tipo` char(1) NOT NULL COMMENT 'Se é receita ou despesa (''C'' ou ''D'')',
  `data_hora` datetime NOT NULL COMMENT 'Controla o momento em que a transação foi cadastrada\n',
  `valor` decimal(10,2) NOT NULL COMMENT 'Valor em reais',
  `comentario` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacao`
--

LOCK TABLES `transacao` WRITE;
/*!40000 ALTER TABLE `transacao` DISABLE KEYS */;
INSERT INTO `transacao` VALUES (1,'C','2016-09-10 02:50:39',166.00,NULL),(2,'C','2016-09-10 02:50:39',213.00,NULL),(3,'C','2016-09-10 02:50:39',201.00,NULL),(4,'D','2016-09-10 02:50:39',0.00,NULL),(6,'D','2016-11-01 01:31:08',0.00,NULL),(7,'C','2016-11-08 08:52:28',0.00,NULL),(17,'C','2016-11-11 00:03:14',30.00,NULL),(18,'C','2016-11-15 09:50:40',0.00,NULL),(19,'C','2016-11-15 10:00:25',0.00,NULL),(20,'C','2016-11-15 10:04:32',0.00,NULL),(21,'C','2016-11-15 10:04:40',0.00,NULL),(22,'C','2016-11-15 10:08:51',0.00,NULL),(23,'C','2016-11-15 10:12:19',0.00,NULL),(24,'C','2016-11-15 10:12:59',0.00,NULL),(25,'C','2016-11-15 10:15:23',0.00,NULL),(26,'C','2016-11-15 10:16:39',0.00,NULL),(27,'C','2016-11-15 10:18:22',0.00,NULL),(28,'C','2016-11-15 10:20:04',0.00,NULL),(29,'C','2016-11-15 10:22:09',0.00,NULL),(30,'C','2016-11-15 10:23:08',0.00,NULL),(31,'C','2016-11-15 10:25:01',0.00,NULL),(32,'C','2016-11-15 10:27:22',0.00,NULL),(33,'C','2016-11-15 10:27:53',0.00,NULL),(34,'C','2016-11-15 10:29:16',0.00,NULL),(35,'C','2016-11-15 10:29:34',0.00,NULL),(36,'C','2016-11-15 10:30:29',0.00,NULL),(37,'C','2016-11-15 10:33:25',0.00,NULL),(38,'C','2016-11-15 10:34:31',0.00,NULL),(39,'C','2016-11-15 10:38:12',0.00,NULL),(40,'C','2016-11-15 10:42:56',0.00,NULL),(41,'C','2016-11-15 10:47:32',0.00,NULL),(42,'C','2016-11-15 10:48:23',0.00,NULL),(43,'C','2016-11-15 10:49:16',0.00,NULL),(44,'C','2016-11-15 10:49:55',0.00,NULL),(45,'C','2016-11-15 10:50:45',0.00,NULL),(46,'C','2016-11-15 10:51:07',0.00,NULL),(47,'C','2016-11-15 10:51:46',0.00,NULL),(48,'C','2016-11-15 10:52:11',0.00,NULL),(49,'C','2016-11-15 10:53:08',0.00,NULL),(50,'C','2016-11-15 10:54:12',0.00,NULL),(51,'C','2016-11-15 10:55:17',0.00,NULL),(52,'C','2016-11-15 10:55:46',0.00,NULL),(53,'C','2016-11-15 10:56:25',0.00,NULL),(54,'C','2016-11-15 10:57:06',0.00,NULL),(55,'C','2016-11-15 10:59:34',0.00,NULL),(56,'C','2016-11-15 11:00:19',0.00,NULL),(57,'C','2016-11-15 11:01:44',0.00,NULL),(58,'C','2016-11-15 11:02:19',0.00,NULL),(59,'C','2016-11-15 11:03:07',0.00,NULL),(60,'C','2016-11-15 11:04:48',0.00,NULL),(61,'C','2016-11-15 11:06:24',0.00,NULL),(62,'C','2016-11-15 11:07:32',0.00,NULL),(63,'C','2016-11-15 11:09:06',0.00,NULL),(64,'C','2016-11-15 11:12:53',55.00,NULL),(65,'C','2016-11-15 11:13:26',55.00,NULL),(67,'C','2016-11-20 23:57:21',0.00,NULL),(68,'C','2016-11-20 23:57:30',0.00,NULL),(69,'C','2016-11-21 00:06:23',0.00,NULL),(70,'C','2016-11-21 00:10:25',40.00,NULL),(71,'C','2016-11-21 23:44:53',0.00,NULL),(72,'C','2016-11-21 23:47:18',0.00,NULL),(73,'C','2016-11-21 23:47:40',31.00,NULL);
/*!40000 ALTER TABLE `transacao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`transacao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`transacao`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
    
    IF(NEW.tipo <> 'C' AND NEW.tipo <> 'D') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nTipo deve ser C ou D.");
    END IF;
    
    IF(NEW.valor < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nValor não pode ser negativo.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`transacao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`transacao`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
    
    IF(NEW.tipo <> 'C' AND NEW.tipo <> 'D') THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nTipo deve ser C ou D.");
    END IF;
    
    IF(NEW.valor < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nValor não pode ser negativo.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vacina`
--

DROP TABLE IF EXISTS `vacina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacina` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Nome da vacina',
  `dose` int(11) NOT NULL COMMENT 'Quantidade da dose em mililitros',
  `intervalo` int(11) NOT NULL COMMENT 'Número de dias entre uma aplicação e outra',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacina`
--

LOCK TABLES `vacina` WRITE;
/*!40000 ALTER TABLE `vacina` DISABLE KEYS */;
INSERT INTO `vacina` VALUES (1,'V8',2,12),(2,'Gripe Canina',10,36);
/*!40000 ALTER TABLE `vacina` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`vacina_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`vacina`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
    
    IF(NEW.dose <= 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nDose deve ser maior que 0.");
    END IF;
    
    IF(NEW.intervalo <= 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nIntervalo deve ser maior que 0.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`vacina_BEFORE_UPDATE` BEFORE UPDATE ON `vacina` FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
    
    IF(NEW.dose <= 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nDose deve ser maior que 0.");
    END IF;
    
    IF(NEW.intervalo <= 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nIntervalo deve ser maior que 0.");
    END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vacina_tem_lote`
--

DROP TABLE IF EXISTS `vacina_tem_lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacina_tem_lote` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `vacina_id` int(11) NOT NULL COMMENT 'Código da vacina',
  `lote_id` int(11) NOT NULL COMMENT 'Código do lote',
  `quantidade` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vacina1_idx` (`vacina_id`),
  KEY `fk_lote1_idx` (`lote_id`),
  CONSTRAINT `fk_lote1` FOREIGN KEY (`lote_id`) REFERENCES `lote` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacina1` FOREIGN KEY (`vacina_id`) REFERENCES `vacina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacina_tem_lote`
--

LOCK TABLES `vacina_tem_lote` WRITE;
/*!40000 ALTER TABLE `vacina_tem_lote` DISABLE KEYS */;
INSERT INTO `vacina_tem_lote` VALUES (1,1,2,2),(2,2,3,10);
/*!40000 ALTER TABLE `vacina_tem_lote` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`vacina_tem_lote_BEFORE_INSERT` BEFORE INSERT ON `vacina_tem_lote` FOR EACH ROW
BEGIN
	DECLARE p_vencimento DATE;
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
    
    SELECT vencimento INTO p_vencimento FROM lote WHERE lote.id = NEW.lote_id;
    
    IF(p_vencimento < NOW()) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nImpossível cadastrar lote vencido.");
    END IF;
    
    IF (NEW.quantidade < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade não pode ser negativa.");
	END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`vacina_tem_lote_BEFORE_UPDATE` BEFORE UPDATE ON `vacina_tem_lote` FOR EACH ROW
BEGIN
	DECLARE p_vencimento DATE;
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "";
    
    SELECT vencimento INTO p_vencimento FROM lote WHERE lote.id = NEW.lote_id;
    
    IF(p_vencimento < NOW()) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nImpossível cadastrar lote vencido.");
    END IF;
    
    IF (NEW.quantidade < 0) THEN
		SET invalid = 1;
		SET error_message = CONCAT(error_message, "\nQuantidade não pode ser negativa.");
	END IF;
    
    IF (invalid > 0) THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = error_message;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'pet_shop'
--
/*!50003 DROP FUNCTION IF EXISTS `cnpj_valido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `cnpj_valido`(cnpj VARCHAR(14)) RETURNS tinyint(1)
BEGIN
	
    DECLARE indice INT;
    DECLARE multiplicador INT;
    DECLARE soma INT;
    DECLARE digito INT;
    DECLARE digito1 INT;
    DECLARE digito2 INT;
    
    IF(CHAR_LENGTH(cnpj) <> 14) THEN
		return FALSE;
	END IF;
    
    SET multiplicador = 5;
    SET indice = 1;
    SET soma = 0;
    
    WHILE(indice <= 12) DO
		
        SET digito = CAST(SUBSTRING(cnpj, indice, 1) AS UNSIGNED);
        SET soma = soma + (multiplicador * digito);
        
        IF(multiplicador = 2) THEN
			SET multiplicador = 9;
		ELSE
			SET multiplicador = multiplicador - 1;
        END IF;
        SET indice = indice + 1;
    END WHILE;
    
    SET digito1 = soma % 11;
    IF(digito1 < 2) THEN
		SET digito1 = 0;
	ELSE 
		SET digito1 = 11 - digito1;
    END IF;
    
    SET multiplicador = 6;
    SET indice = 1;
    SET soma = 0;
    
    WHILE(indice <= 13) DO
		
        SET digito = CAST(SUBSTRING(cnpj, indice, 1) AS UNSIGNED);
        SET soma = soma + (multiplicador * digito);
        
        IF(multiplicador = 2) THEN
			SET multiplicador = 9;
		ELSE
			SET multiplicador = multiplicador - 1;
        END IF;
        SET indice = indice + 1;
    END WHILE;
    
    SET digito2 = soma % 11;
    IF(digito2 < 2) THEN
		SET digito2 = 0;
	ELSE 
		SET digito2	= 11 - digito2;
    END IF;
        
	IF ((digito1 <> CAST(SUBSTRING(cnpj,13,1) AS UNSIGNED)) OR (digito2 <> CAST(SUBSTRING(cnpj,14,1) AS UNSIGNED))) THEN
		RETURN FALSE;
	END IF;
    
	RETURN TRUE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `cpf_valido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `cpf_valido`(cpf VARCHAR(14)) RETURNS tinyint(1)
BEGIN

	DECLARE indice INT;
    DECLARE digito CHAR;
    DECLARE temp_char CHAR;
    DECLARE all_equals BOOLEAN;
	DECLARE soma INT;
    DECLARE digito1 INT;
    DECLARE digito2 INT;

	IF(CHAR_LENGTH(cpf) <> 11) THEN
		RETURN FALSE;
	END IF;
    
    SET indice = 1;
    SET digito = SUBSTRING(cpf, 1, 1);
    SET all_equals = TRUE;
    
    WHILE(indice <= 11) DO
		SET temp_char = SUBSTRING(cpf, indice, 1);
        IF(temp_char <> digito) THEN
			SET all_equals = FALSE;
        END IF;
		SET indice = indice + 1;
    END WHILE;
    
    IF (all_equals) THEN
		RETURN FALSE;
    END IF;
    
    SET indice = 1;
    SET soma = 0;
    
    WHILE(indice <= 9) DO
		SET soma = soma + (CAST(SUBSTRING(cpf, indice, 1) AS UNSIGNED) * (11 - indice));
        SET indice = indice + 1;
    END WHILE;
    
    SET digito1 = (soma * 10) % 11;
    IF(digito1 > 9) THEN
		SET digito1 = 0;
    END IF;
    
    SET indice = 1;
    SET soma = 0;
    
    WHILE(indice <= 10) DO
		SET soma = soma + (CAST(SUBSTRING(cpf, indice, 1) AS UNSIGNED) * (12 - indice));
        SET indice = indice + 1;
    END WHILE;
    
    SET digito2 = (soma * 10) % 11;
    IF(digito2 > 9) THEN
		SET digito2 = 0;
    END IF;
    
    IF ((digito1 <> CAST(SUBSTRING(cpf,10,1) AS UNSIGNED)) OR (digito2 <> CAST(SUBSTRING(cpf,11,1) AS UNSIGNED))) THEN
		RETURN FALSE;
	END IF;
    
	RETURN TRUE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `email_valido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `email_valido`(email VARCHAR(50)) RETURNS tinyint(1)
BEGIN
	IF NOT (SELECT email REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$') THEN
		RETURN FALSE;
	ELSE
		RETURN TRUE;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `nome_valido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nome_valido`(nome VARCHAR(100)) RETURNS tinyint(1)
BEGIN

	IF NOT (SELECT nome REGEXP '^[A-Za-zÇçãÃâÂáÁàÀêÊéÉíÍóÓõÕôÔúÚ().`\ -]+$') THEN
		RETURN FALSE;
	ELSE
		RETURN TRUE;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `senha_valida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `senha_valida`(senha VARCHAR(50)) RETURNS tinyint(1)
BEGIN
	IF NOT (SELECT senha REGEXP BINARY '[a-z]' 
							AND senha REGEXP BINARY '[A-Z]' 
							AND senha REGEXP BINARY '[0-9]' 
                            AND CHAR_LENGTH(senha) >= 6 
                            AND CHAR_LENGTH(senha) <= 20) THEN
		RETURN FALSE;
    ELSE 
		RETURN TRUE;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `split_str` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `split_str`(
  x VARCHAR(255),
  delim VARCHAR(12),
  pos INT
) RETURNS varchar(255) CHARSET utf8
    DETERMINISTIC
BEGIN 
    RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `valida_senha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `valida_senha`(senha VARCHAR(50)) RETURNS tinyint(1)
BEGIN
	IF NOT (SELECT senha REGEXP BINARY '[a-z]' 
							AND senha REGEXP BINARY '[A-Z]' 
							AND senha REGEXP BINARY '[0-9]' 
                            AND CHAR_LENGTH(senha) >= 6 
                            AND CHAR_LENGTH(senha) <= 20) THEN
		RETURN FALSE;
    ELSE 
		RETURN TRUE;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altAnamnese` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altAnamnese`(
	IN p_id int
  , IN p_peso int
  , IN p_tamanho int
  , IN p_temperatura int
  , IN p_servico_agendado_id int
  , IN p_queixa varchar(100)
  , IN p_tempo_evolucao int
  , IN p_tratamento tinyint
  , IN p_medicacao_continua tinyint
  , IN p_alimentacao varchar(100)
  , IN p_fezes_normais tinyint
  , IN p_urina_normal tinyint
  , IN p_convulsao tinyint
  , IN p_desmaio tinyint
  , IN p_tosse tinyint
  , IN p_espirro tinyint
  , IN p_cansaco_facil tinyint
  , IN p_ambiente_vive varchar(100)
  , IN p_contato_animais tinyint
  , IN p_acesso_rua tinyint
  , IN p_castrado tinyint
  , IN p_doencas_anteriores varchar(100)
  , IN p_pulga tinyint
  , IN p_carrapato tinyint
)
BEGIN
	
    DECLARE c_anamnese INT;
    DECLARE c_servico_agendado INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_anamnese
    FROM anamnese
    WHERE anamnese.id = p_id;
    IF c_anamnese = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Anamnese não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_servico_agendado
    FROM servico_agendado
    WHERE servico_agendado.id = p_servico_agendado_id;
    IF c_servico_agendado = 0 AND p_servico_agendado_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Servico Agendado não cadastrado';
    END IF;
    
	IF p_peso IS NULL AND p_tamanho IS NULL AND p_temperatura IS NULL AND p_servico_agendado_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE anamnese
	   SET peso = CASE WHEN p_peso IS NULL THEN peso ELSE p_peso END
         , tamanho = CASE WHEN p_tamanho IS NULL THEN tamanho ELSE p_tamanho END
         , temperatura = CASE WHEN p_temperatura IS NULL THEN temperatura ELSE p_temperatura END
         , servico_agendado_id = CASE WHEN p_servico_agendado_id IS NULL THEN servico_agendado_id ELSE p_servico_agendado_id END
         , queixa = CASE WHEN p_queixa IS NULL THEN p_queixa ELSE queixa END
         , tempo_evolucao = CASE WHEN p_tempo_evolucao IS NULL THEN tempo_evolucao ELSE p_tempo_evolucao END
         , tratamento = CASE WHEN p_tratamento IS NULL THEN tratamento ELSE p_tratamento END
         , medicacao_continua = CASE WHEN p_medicacao_continua IS NULL THEN medicacao_continua ELSE p_medicacao_continua END
         , alimentacao = CASE WHEN p_alimentacao IS NULL THEN alimentacao ELSE p_alimentacao END
         , fezes_normais = CASE WHEN p_fezes_normais IS NULL THEN fezes_normais ELSE p_fezes_normais END
         , urina_normal = CASE WHEN p_urina_normal IS NULL THEN urina_normal ELSE p_urina_normal END
         , convulsao = CASE WHEN p_convulsao IS NULL THEN convulsao ELSE p_convulsao END
         , desmaio = CASE WHEN p_desmaio IS NULL THEN desmaio ELSE p_desmaio END
         , tosse = CASE WHEN p_tosse IS NULL THEN tosse ELSE p_tosse END
         , espirro = CASE WHEN p_espirro IS NULL THEN espirro ELSE p_espirro END
         , cansaco_facil = CASE WHEN p_cansaco_facil IS NULL THEN cansaco_facil ELSE p_cansaco_facil END
         , ambiente_vive = CASE WHEN p_ambiente_vive IS NULL THEN ambiente_vive ELSE p_ambiente_vive END
		 , contato_animais = CASE WHEN p_contato_animais IS NULL THEN contato_animais ELSE p_contato_animais END
         , acesso_rua = CASE WHEN p_acesso_rua IS NULL THEN acesso_rua ELSE p_acesso_rua END
         , castrado = CASE WHEN p_castrado IS NULL THEN castrado ELSE p_castrado END
         , doencas_anteriores = CASE WHEN p_doencas_anteriores IS NULL THEN doencas_anteriores ELSE p_doencas_anteriores END
         , pulga = CASE WHEN p_pulga IS NULL THEN pulga ELSE p_pulga END
         , carrapato = CASE WHEN p_carrapato IS NULL THEN carrapato ELSE p_carrapato END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altAnimal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altAnimal`(
	IN p_id INT
  , IN p_nome varchar(50)
  , IN p_sexo char(1)
  , IN p_data_nascimento datetime
  , IN p_pessoa_tem_funcao_id int
  , IN p_raca_id int
  , IN p_porte_id int
)
BEGIN

	DECLARE c_animal INT;
    DECLARE c_pessoa_tem_funcao INT;
    DECLARE c_raca INT;
    DECLARE c_porte INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;

	SELECT COUNT(*) INTO c_animal
    FROM animal
    WHERE animal.id = p_id;
    IF c_animal = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Animal não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa_tem_funcao
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_pessoa_tem_funcao_id;
    IF c_pessoa_tem_funcao = 0 AND p_pessoa_tem_funcao_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_raca
    FROM raca
    WHERE raca.id = p_raca_id;
    IF c_raca = 0 AND p_raca_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Raça não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_porte
    FROM porte
    WHERE porte.id = p_porte_id;
    IF c_porte = 0 AND p_porte_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte não cadastrado';
    END IF;

	IF p_nome IS NULL AND p_sexo IS NULL AND p_data_nascimento IS NULL AND p_pessoa_tem_funcao_id IS NULL AND p_raca_id IS NULL AND p_porte_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;

	UPDATE animal
	   SET 	nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
       ,	sexo = CASE WHEN p_sexo IS NULL THEN sexo ELSE p_sexo END
       ,	data_nascimento = CASE WHEN p_data_nascimento IS NULL THEN data_nascimento ELSE p_data_nascimento END
       ,	pessoa_tem_funcao_id = CASE WHEN p_pessoa_tem_funcao_id IS NULL THEN pessoa_tem_funcao_id ELSE p_pessoa_tem_funcao_id END
       ,	raca_id = CASE WHEN p_raca_id IS NULL THEN raca_id ELSE p_raca_id END
       ,	porte_id = CASE WHEN p_porte_id IS NULL THEN porte_id ELSE p_porte_id END
       
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altAnimalTemRestricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altAnimalTemRestricao`(
	IN p_id int
  , IN p_restricao_id int
  , IN p_animal_id int
)
BEGIN
	
    DECLARE c_animal_tem_restricao1 INT;
    DECLARE c_restricao INT;
    DECLARE c_animal INT;
    DECLARE c_animal_tem_restricao2 INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_animal_tem_restricao1
    FROM animal_tem_restricao
    WHERE animal_tem_restricao.id = p_id;
    IF c_animal_tem_restricao1 = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Animal Não possui restrição';
    END IF;
    
    SELECT COUNT(*) INTO c_restricao
    FROM restricao
    WHERE restricao.id = p_restricao_id;
    IF c_restricao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Restrição não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_animal
    FROM animal
    WHERE animal.id = p_animal_id;
    IF c_animal = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Animal não cadastrado';
    END IF;
    
    IF p_restricao_id IS NULL AND p_animal_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE animal_tem_restricao
       SET restricao_id = CASE WHEN p_restricao_id IS NULL THEN restricao_id ELSE p_restricao_id END
         , animal_id = CASE WHEN p_animal_id IS NULL THEN animal_id ELSE p_animal_id END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altAplicacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altAplicacao`(
	IN p_id int
  , IN p_data_hora datetime
  , IN p_aplicado tinyint
  , IN p_dose int
  , IN p_vacina_tem_lote_id int
  , IN p_servico_agendado_id int
)
BEGIN
	
    DECLARE c_aplicacao INT;
    DECLARE c_vacina_tem_lote INT;
    DECLARE c_servico_agendado INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_aplicacao
    FROM aplicacao
    WHERE aplicacao.id = p_id;
    IF c_aplicacao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Aplicação não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_vacina_tem_lote
    FROM vacina_tem_lote
    WHERE vacina_tem_lote.id = p_vacina_tem_lote_id;
    IF c_vacina_tem_lote = 0 AND p_vacina_tem_lote_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Vacina não possui Lote';
    END IF;
    
    SELECT COUNT(*) INTO c_servico_agendado
    FROM servico_agendado
    WHERE servico_agendado.id = p_servico_agendado_id;
    IF c_servico_agendado = 0 AND p_servico_agendado_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Servico Agendado não cadastrado';
    END IF;
    
    IF p_data_hora IS NULL AND p_aplicado IS NULL AND p_dose IS NULL AND p_vacina_tem_lote_id IS NULL AND p_servico_agendado_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE aplicacao
       SET data_hora = CASE WHEN p_data_hora IS NULL THEN data_hora ELSE p_data_hora END
         , aplicado = CASE WHEN p_aplicado IS NULL THEN aplicado ELSE p_aplicado END
         , dose = CASE WHEN p_dose IS NULL THEN dose ELSE p_dose END
         , vacina_tem_lote_id = CASE WHEN p_vacina_tem_lote_id IS NULL THEN vacina_tem_lote_id ELSE p_vacina_tem_lote_id END
         , servico_agendado_id = CASE WHEN p_servico_agendado_id IS NULL THEN servico_agendado_id ELSE p_servico_agendado_id END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altConfiguracao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altConfiguracao`(
	IN p_quantidade_animais int
  , IN p_periodos_dia int
)
BEGIN

    IF p_quantidade_animais IS NULL AND p_periodos_dia IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE configuracao
       SET quantidade_animais = CASE WHEN p_quantidade_animais IS NULL THEN quantidade_animais ELSE p_quantidade_animais END
         , periodos_dia = CASE WHEN p_periodos_dia IS NULL THEN periodos_dia ELSE p_periodos_dia END
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altEspecie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altEspecie`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	
    DECLARE c_nome_proprio VARCHAR(100);
    DECLARE c_especie INT;
    DECLARE c_nome INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*), nome INTO c_especie, c_nome_proprio
    FROM especie
    WHERE especie.id = p_id;
    IF c_especie = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Espécie não cadastrada';
    END IF;
    
    IF c_nome_proprio IS NOT NULL AND
		c_nome_proprio <> p_nome THEN
		SELECT COUNT(*) INTO c_nome
		FROM especie
		WHERE especie.nome = p_nome;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Espécie já cadastrada';
		END IF;
	END IF;
    
    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE pet_shop.especie
       SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altFuncao`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN

	DECLARE c_nome_proprio VARCHAR(100);
	DECLARE c_funcao INT;
    DECLARE c_nome INT;
	
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*), nome INTO c_funcao, c_nome_proprio
    FROM funcao
    WHERE funcao.id = p_id;
    IF c_funcao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Funcão não cadastrada';
    END IF;
    
    IF c_nome_proprio IS NOT NULL AND
		c_nome_proprio <> p_nome THEN
		SELECT COUNT(*) INTO c_nome
		FROM funcao
		WHERE funcao.nome = p_nome;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Função já cadastrada';
		END IF;
	END IF;
    
    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE pet_shop.funcao
       SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altGrupoDeItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altGrupoDeItem`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	
    DECLARE c_nome_proprio VARCHAR(100);
    DECLARE c_grupo_de_item INT;
    DECLARE c_nome INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*), nome INTO c_grupo_de_item, c_nome_proprio
    FROM grupo_de_item
    WHERE grupo_de_item.id = p_id;
    IF c_grupo_de_item = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Grupo de Item não cadastrado';
    END IF;
    
    IF c_nome_proprio IS NOT NULL AND
		c_nome_proprio <> p_nome THEN
		SELECT COUNT(*) INTO c_nome
		FROM grupo_de_item
		WHERE grupo_de_item.nome = p_nome;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Grupo de Item já cadastrado';
		END IF;
	END IF;
    
    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE grupo_de_item
       SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altItem`(
	IN p_id int
  , IN p_nome varchar(100)
  , IN p_preco decimal(10, 2)
  , IN p_quantidade int
  , IN p_grupo_de_item_id int
)
BEGIN

	DECLARE c_nome_proprio VARCHAR(100);
	DECLARE c_item INT;
    DECLARE c_nome INT;
    DECLARE c_grupo_de_item INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;

	SELECT COUNT(*), nome INTO c_item, c_nome_proprio
    FROM item
    WHERE item.id = p_id;
    IF c_item = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Item não cadastrado';
    END IF;
    
    IF c_nome_proprio IS NOT NULL AND
		c_nome_proprio <> p_nome THEN
		SELECT COUNT(*) INTO c_nome
		FROM item
		WHERE item.nome = p_nome;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Item já cadastrado';
		END IF;
    END IF;
    
    SELECT COUNT(*) INTO c_grupo_de_item
    FROM grupo_de_item
    WHERE grupo_de_item.id = p_grupo_de_item_id;
    IF c_grupo_de_item = 0 AND p_grupo_de_item_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Grupo de Item não cadastrado';
    END IF;

	IF p_nome IS NULL AND p_preco IS NULL AND p_quantidade IS NULL AND p_grupo_de_item_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE pet_shop.item
       SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
         , preco = CASE WHEN p_preco IS NULL THEN preco ELSE p_preco END
         , quantidade = CASE WHEN p_quantidade IS NULL THEN quantidade ELSE p_quantidade END
         , grupo_de_item_id = CASE WHEN p_grupo_de_item_id IS NULL THEN grupo_de_item_id ELSE p_grupo_de_item_id END
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altItemDeVenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altItemDeVenda`(
	IN p_id int
  , IN p_preco decimal(10, 2)
  , IN p_quantidade int
  , IN p_item_id int
  , IN p_pedido_id int
)
BEGIN

	DECLARE c_item_de_venda INT;
	DECLARE c_item INT;
    DECLARE c_pedido INT;	
	
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_item_de_venda
    FROM item_de_venda
    WHERE item_de_venda.id = p_id;
    IF c_item_de_venda = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Item de Venda não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_item
    FROM item
    WHERE item.id = p_item_id;
    IF c_item = 0 AND p_item_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Item não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_pedido
    FROM pedido
    WHERE pedido.id = p_pedido_id;
    IF c_pedido = 0 AND p_pedido_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pedido não cadastrado';
    END IF;
    
    IF p_preco IS NULL AND p_quantidade IS NULL AND p_item_id IS NULL AND p_pedido_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE item_de_venda
       SET preco = CASE WHEN p_preco IS NULL THEN preco ELSE p_preco END
         , quantidade = CASE WHEN p_quantidade IS NULL THEN quantidade ELSE p_quantidade END
         , item_id = CASE WHEN p_item_id IS NULL THEN item_id ELSE p_item_id END
         , pedido_id = CASE WHEN p_pedido_id IS NULL THEN pedido_id ELSE p_pedido_id END
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altLembrete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altLembrete`(
	IN p_id int
  , IN p_descricao varchar(200)
  , IN p_data_hora datetime
  , IN p_executado tinyint(1)
  , IN p_pessoa_id INT
)
BEGIN
	
    DECLARE c_lembrete INT;
    DECLARE c_pessoa INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_lembrete
    FROM lembrete
    WHERE lembrete.id = p_id;
    IF c_lembrete = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lembrete não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa
    FROM pessoa
    WHERE pessoa.id = p_pessoa_id;
    IF c_pessoa = 0 AND p_pessoa_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
    IF p_descricao IS NULL AND p_data_hora IS NULL AND p_executado IS NULL AND p_pessoa_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE lembrete
       SET descricao = CASE WHEN p_descricao IS NULL THEN descricao ELSE p_descricao END
         , data_hora = CASE WHEN p_data_hora IS NULL THEN data_hora ELSE p_data_hora END
         , executado = CASE WHEN p_executado IS NULL THEN executado ELSE p_executado END
         , pessoa_id = CASE WHEN p_pessoa_id IS NULL THEN pessoa_id ELSE p_pessoa_id END
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altLote`(
	IN p_id int
  , IN p_numero varchar(50)
  , IN p_vencimento date
  , IN p_preco decimal(10, 2)
)
BEGIN
	
    DECLARE c_numero_proprio VARCHAR(100);
    DECLARE c_lote INT;
    DECLARE c_numero INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*), numero INTO c_lote, c_numero_proprio
    FROM lote
    WHERE lote.id = p_id;
    IF c_lote = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lote não cadastrado';
    END IF;
    
    IF c_numero_proprio IS NOT NULL AND
		c_numero_proprio <> p_numero THEN
		SELECT COUNT(*) INTO c_numero
		FROM lote
		WHERE lote.numero = p_numero;
		IF c_numero > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Lote já cadastrado';
		END IF;
    END IF;

	IF p_numero IS NULL AND p_vencimento IS NULL AND p_preco IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE lote
       SET numero = CASE WHEN p_numero IS NULL THEN numero ELSE p_numero END
         , vencimento = CASE WHEN p_vencimento IS NULL THEN vencimento ELSE p_vencimento END
         , preco = CASE WHEN p_preco IS NULL THEN preco ELSE p_preco END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altOAuth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altOAuth`(
		IN p_id INT
    ,	IN p_token VARCHAR(100)
    ,	IN p_refresh_token VARCHAR(100)
)
BEGIN
	
    DECLARE c_token INT;
    DECLARE c_refresh_token INT;
	DECLARE error_message VARCHAR(100);
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    IF token IS NULL OR refresh_token IS NULL THEN
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
	SELECT count(*)
	INTO c_token
	FROM oauth
	WHERE oauth.token = p_token;
	IF c_token > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Token já está em uso';
	END IF;
    
    SELECT count(*)
	INTO c_refresh_token
	FROM oauth
	WHERE oauth.refresh_token = p_refresh_token;
	IF c_refresh_token > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Refresh Token já está em uso';
	END IF;
    
    IF p_token IS NULL OR p_refresh_token IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
    UPDATE oauth
	   SET token = CASE WHEN p_token IS NULL THEN token ELSE p_token END
         , refresh_token = CASE WHEN p_refresh_token IS NULL THEN refresh_token ELSE p_refresh_token END
	   WHERE id = p_id;
	
    SELECT p_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPedido`(
	IN p_id int
  , IN p_valor decimal(10, 2)
  , IN p_desconto decimal(10, 2)
  , IN p_transacao_id int
  , IN p_cliente_id int
  , IN p_funcionario_id int
)
BEGIN

	DECLARE c_pedido INT;
    DECLARE c_transacao INT;
    DECLARE c_cliente INT;
    DECLARE c_funcionario INT;
	
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_pedido
    FROM pedido
    WHERE pedido.id = p_id;
    IF c_pedido = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pedido não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_transacao
    FROM transacao
    WHERE transacao.id = p_transacao_id;
    IF c_transacao = 0 AND p_transacao_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Transação não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_cliente
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_cliente_id;
    IF c_cliente = 0 AND p_cliente_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Cliente não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_funcionario
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_funcionario_id;
    IF c_funcionario = 0 AND p_funcionario_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Funcionário não cadastrado';
    END IF;
	
    IF p_valor IS NULL AND p_desconto IS NULL AND p_transacao_id IS NULL AND p_cliente_id IS NULL AND p_funcionario_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE pet_shop.pedido
       SET valor = CASE WHEN p_valor IS NULL THEN valor ELSE p_valor END
         , desconto = CASE WHEN p_desconto IS NULL THEN desconto ELSE p_desconto END
         , transacao_id = CASE WHEN p_transacao_id IS NULL THEN transacao_id ELSE p_transacao_id END
         , cliente_id = CASE WHEN p_cliente_id IS NULL THEN cliente_id ELSE p_cliente_id END
         , funcionario_id = CASE WHEN p_funcionario_id IS NULL THEN funcionario_id ELSE p_funcionario_id END
	 WHERE id = p_id;
	
    SELECT p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPermissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPermissao`(
	IN p_id int
  , IN p_modulo varchar(50)
)
BEGIN
    
    DECLARE c_modulo_proprio VARCHAR(100);
    DECLARE c_permissao INT;
    DECLARE c_nome INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*), modulo INTO c_permissao, c_modulo_proprio
    FROM permissao
    WHERE permissao.id = p_id;
    IF c_permissao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Permissão não cadastrada';
    END IF;
    
    IF c_modulo_proprio IS NOT NULL AND
		c_modulo_proprio <> p_modulo THEN
		SELECT COUNT(*) INTO c_nome
		FROM permissao
		WHERE permissao.modulo = p_modulo;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Módulo já cadastrado';
		END IF;
    END IF;
    
    IF p_modulo IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
	
	UPDATE permissao
		SET modulo = CASE WHEN p_modulo IS NULL THEN modulo ELSE p_modulo END
	 WHERE id = p_id;
     
	SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPessoa`(
	IN p_id int
  , IN p_nome varchar(100)
  , IN p_email varchar(50)
  , IN p_registro varchar(14)
  , IN p_logradouro varchar(100)
  , IN p_numero int
  , IN p_complemento varchar(50)
  , IN p_cep varchar(8)
  , IN p_ponto_de_referencia varchar(200)
  , IN p_cidade varchar(100)
  , IN p_estado varchar(100)
  , IN p_estado_uf varchar(2)
  , IN p_pais varchar(100)
  , IN p_rg varchar(10)
  , IN p_inscricao varchar(10)
  , IN p_orgao varchar(10)
  , IN p_bairro varchar(100)
)
BEGIN
	
    DECLARE c_email_proprio VARCHAR(100);
    DECLARE c_registro_proprio VARCHAR(100);
    DECLARE c_rg_proprio VARCHAR(100);
    
    DECLARE c_pessoa INT;
	DECLARE c_email INT;
    DECLARE c_registro INT;
    DECLARE c_rg INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*), email, registro, rg INTO c_pessoa, c_email_proprio,
		c_registro_proprio, c_rg_proprio
		FROM pessoa
		WHERE pessoa.id = p_id;
	IF c_pessoa = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
	END IF;
    
    IF c_email_proprio IS NOT NULL AND
		c_email_proprio <> p_email THEN
		SELECT COUNT(*) INTO c_email
		FROM pessoa
		WHERE pessoa.email = p_email;
		IF c_email > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Email já está sendo utilizado por outra pessoa';
		END IF;
	END IF;
    
    IF c_registro_proprio IS NOT NULL AND
		c_registro_proprio <> p_registro THEN
		SELECT COUNT(*) INTO c_registro
		FROM pessoa
		WHERE pessoa.registro = p_registro;
		IF c_registro > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Registro já está sendo utilizado por outra pessoa';
		END IF;
	END IF;
    
    IF c_rg_proprio IS NOT NULL AND
		c_rg_proprio <> p_rg THEN
		SELECT count(*)
		INTO c_rg
		FROM pet_shop.pessoa p
		WHERE p.rg = p_rg;
		IF c_rg > 0 AND p_rg IS NOT NULL THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'RG já está sendo utilizado por outra pessoa';
		END IF;
	END IF;
    
    IF p_nome IS NULL AND p_email IS NULL AND p_registro IS NULL 
    AND p_logradouro IS NULL AND p_numero IS NULL AND p_cep IS NULL 
    AND p_cidade IS NULL AND p_estado IS NULL AND p_estado_uf IS NULL 
    AND p_pais IS NULL AND p_bairro IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE pet_shop.pessoa
	   SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
         , email = CASE WHEN p_email IS NULL THEN email ELSE p_email END
         , registro = CASE WHEN p_registro IS NULL THEN registro ELSE p_registro END
         , logradouro = CASE WHEN p_logradouro IS NULL THEN logradouro ELSE p_logradouro END
         , numero = CASE WHEN p_numero IS NULL THEN numero ELSE p_numero END
         , complemento = CASE WHEN p_complemento IS NULL THEN complemento ELSE p_complemento END
         , cep = CASE WHEN p_cep IS NULL THEN cep ELSE p_cep END
         , ponto_de_referencia = CASE WHEN p_ponto_de_referencia IS NULL THEN ponto_de_referencia ELSE p_ponto_de_referencia END
         , cidade = CASE WHEN p_cidade IS NULL THEN cidade ELSE p_cidade END
         , estado = CASE WHEN p_estado IS NULL THEN estado ELSE p_estado END
         , uf = CASE WHEN p_estado_uf IS NULL THEN uf ELSE p_estado_uf END
         , pais = CASE WHEN p_pais IS NULL THEN pais ELSE p_pais END
         , rg = CASE WHEN p_rg IS NULL THEN rg ELSE p_rg END
         , inscricao_estadual = CASE WHEN p_inscricao IS NULL THEN inscricao_estadual ELSE p_inscricao END
         , orgao_expedidor = CASE WHEN p_orgao IS NULL THEN orgao_expedidor ELSE p_orgao END
         , bairro = CASE WHEN p_bairro IS NULL THEN bairro ELSE p_bairro END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPessoaTemFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPessoaTemFuncao`(
	IN p_id int
  , IN p_pessoa_id int
  , IN p_funcao_id int
  , IN p_password varchar(50)
  , IN p_oauth_id int
)
BEGIN

	DECLARE c_pessoa_tem_funcao1 INT;
	DECLARE c_pessoa INT;
    DECLARE c_funcao INT;
    DECLARE c_pessoa_tem_funcao2 INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT count(*) INTO c_pessoa_tem_funcao1
      FROM pessoa_tem_funcao
	 WHERE pessoa_tem_funcao.id = p_id;
	IF c_pessoa_tem_funcao1 = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma Função atribuída à Pessoa';
	END IF;
    
    SELECT count(*) INTO c_pessoa
      FROM pessoa
	 WHERE pessoa.id = p_pessoa_id;
	IF c_pessoa = 0 AND p_pessoa_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
	END IF;
    
    SELECT count(*) INTO c_funcao
      FROM funcao
	 WHERE funcao.id = p_funcao_id;
	IF c_funcao = 0 AND p_funcao_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Função não cadastrada';
	END IF;
    
    IF p_pessoa_id IS NULL AND p_funcao_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;

	UPDATE pessoa_tem_funcao
	   SET pessoa_id = CASE WHEN p_pessoa_id IS NULL THEN pessoa_id ELSE p_pessoa_id END
         , funcao_id = CASE WHEN p_funcao_id IS NULL THEN funcao_id ELSE p_funcao_id END
         , password = CASE WHEN p_password IS NULL THEN password ELSE p_password END
         , oauth_id = CASE WHEN p_oauth_id IS NULL THEN oauth_id ELSE p_oauth_id END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPessoaTemPermissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPessoaTemPermissao`(
	IN p_id int
  , IN p_pessoa_tem_funcao_id int
  , IN p_permissoes_id int
)
BEGIN
	
	DECLARE c_pessoa_tem_permissoes1 INT;
    DECLARE c_pessoa_tem_funcao INT;
    DECLARE c_permissao INT;
	DECLARE c_pessoa_tem_permissoes2 INT;
        
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT count(*) INTO c_pessoa_tem_permissoes1
      FROM pessoa_tem_permissao
	 WHERE pessoa_tem_permissao.id = p_id;
	IF c_pessoa_tem_permissoes1 = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não possui Restrição';
	END IF;
    
    SELECT COUNT(*) INTO c_pessoa_tem_funcao
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_pessoa_tem_funcao_id;
    IF c_pessoa_tem_funcao = 0 AND p_pessoa_tem_funcao_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
	SELECT COUNT(*) INTO c_permissao
    FROM permissao
    WHERE permissao.id = p_permissoes_id;
    IF c_permissao = 0 AND p_permissoes_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Permissão não cadastrado';
    END IF;
    
    IF p_pessoa_tem_funcao_id IS NULL AND p_permissoes_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE pessoa_tem_permissao
	   SET pessoa_tem_funcao_id = CASE WHEN p_pessoa_tem_funcao_id IS NULL THEN pessoa_tem_funcao_id ELSE p_pessoa_tem_funcao_id END
         , permissoes_id = CASE WHEN p_permissoes_id IS NULL THEN permissoes_id ELSE p_permissoes_id END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPessoaTemRedeSocial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPessoaTemRedeSocial`(
	IN p_id int
  , IN p_perfil varchar(200)
  , IN p_rede_social_id int
  , IN p_pessoa_id int
)
BEGIN

	DECLARE c_pessoa_tem_rede_social1 INT;
	DECLARE c_rede_social INT;
    DECLARE c_pessoa INT;
    DECLARE c_pessoa_tem_rede_social2 INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa_tem_rede_social1
    FROM pessoa_tem_rede_social
    WHERE pessoa_tem_rede_social.id = p_id;
    IF c_pessoa_tem_rede_social1 = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não possui Rede Social';
    END IF;
    
    SELECT COUNT(*) INTO c_rede_social
    FROM rede_social
    WHERE rede_social.id = p_rede_social_id;
    IF c_rede_social = 0 AND p_rede_social_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Rede Social não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa
    FROM pessoa
    WHERE pessoa.id = p_pessoa_id;
    IF c_pessoa = 0 AND p_pessoa_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
    IF p_perfil IS NULL AND p_rede_social_id IS NULL AND p_pessoa_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE pessoa_tem_rede_social
	   SET perfil = CASE WHEN p_perfil IS NULL THEN perfil ELSE p_perfil END
         , rede_social_id = CASE WHEN p_rede_social_id IS NULL THEN rede_social_id ELSE p_rede_social_id END
         , pessoa_id = CASE WHEN p_pessoa_id IS NULL THEN pessoa_id ELSE p_pessoa_id END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPorte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPorte`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_tamanho_minimo int
  , IN p_tamanho_maximo int
  , IN p_peso_minimo int
  , IN p_peso_maximo int
)
BEGIN

	DECLARE c_nome_proprio VARCHAR(100);
    DECLARE c_porte INT;
	DECLARE c_nome INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT count(*), nome INTO c_porte, c_nome_proprio
      FROM porte
	 WHERE porte.id = p_id;
	IF c_porte = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte não cadastrado';
	END IF;
    
    IF c_nome_proprio IS NOT NULL AND
		c_nome_proprio <> p_nome THEN
		SELECT count(*) INTO c_nome
		FROM porte
		WHERE porte.nome = p_nome;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Porte já cadastrado';
		END IF;
	END IF;
	
    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE porte
	   SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
         , tamanho_minimo = CASE WHEN p_tamanho_minimo IS NULL THEN tamanho_minimo ELSE p_tamanho_minimo END
         , tamanho_maximo = CASE WHEN p_tamanho_maximo IS NULL THEN tamanho_maximo ELSE p_tamanho_maximo END
         , peso_minimo = CASE WHEN p_peso_minimo IS NULL THEN peso_minimo ELSE p_peso_minimo END
         , peso_maximo = CASE WHEN p_peso_maximo IS NULL THEN peso_maximo ELSE p_peso_maximo END
	 WHERE id = p_id;
     
	SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altRaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altRaca`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_especie_id int
  , IN p_porte_id int
)
BEGIN

	DECLARE c_nome_proprio VARCHAR(100);
    DECLARE c_raca INT;
    DECLARE c_especie INT;
    DECLARE c_porte INT;
    DECLARE c_nome INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
	SELECT COUNT(*), nome INTO c_raca, c_nome_proprio
    FROM raca
    WHERE raca.id = p_id;
    IF c_raca = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Raça não cadastrada';
	END IF;
    
    SELECT COUNT(*) INTO c_especie
    FROM especie
    WHERE especie.id = p_especie_id;
    IF c_especie = 0 AND p_especie_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Espécie não cadastrada';
	END IF;
    
    SELECT COUNT(*) INTO c_porte
    FROM porte
    WHERE porte.id = p_porte_id;
    IF c_porte = 0 AND p_porte_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte não cadastrada';
	END IF;
    
    IF c_nome_proprio IS NOT NULL AND
		c_nome_proprio <> p_nome THEN
		SELECT COUNT(*) INTO c_nome
		FROM raca
		WHERE raca.nome = p_nome;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Raça já cadastrada';
		END IF;
	END IF;

    IF p_nome IS NULL AND p_especie_id IS NULL AND p_porte_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE raca
	   SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
         , especie_id = CASE WHEN p_especie_id IS NULL THEN especie_id ELSE p_especie_id END
         , porte_id = CASE WHEN p_porte_id IS NULL THEN porte_id ELSE p_porte_id END
	 WHERE id = p_id;
     
	SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altRedeSocial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altRedeSocial`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN

	DECLARE c_nome_proprio VARCHAR(100);
	DECLARE c_rede_social INT;
    DECLARE c_nome INT;
	
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*), nome INTO c_rede_social, c_nome_proprio
    FROM rede_social
    WHERE rede_social.id = p_id;
    IF c_rede_social = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Rede Social não cadastrada';
	END IF;
    
    IF c_nome_proprio IS NOT NULL AND
		c_nome_proprio <> p_nome THEN
		SELECT COUNT(*) INTO c_nome
		FROM rede_social
		WHERE rede_social.nome = p_nome;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Rede Social já cadastrada';
		END IF;
    END IF;

    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE rede_social
	   SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altRestricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altRestricao`(
	IN p_id int
  , IN p_restricao varchar(50)
  , IN p_descricao varchar(200)
)
BEGIN
	
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;

    IF p_restricao IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE restricao
	   SET restricao = CASE WHEN p_restricao IS NULL THEN restricao ELSE p_restricao END
         , descricao = CASE WHEN p_descricao IS NULL THEN descricao ELSE p_descricao END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altServico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altServico`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	
    DECLARE c_servico INT;
    DECLARE c_nome INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;

	SELECT count(*) INTO c_servico
	FROM servico
	WHERE servico.id = p_id;
	IF c_servico = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço não cadastrado';
	END IF;
    
    SELECT count(*) INTO c_nome
	FROM servico
	WHERE servico.nome = p_nome;
	IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço já cadastrado';
	END IF;

    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE servico
	   SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altServicoAgendado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altServicoAgendado`(
	IN p_id int
  , IN p_preco decimal(10, 2)
  , IN p_recorrente tinyint(1)
  , IN p_data_hora datetime
  , IN p_servico_id int
  , IN p_animal_id int
  , IN p_servico_contratado_id int
  , IN p_executado tinyint(1)
  , IN p_pago tinyint(1)
  , IN p_observacao varchar(200)
  , IN p_data_hora_executado datetime
  , IN p_funcionario_executa_id int
  , IN p_cancelado tinyint(1)
)
BEGIN

	DECLARE c_servico_agendado INT;
    DECLARE c_servico INT;
    DECLARE c_animal INT;
    DECLARE c_servico_contratado INT;
    DECLARE c_funcionario INT;
    DECLARE c_servico_tem_porte INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT count(*) INTO c_servico_agendado
	FROM servico_agendado
	WHERE servico_agendado.id = p_id;
	IF c_servico_agendado = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço Agendado não cadastrado';
	END IF;
    
    SELECT count(*) INTO c_servico
	FROM servico
	WHERE servico.id = p_servico_id;
	IF c_servico = 0 AND p_servico_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço não cadastrado';
	END IF;
    
    SELECT count(*) INTO c_animal
	FROM animal
	WHERE animal.id = p_animal_id;
	IF c_animal = 0 AND p_animal_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Animal não cadastrado';
	END IF;
    
    SELECT count(*) INTO c_servico_contratado
	FROM servico_contratado
	WHERE servico_contratado.id = p_servico_contratado_id;
	IF c_servico_contratado = 0 AND p_servico_contratado_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço Cadastrado não cadastrado';
	END IF;
    
    SELECT count(*) INTO c_funcionario
	FROM pessoa_tem_funcao
	WHERE pessoa_tem_funcao.id = p_funcionario_executa_id;
	IF c_funcionario = 0 AND p_funcionario_executa_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Funcionário não cadastrado';
	END IF;
    
    IF p_preco IS NULL AND p_recorrente IS NULL AND p_data_hora IS NULL
    AND p_servico_id IS NULL AND p_animal_id IS NULL AND p_servico_contratado_id IS NULL
    AND p_executado IS NULL AND p_pago IS NULL AND p_observacao IS NULL 
    AND p_data_hora_executado IS NULL AND p_funcionario_executa_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
    SELECT stp.id INTO c_servico_tem_porte
    FROM servico_tem_porte as stp
    INNER JOIN porte as p
    ON stp.porte_id = p.id
    WHERE stp.servico_id = p_servico_id
    AND stp.porte_id = (SELECT a.porte_id FROM animal as a WHERE a.id = p_animal_id);
    
	UPDATE servico_agendado
	   SET preco = CASE WHEN p_preco IS NULL THEN preco ELSE p_preco END
         , recorrente = CASE WHEN p_recorrente IS NULL THEN recorrente ELSE p_recorrente END
         , data_hora = CASE WHEN p_data_hora IS NULL THEN data_hora ELSE p_data_hora END
         , servico_tem_porte_id = CASE WHEN p_servico_id IS NULL THEN servico_tem_porte_id ELSE c_servico_tem_porte END
         , animal_id = CASE WHEN p_animal_id IS NULL THEN animal_id ELSE p_animal_id END
         , servico_contratado_id = CASE WHEN p_servico_contratado_id IS NULL THEN servico_contratado_id ELSE p_servico_contratado_id END
         , executado = CASE WHEN p_executado IS NULL THEN executado ELSE p_executado END
         , pago = CASE WHEN p_pago IS NULL THEN pago ELSE p_pago END
         , observacao = CASE WHEN p_observacao IS NULL THEN observacao ELSE p_observacao END
         , data_hora_executado = CASE WHEN p_data_hora_executado IS NULL THEN data_hora_executado ELSE p_data_hora_executado END
         , funcionario_executa_id = CASE WHEN p_funcionario_executa_id IS NULL THEN funcionario_executa_id ELSE p_funcionario_executa_id END
         , cancelado = CASE WHEN p_cancelado IS NULL THEN cancelado ELSE p_cancelado END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altServicoContratado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altServicoContratado`(
	IN p_id int
  , IN p_pessoa_tem_funcao_id_funcionario int
  , IN p_preco decimal(10, 2)
  , IN p_transacao_id int
)
BEGIN
	
    DECLARE c_servico_contratado INT;
    DECLARE c_transacao INT;
    DECLARE c_funcionario INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT count(*) INTO c_servico_contratado
	FROM servico_contratado
	WHERE servico_contratado.id = p_id;
	IF c_servico_contratado = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço Contratado não cadastrado';
	END IF;
    
    SELECT count(*) INTO c_transacao
	FROM transacao
	WHERE transacao.id = p_transacao_id;
	IF c_transacao = 0 AND p_transacao_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Transação não cadastrada';
	END IF;
    
    SELECT count(*) INTO c_funcionario
	FROM pessoa_tem_funcao
	WHERE pessoa_tem_funcao.id = p_pessoa_tem_funcao_id_funcionario;
	IF c_funcionario = 0 AND p_pessoa_tem_funcao_id_funcionario IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Funcionário não cadastrada';
	END IF;
    
    IF p_preco IS NULL AND p_transacao_id IS NULL AND p_pessoa_tem_funcao_id_funcionario IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE servico_contratado
	   SET pessoa_tem_funcao_id_funcionario = CASE WHEN p_pessoa_tem_funcao_id_funcionario IS NULL THEN pessoa_tem_funcao_id_funcionario ELSE p_pessoa_tem_funcao_id_funcionario END
         , preco = CASE WHEN p_preco IS NULL THEN preco ELSE p_preco END
         , transacao_id = CASE WHEN p_transacao_id IS NULL THEN transacao_id ELSE p_transacao_id END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altServicoTemPorte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altServicoTemPorte`(
	IN p_id int
  , IN p_servico_id int
  , IN p_porte_id int
  , IN p_preco decimal(10, 2)
)
BEGIN

	DECLARE c_servico_tem_porte1 INT;
    DECLARE c_servico INT;
    DECLARE c_porte INT;
    DECLARE c_servico_tem_porte2 INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT count(*) INTO c_servico_tem_porte1
	FROM servico_tem_porte
	WHERE servico_tem_porte.id = p_id;
	IF c_servico_tem_porte1 = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço não possui Porte';
	END IF;
    
    SELECT count(*) INTO c_servico
	FROM servico
	WHERE servico.id = p_servico_id;
	IF c_servico = 0 AND p_servico_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço não cadastrado';
	END IF;
    
    SELECT count(*) INTO c_porte
	FROM porte
	WHERE porte.id = p_porte_id;
	IF c_porte = 0 AND p_porte_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte não cadastrado';
	END IF;

    IF p_servico_id IS NULL AND p_porte_id IS NULL AND p_preco IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE servico_tem_porte
	   SET servico_id = CASE WHEN p_servico_id IS NULL THEN servico_id ELSE p_servico_id END
         , porte_id = CASE WHEN p_porte_id IS NULL THEN porte_id ELSE p_porte_id END
         , preco = CASE WHEN p_preco IS NULL THEN preco ELSE p_preco END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altTelefone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altTelefone`(
	IN p_id int
  , IN p_numero int
  , IN p_codigo_area int
  , IN p_codigo_pais varchar(3)
  , IN p_pessoa_id int
)
BEGIN
    
    DECLARE c_telefone INT;
    DECLARE c_pessoa INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_telefone
    FROM telefone
    WHERE telefone.id = p_id;
    IF c_telefone = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Telefone não cadastrado';
	END IF;
    
    SELECT COUNT(*) INTO c_pessoa
    FROM telefone
    WHERE telefone.pessoa_id = p_pessoa_id;
    IF c_pessoa = 0 AND p_pessoa_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrado';
	END IF;
    
    SELECT COUNT(*) INTO c_telefone 
    FROM telefone 
    WHERE telefone.codigo_area = p_codigo_area 
    AND telefone.codigo_pais = p_codigo_pais 
    AND telefone.numero = p_numero;
    IF c_telefone > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Telefone já cadastrado';
	END IF;
    
    IF p_numero IS NULL AND p_codigo_area IS NULL AND p_codigo_pais IS NULL AND p_pessoa_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE telefone
	   SET numero = CASE WHEN p_numero IS NULL THEN numero ELSE p_numero END
         , codigo_area = CASE WHEN p_codigo_area IS NULL THEN codigo_area ELSE p_codigo_area END
         , codigo_pais = CASE WHEN p_codigo_pais IS NULL THEN codigo_pais ELSE p_codigo_pais END
         , pessoa_id = CASE WHEN p_pessoa_id IS NULL THEN pessoa_id ELSE p_pessoa_id END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altTransacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altTransacao`(
	IN p_id int
  , IN p_tipo char(1)
  , IN p_valor decimal(10, 2)
  , IN p_comentario varchar(100)
)
BEGIN
	
	DECLARE c_transacao INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_transacao
    FROM transacao
    WHERE transacao.id = p_id;
    IF c_transacao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Transação não cadastrada';
	END IF;

    IF p_tipo IS NULL AND p_valor IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE transacao
	   SET tipo = CASE WHEN p_tipo IS NULL THEN tipo ELSE p_tipo END
         , valor = CASE WHEN p_valor IS NULL THEN valor ELSE p_valor END
         , comentario = CASE WHEN p_comentario IS NULL THEN comentario ELSE p_comentario END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altVacina` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altVacina`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_dose int
  , IN p_intervalo int
)
BEGIN
	
    DECLARE c_nome_proprio VARCHAR(100);
    DECLARE c_vacina INT;
    DECLARE c_lote INT;
    DECLARE c_nome INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*), nome INTO c_vacina, c_nome_proprio
    FROM vacina
    WHERE vacina.id = p_id;
    IF c_vacina = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Vacina não cadastrada';
	END IF;
    
    IF c_nome_proprio IS NOT NULL AND
		c_nome_proprio <> p_nome THEN
		SELECT COUNT(*) INTO c_nome
		FROM vacina
		WHERE vacina.nome = p_nome;
		IF c_nome > 0 THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = 'Vacina já cadastrada';
		END IF;
    END IF;

    IF p_nome IS NULL AND p_dose IS NULL AND p_intervalo IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;
    
	UPDATE vacina
	   SET nome = CASE WHEN p_nome IS NULL THEN nome ELSE p_nome END
         , dose = CASE WHEN p_dose IS NULL THEN dose ELSE p_dose END
         , intervalo = CASE WHEN p_intervalo IS NULL THEN intervalo ELSE p_intervalo END
	 WHERE id = p_id;
	
    SELECT p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altVacinaTemLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altVacinaTemLote`(
		IN p_id INT
	,	IN p_vacina_id INT
    ,	IN p_lote_id INT
    , 	IN p_quantidade INT
)
BEGIN
	
    DECLARE c_vacina_tem_lote1 INT;
	DECLARE c_vacina INT;
    DECLARE c_lote INT;
    DECLARE c_vacina_tem_lote2 INT;
    
    IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT count(*) INTO c_vacina_tem_lote1
      FROM vacina_tem_lote
	 WHERE vacina_tem_lote.id = p_id;
	IF c_vacina_tem_lote1 = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lote não atribuído à Vacina';
	END IF;
    
    SELECT count(*) INTO c_vacina
      FROM vacina
	 WHERE vacina.id = p_vacina_id;
	IF c_vacina = 0 AND p_vacina_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Vacina não cadastrada';
	END IF;
    
    SELECT count(*) INTO c_lote
      FROM lote
	 WHERE lote.id = p_lote_id;
	IF c_lote = 0 AND p_lote_id IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lote não cadastrada';
	END IF;
    
    IF p_vacina_id IS NULL AND p_lote_id IS NULL AND p_quantidade IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;

	UPDATE vacina_tem_lote
	   SET vacina_id = CASE WHEN p_vacina_id IS NULL THEN vacina_id ELSE p_vacina_id END
         , lote_id = CASE WHEN p_lote_id IS NULL THEN lote_id ELSE p_lote_id END
		 , quantidade = CASE WHEN p_quantidade IS NULL THEN quantidade ELSE p_quantidade END
     WHERE id = p_id;
	
    SELECT p_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delAnamnese` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delAnamnese`(
	IN p_id int
)
BEGIN

	DECLARE c_anamnese INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_anamnese
    FROM anamnese
    WHERE anamnese.id = p_id;
    IF c_anamnese = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Anamnese não cadastrada';
    END IF;

	DELETE FROM anamnese
	 WHERE id = p_id;
     
	SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delAnimal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delAnimal`(
	IN p_id int
)
BEGIN

	DECLARE c_animal INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_animal
    FROM animal
    WHERE animal.id = p_id;
    IF c_animal = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Animal não cadastrado';
    END IF;

	DELETE FROM animal
	WHERE id = p_id;
     
	SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delAnimalTemRestricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delAnimalTemRestricao`(
	IN p_id int
)
BEGIN

	DECLARE c_animal_tem_restricao INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_animal_tem_restricao
    FROM animal_tem_restricao
    WHERE animal_tem_restricao.id = p_id;
    IF c_animal_tem_restricao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Animal não possui Restrição';
    END IF;

	DELETE FROM animal_tem_restricao
	WHERE id = p_id;
    
    SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delAplicacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delAplicacao`(
	IN p_id int
)
BEGIN
	
    DECLARE c_aplicacao INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_aplicacao
    FROM aplicacao
    WHERE aplicacao.id = p_id;
    IF c_aplicacao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Aplicação não cadastrada';
    END IF;

	DELETE FROM aplicacao
	WHERE id = p_id;

	SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delConfiguracao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delConfiguracao`(
	IN p_id int
)
BEGIN
	
    DECLARE c_configuracao INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_configuracao
    FROM configuracao
    WHERE configuracao.id = p_id;
    IF c_configuracao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Configuração não cadastrada';
    END IF;

	DELETE FROM configuracao
	WHERE id = p_id;

	SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delEspecie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delEspecie`(
	IN p_id int
)
BEGIN

	DECLARE c_especie INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_especie
    FROM especie
    WHERE especie.id = p_id;
    IF c_especie = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Espécie não cadastrada';
    END IF;

	DELETE FROM especie
	WHERE id = p_id;
	
	SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delFuncao`(
	IN p_id int
)
BEGIN

	DECLARE c_funcao INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_funcao
    FROM funcao
    WHERE funcao.id = p_id;
    IF c_funcao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Função não cadastrada';
    END IF;
	
	DELETE FROM funcao
	WHERE id = p_id;
    
    SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delGrupoDeItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delGrupoDeItem`(
	IN p_id int
)
BEGIN

	DECLARE c_grupo_de_item INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_grupo_de_item
    FROM grupo_de_item
    WHERE grupo_de_item.id = p_id;
    IF c_grupo_de_item = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Grupo de Item não cadastrado';
    END IF;

	DELETE FROM grupo_de_item
	WHERE id = p_id;
    
    SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delItem`(
	IN p_id int
)
BEGIN
	
    DECLARE c_item INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_item
    FROM item
    WHERE item.id = p_id;
    IF c_item = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Item não cadastrado';
    END IF;

	DELETE FROM item
	WHERE id = p_id;
    
    SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delItemDeVenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delItemDeVenda`(
	IN p_id int
)
BEGIN

	DECLARE c_item_de_venda INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_item_de_venda
    FROM item_de_venda
    WHERE item_de_venda.id = p_id;
    IF c_item_de_venda = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Item de Venda não cadastrado';
    END IF;

	DELETE FROM item_de_venda
	WHERE id = p_id;
    
    SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delLembrete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delLembrete`(
	IN p_id int
)
BEGIN
	
    DECLARE c_lembrete INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_lembrete
    FROM lembrete
    WHERE lembrete.id = p_id;
    IF c_lembrete = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lembrete não cadastrado';
    END IF;

	DELETE FROM lembrete
	WHERE id = p_id;
    
    SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delLote`(
	IN p_id int
)
BEGIN

	DECLARE c_lote INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_lote
    FROM lote
    WHERE lote.id = p_id;
    IF c_lote = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lote não cadastrado';
    END IF;

	DELETE FROM lote
	WHERE id = p_id;
    
    SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delOAuth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delOAuth`(
	IN p_id INT
)
BEGIN
	
    DECLARE c_oauth INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_oauth
    FROM oauth
    WHERE oauth.id = p_id;
    IF c_oauth = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'OAuth não cadastrada';
    END IF;

	DELETE FROM oauth
	WHERE id = p_id;
	
	SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPedido`(
	IN p_id int
)
BEGIN

	DECLARE c_pedido INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_pedido
    FROM pedido
    WHERE pedido.id = p_id;
    IF c_pedido = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pedido não cadastrado';
    END IF;

	DELETE FROM pedido
	WHERE id = p_id;
    
    SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPermissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPermissao`(
	IN p_id int
)
BEGIN
	
    DECLARE c_permissoes INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_permissoes
    FROM permissao
    WHERE permissao.id = p_id;
    IF c_permissoes = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Permissão não cadastrada';
    END IF;

	DELETE FROM permissao
	WHERE id = p_id;
    
    SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPessoa`(
	IN p_id int
)
BEGIN
	
    DECLARE c_pessoa INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa
    FROM pessoa
    WHERE pessoa.id = p_id;
    IF c_pessoa = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;

	DELETE FROM pessoa
	WHERE id = p_id;
    
    SELECT NULL;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPessoaTemFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPessoaTemFuncao`(
	IN p_id int
)
BEGIN

	DECLARE c_pessoa_tem_funcao INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa_tem_funcao
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_id;
    IF c_pessoa_tem_funcao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não possui Função';
    END IF;
		
	DELETE FROM pessoa_tem_funcao
	 WHERE id = p_id;
     
     SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPessoaTemPermissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPessoaTemPermissao`(
	IN p_id int
)
BEGIN
    
    DECLARE c_pessoa_tem_permissoes INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa_tem_permissoes
    FROM pessoa_tem_permissao
    WHERE pessoa_tem_permissao.id = p_id;
    IF c_pessoa_tem_permissoes = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não possui Permissão';
    END IF;
    
	DELETE FROM pessoa_tem_permissao
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPessoaTemRedeSocial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPessoaTemRedeSocial`(
	IN p_id int
)
BEGIN
    
    DECLARE c_pessoa_tem_rede_social INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa_tem_rede_social
    FROM pessoa_tem_rede_social
    WHERE pessoa_tem_rede_social.id = p_id;
    IF c_pessoa_tem_rede_social = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não possui Rede Social';
    END IF;
    
	DELETE FROM pessoa_tem_rede_social
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPorte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPorte`(
	IN p_id int
)
BEGIN
	
    DECLARE c_porte INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_porte
    FROM porte
    WHERE porte.id = p_id;
    IF c_porte = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte não cadastrado';
    END IF;

	DELETE FROM porte
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delRaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delRaca`(
	IN p_id int
)
BEGIN
    
    DECLARE c_raca INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_raca
    FROM raca
    WHERE raca.id = p_id;
    IF c_raca = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Raça não cadastrada';
    END IF;
    
	DELETE FROM raca
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delRedeSocial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delRedeSocial`(
	IN p_id int
)
BEGIN

    DECLARE c_rede_social INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_rede_social
    FROM rede_social
    WHERE rede_social.id = p_id;
    IF c_rede_social = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Rede Social não cadastrada';
    END IF;
		
	DELETE FROM rede_social
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delRestricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delRestricao`(
	IN p_id int
)
BEGIN
    
    DECLARE c_restricao INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_restricao
    FROM restricao
    WHERE restricao.id = p_id;
    IF c_restricao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Restrição não cadastrada';
    END IF;
		
	DELETE FROM restricao
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delServico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delServico`(
	IN p_id int
)
BEGIN
    
    DECLARE c_servico INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_servico
    FROM servico
    WHERE servico.id = p_id;
    IF c_servico = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço não cadastrado';
    END IF;
		
	DELETE FROM servico
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delServicoAgendado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delServicoAgendado`(
	IN p_id int
)
BEGIN

    DECLARE c_servico_agendado INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_servico_agendado
    FROM servico_agendado
    WHERE servico_agendado.id = p_id;
    IF c_servico_agendado = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço Agendado não cadastrado';
    END IF;
	
    DELETE FROM servico_agendado
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delServicoContratado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delServicoContratado`(
	IN p_id int
)
BEGIN

	DECLARE c_servico_contratado INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_servico_contratado
    FROM servico_contratado
    WHERE servico_contratado.id = p_id;
    IF c_servico_contratado = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço Contratado não cadastrado';
    END IF;

	DELETE FROM servico_contratado
	WHERE id = p_id;
	
    SELECT NULL;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delServicoTemPorte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delServicoTemPorte`(
	IN p_id int
)
BEGIN
    
    DECLARE c_servico_tem_porte INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_servico_tem_porte
    FROM servico_tem_porte
    WHERE servico_tem_porte.id = p_id;
    IF c_servico_tem_porte = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço não possui Porte';
    END IF;
		
	DELETE FROM servico_tem_porte
	WHERE id = p_id;
    
    SELECT NULL;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delTelefone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delTelefone`(
	IN p_id int
)
BEGIN

	DECLARE c_telefone INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_telefone
    FROM telefone
    WHERE telefone.id = p_id;
    IF c_telefone = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Telefone não possui cadastro';
    END IF;
    
	DELETE FROM telefone
	WHERE id = p_id;
    
    SELECT NULL;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delTransacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delTransacao`(
	IN p_id int
)
BEGIN
    
    DECLARE c_transacao INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_transacao
    FROM transacao
    WHERE transacao.id = p_id;
    IF c_transacao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Transação não possui cadastro';
    END IF;
		
	DELETE FROM transacao
	WHERE id = p_id;
    
    SELECT NULL;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delVacina` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delVacina`(
	IN p_id int
)
BEGIN
	
    DECLARE c_vacina INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_vacina
    FROM vacina
    WHERE vacina.id = p_id;
    IF c_vacina = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Vacina não possui cadastro';
    END IF;
	
	DELETE FROM vacina
	WHERE id = p_id;
    
    SELECT NULL;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delVacinaTemLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delVacinaTemLote`(
		IN p_id INT
)
BEGIN

	DECLARE c_vacina_tem_lote INT;

	IF p_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT COUNT(*) INTO c_vacina_tem_lote
    FROM vacina_tem_lote
    WHERE vacina_tem_lote.id = p_id;
    IF c_vacina_tem_lote = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lote não atribuído à Vacina';
    END IF;
		
	DELETE FROM vacina_tem_lote
	WHERE id = p_id;
    
    SELECT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAnamnese` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnamnese`(
		IN id INT
    , 	IN servico_agendado_id INT
    , 	IN servico_contratado_id INT
	, 	IN animal_id INT
	, 	IN tempo_evolucao INT
	, 	IN tratamento TINYINT
	, 	IN medicacao_continua TINYINT
	, 	IN fezes_normais TINYINT
	, 	IN urina_normal TINYINT
	, 	IN convulsao TINYINT
	, 	IN desmaio TINYINT
	, 	IN tosse TINYINT
	, 	IN espirro TINYINT
	, 	IN cansaco_facil TINYINT
	, 	IN contato_animais TINYINT
	, 	IN acesso_rua TINYINT
	, 	IN castrado TINYINT
	, 	IN pulga TINYINT
	,	IN carrapato TINYINT
    )
BEGIN
	SELECT 	a.id, a.peso, a.tamanho, a.temperatura, an.id as animal_id, 
			an.nome as animal, sa.id as servico_agendado_id, sa.servico_contratado_id,
            a.queixa, a.tempo_evolucao, a.tratamento, a.medicacao_continua, a.alimentacao,
            a.fezes_normais, a.urina_normal, a.convulsao, a.desmaio, a.tosse, a.espirro, a.cansaco_facil,
            a.ambiente_vive, a.contato_animais, a.acesso_rua, a.castrado, a.doencas_anteriores,
            a.pulga, a.carrapato
	  FROM anamnese a
	 INNER JOIN servico_agendado sa
		ON a.servico_agendado_id = sa.id
	 INNER JOIN animal an
		ON sa.animal_id = an.id
	 WHERE 1 = 1
		AND ((id IS NULL) or (a.id = id))
        AND ((servico_agendado_id IS NULL) or (a.servico_agendado_id = servico_agendado_id))
        AND ((servico_contratado_id IS NULL) or (sa.servico_contratado_id = servico_contratado_id))
        AND ((animal_id IS NULL) or (an.id = animal_id))
        AND ((servico_contratado_id IS NULL) or (sa.servico_contratado_id = servico_contratado_id))
        AND ((tempo_evolucao IS NULL) or (a.tempo_evolucao = tempo_evolucao))
        AND ((tratamento IS NULL) or (a.tratamento = tratamento))
        AND ((medicacao_continua IS NULL) or (a.medicacao_continua = medicacao_continua))
        AND ((fezes_normais IS NULL) or (a.fezes_normais = fezes_normais))
        AND ((urina_normal IS NULL) or (a.urina_normal = urina_normal))
        AND ((convulsao IS NULL) or (a.convulsao = convulsao))
        AND ((desmaio IS NULL) or (a.desmaio = desmaio))
        AND ((tosse IS NULL) or (a.tosse = tosse))
        AND ((espirro IS NULL) or (a.espirro = espirro))
        AND ((cansaco_facil IS NULL) or (a.cansaco_facil = cansaco_facil))
        AND ((contato_animais IS NULL) or (a.contato_animais = contato_animais))
        AND ((acesso_rua IS NULL) or (a.acesso_rua = acesso_rua))
        AND ((castrado IS NULL) or (a.castrado = castrado))
        AND ((pulga IS NULL) or (a.pulga = pulga))
        AND ((carrapato IS NULL) or (a.carrapato = carrapato))
	 ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAnimal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnimal`(
  IN p_id INT
  , IN p_nome VARCHAR(50)
  , IN p_pessoa_tem_funcao_id INT
  , IN p_raca_id INT
  , IN p_porte_id INT
  , IN p_pessoa_id INT
)
BEGIN
  SELECT a.id, a.nome, a.sexo, a.data_hora_cadastro, a.data_nascimento, pf.id as pessoa_tem_funcao_cliente_id, p.id as pessoa_id, p.nome as pessoa, r.id as raca_id, r.nome as raca, porte.id as porte_id, porte.nome as porte
    FROM animal a
    INNER JOIN pessoa_tem_funcao pf, pessoa p, raca r, porte
    WHERE a.pessoa_tem_funcao_id = pf.id
    AND pf.pessoa_id = p.id
    AND a.porte_id = porte.id
    AND a.raca_id = r.id
    AND ((p_id is null) or (a.id = p_id))
    AND ((p_nome is null) or (a.nome like concat('%', p_nome, '%')))
    AND ((p_pessoa_tem_funcao_id is null) or (a.pessoa_tem_funcao_id = p_pessoa_tem_funcao_id))
    AND ((p_pessoa_id is null) or (p.id = p_pessoa_id))
    AND ((p_raca_id is null) or (a.raca_id = p_raca_id))
    AND ((p_porte_id is null) or (a.porte_id = p_porte_id))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAnimalTemRestricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnimalTemRestricao`(
	IN id INT
    , IN animal_id INT
    , IN restricao_id INT)
BEGIN
	SELECT atr.id, a.id as animal_id, a.nome as animal, r.id as restricao_id, r.restricao, r.descricao
    FROM animal_tem_restricao atr
    INNER JOIN animal a ON atr.animal_id = a.id
    INNER JOIN restricao r ON atr.restricao_id = r.id
    WHERE 1 = 1
    AND ((id IS NULL) or (atr.id = id))
    AND ((animal_id IS NULL) or (a.id = animal_id))
    AND ((restricao_id IS NULL) or (r.id = restricao_id))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAplicacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAplicacao`(
	IN id INT
    , IN data_hora_inicio DATETIME
    , IN data_hora_fim DATETIME
    , IN vacina_tem_lote_id INT
    , IN servico_agendado_id INT
    , IN servico_contratado_id INT
    , IN animal_id INT
    )
BEGIN
	SELECT a.id, a.data_hora, a.aplicado, a.dose as dose_aplicada, v.dose as numero_de_doses,
		v.id as vacina_id, v.nome as vacina, an.id as animal_id, an.nome as animal,
        sa.id as servico_agendado_id, sa.servico_contratado_id
	  FROM aplicacao a
	 INNER JOIN vacina_tem_lote vtl
		ON a.vacina_tem_lote_id = vtl.id
	 INNER JOIN vacina v
		ON vtl.vacina_id = v.id
	 INNER JOIN servico_agendado sa
		ON a.servico_agendado_id = sa.id
	 INNER JOIN animal an
		ON sa.animal_id = an.id
	 WHERE 1 = 1
		AND ((id IS NULL) or(a.id = id))
        AND ((data_hora_inicio IS NULL AND data_hora_fim IS NULL) or (a.data_hora BETWEEN data_hora_inicio AND data_hora_fim))
        AND ((vacina_tem_lote_id IS NULL) or(a.vacina_tem_lote_id = vacina_tem_lote_id))
        AND ((servico_agendado_id IS NULL) or(a.servico_agendado_id = servico_agendado_id))
        AND ((servico_contratado_id IS NULL) or(sa.servico_contratado_id = servico_contratado_id))
        AND ((animal_id IS NULL) or(sa.animal_id = animal_id))
	 ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getConfiguracao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getConfiguracao`()
BEGIN
	SELECT quantidade_animais, periodos_dia
    FROM configuracao;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getEspecie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEspecie`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT e.id, e.nome
		FROM especie e
		WHERE 1 = 1
		AND ((p_id is null) or (e.id = p_id))
		AND ((p_nome is null) or (e.nome like concat('%', p_nome, '%')));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFuncao`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT id, nome
		FROM funcao f
		WHERE 1 = 1
		AND ((p_id is null) or (f.id = p_id))
		AND ((p_nome is null) or (f.nome = p_nome));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getGrupoDeItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getGrupoDeItem`(
		IN id INT
    ,	IN nome VARCHAR(50)
    )
BEGIN
	SELECT gdi.id, gdi.nome
    FROM grupo_de_item gdi
    WHERE 1 = 1
    AND ((id IS NULL) or (gdi.id = id))
    AND ((nome IS NULL) or (gdi.nome = nome))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getHistorico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getHistorico`(
	IN p_tipo char(1)
  , IN p_data_inicio datetime
  , IN p_data_fim datetime
)
BEGIN
	
    DECLARE sum_c DECIMAL(10,2);
    DECLARE sum_d DECIMAL(10,2);
    
    SELECT SUM(t.valor) INTO sum_c FROM transacao as t WHERE tipo = 'C';
    SELECT SUM(t.valor) INTO sum_d FROM transacao as t WHERE tipo = 'D';

	SELECT sum_c as soma_credito, sum_d as soma_debito, sum_c-sum_d as caixa,
		t.id as transacao_id, t.tipo, t.data_hora as data_transacao, t.valor as transacao_valor, t.comentario as transacao_comentario,
		sa.data_hora as data_servico, s.nome as servico_nome, sa.preco as servico_valor,
        p.valor as pedido_valor, p.desconto as pedido_desconto
		FROM transacao t
        LEFT JOIN servico_contratado as sc
			ON t.id = sc.transacao_id
		LEFT JOIN servico_agendado as sa
			ON sc.id = sa.servico_contratado_id
		LEFT JOIN servico_tem_porte as stp
			ON stp.id = sa.servico_tem_porte_id
		LEFT JOIN servico as s
			ON s.id = stp.servico_id
		LEFT JOIN pedido as p
			ON t.id = p.transacao_id
		WHERE 1 = 1
		AND ((p_tipo is null) OR (t.tipo = p_tipo))
		AND ((p_data_inicio is null and p_data_fim is null) OR (t.data_hora between p_data_inicio and p_data_fim));

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getItem`(
		IN id INT
    ,	IN nome VARCHAR(50)
    ,	IN grupo_de_item_id INT
	)
BEGIN
	SELECT i.id, i.nome, i.preco, i.quantidade, gdi.id as grupo_de_item_id, gdi.nome as grupo_de_item, i.data_hora_cadastro
    FROM item i
    INNER JOIN grupo_de_item gdi ON i.grupo_de_item_id = gdi.id
    WHERE 1 = 1
		AND ((id IS NULL) or (i.id = id))
        AND ((nome IS NULL) or (i.nome = nome))
        AND ((grupo_de_item_id IS NULL) or (i.grupo_de_item_id = grupo_de_item_id))
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getItemDeVenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemDeVenda`(
		IN id INT
	,	IN item_id INT
    )
BEGIN

	SELECT idv.id, idv.preco, idv.quantidade, i.id as item_id, i.nome as item
    FROM item_de_venda idv
    INNER JOIN item i ON idv.item_id = i.id
    WHERE 1 = 1
    AND ((id IS NULL) or (idv.id = id))
    AND ((item_id IS NULL) or (idv.item_id = item_id))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getLembrete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLembrete`(
		IN id INT
	,	IN data_hora_inicio DATETIME
    , 	IN data_hora_fim DATETIME
    ,	IN executado TINYINT
    , 	IN pessoa_id INT
    )
BEGIN
	SELECT l.id, l.descricao, l.data_hora, l.executado, l.pessoa_id, p.id as pessoa_id, p.nome as pessoa
    FROM lembrete l
    INNER JOIN pessoa p ON l.pessoa_id = p.id
    WHERE 1 = 1
    AND ((id IS NULL) or (l.id = id))
    AND ((data_hora_inicio IS NULL AND data_hora_fim IS NULL) or (l.data_hora BETWEEN data_hora_inicio AND data_hora_fim))
    AND ((executado IS NULL) or (l.executado = executado))
    AND ((pessoa_id IS NULL) or (l.pessoa_id = pessoa_id))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLote`(
		IN id INT
	,	IN numero VARCHAR(50)
    ,	IN vencimento_inicio DATE
    ,	IN vencimento_fim DATE
    )
BEGIN
	SELECT l.id, l.numero, l.vencimento, l.preco
    FROM lote l
    WHERE 1 = 1
    AND ((id IS NULL) or (l.id = id))
    AND ((numero IS NULL) or (l.numero = numero))
    AND ((vencimento_inicio IS NULL AND vencimento_fim IS NULL) or (l.vencimento BETWEEN vencimento_inicio AND vencimento_fim))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getOAuth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getOAuth`(
		IN p_id INT
	,	IN p_token VARCHAR(100)
    ,	IN p_refresh_token VARCHAR(100)
)
BEGIN
	SELECT o.id, o.data_hora, o.vencimento, o.token, o.refresh_token
    FROM oauth o
    WHERE 1 = 1
    AND ((p_id IS NULL) or (o.id = p_id))
    AND ((p_token IS NULL) or (o.token = p_token))
    AND ((p_refresh_token IS NULL) or (o.refresh_token = p_refresh_token))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPedido`(
		IN id INT
	,	IN pessoa_tem_funcao_cliente_id INT
	,	IN cliente_id INT
    ,	IN pessoa_tem_funcao_funcionario_id INT
    ,	IN funcionario_id INT
	)
BEGIN
	SELECT p.id, p.valor, p.desconto, ptf1.id as pessoa_tem_funcao_cliente_id, pe1.id as pessoa_cliente_id, pe1.nome as cliente, ptf2.id as pessoa_tem_funcao_funcionario_id, pe2.id as pessoa_funcionario_id, pe2.nome as funcionario
    FROM pedido p
    INNER JOIN pessoa_tem_funcao ptf1,pessoa_tem_funcao ptf2, pessoa pe1, pessoa pe2
    WHERE p.cliente_id = ptf1.id 
	AND p.funcionario_id = ptf2.id
    AND  ptf1.pessoa_id = pe1.id
    AND  ptf2.pessoa_id = pe2.id
    AND ((id IS NULL) or (p.id = id))
    AND ((pessoa_tem_funcao_cliente_id IS NULL) or (p.cliente_id = pessoa_tem_funcao_cliente_id))
    AND ((cliente_id IS NULL) or (pe1.id = cliente_id))
    AND ((pessoa_tem_funcao_funcionario_id IS NULL) or (p.funcionario_id = pessoa_tem_funcao_funcionario_id))
    AND ((funcionario_id IS NULL) or (pe2.id = funcionario_id))
    ;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPermissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPermissao`(
		IN id INT
	,	IN modulo VARCHAR(50)
    )
BEGIN
	SELECT p.id, p.modulo
	FROM permissao p
    WHERE 1 = 1
    AND ((id IS NULL) or (p.id = id))
    AND ((modulo IS NULL) or (p.modulo = modulo))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoa`(
		IN pessoa_id INT
    ,	IN nome VARCHAR(255)
    ,	IN registro VARCHAR(14)
    ,	IN email VARCHAR(50)
    ,	IN cidade VARCHAR(100)
    ,	IN estado VARCHAR(50)
    ,	IN estado_uf VARCHAR(2)
    , 	IN pais VARCHAR(50)
    , 	IN rg VARCHAR(50)
    , 	IN inscricao VARCHAR(50)
    , 	IN orgao VARCHAR(50)
    , 	IN bairro VARCHAR(50)
    ,	IN cliente VARCHAR(5)
    ,	IN especial VARCHAR(5)
    ,	IN funcionario VARCHAR(5)
    ,	IN administrador VARCHAR(5)
    )
BEGIN

	DECLARE cliente_id INT;
    DECLARE especial_id INT;
    DECLARE funcionario_id INT;
    DECLARE administrador_id INT;
    
    IF cliente IS NOT NULL AND cliente = "true" THEN
		SET cliente_id = 1;
        SET especial_id = 2;
    ELSE
		SET cliente_id = NULL;
        SET especial_id = NULL;
    END IF;
    
    IF especial IS NOT NULL AND especial = "true" THEN
        SET especial_id = 2;
    ELSE
        SET especial_id = NULL;
    END IF;
    
    IF funcionario IS NOT NULL AND funcionario = "true" THEN
		SET funcionario = 3;
    ELSE
		SET funcionario = NULL;
    END IF;
    
    IF administrador IS NOT NULL AND administrador = "true" THEN
		SET administrador = 4;
    ELSE
		SET administrador = NULL;
    END IF;

	SELECT p.id, p.nome, p.data_hora_cadastro, p.email, p.registro, p.logradouro,
    p.numero, p.complemento, p.cep, p.ponto_de_referencia, p.cidade, p.estado, 
    p.uf, p.pais, p.rg, p.inscricao_estadual, p.orgao_expedidor, p.bairro
    FROM pessoa p
    LEFT JOIN pessoa_tem_funcao as ptf
		ON p.id = ptf.pessoa_id
	LEFT JOIN funcao as f
		ON ptf.funcao_id = f.id
    WHERE 1 = 1
    AND ((pessoa_id is null) or (p.id = pessoa_id))
    AND ((nome is null) or (p.nome like concat('%', nome, '%')))
    AND ((registro is null) or (p.registro like concat('%', registro, '%')))
    AND ((email is null) or (p.email like concat('%', email, '%')))
    AND ((cidade is null) or (p.cidade = cidade))
    AND ((estado is null) or (p.estado = estado))
    AND ((uf is null) or (p.uf = uf))
    AND ((pais is null) or (p.pais = pais))
    AND ((rg is null) or (p.rg = rg))
    AND ((inscricao is null) or (p.inscricao_estadual = inscricao))
    AND ((orgao is null) or (p.orgao_expedidor = orgao))
    AND ((bairro is null) or (p.bairro = bairro))
    AND (((cliente_id or especial_id or funcionario_id or administrador_id) is null) or f.id in (cliente_id, especial_id, funcionario_id, administrador_id))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPessoaTemFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemFuncao`(
	IN p_id int
  , IN p_pessoa_id int
  , IN p_funcao_id int
  , IN p_pessoa_registro varchar(14)
  , IN p_pessoa_email varchar(100)
  , IN p_password varchar(50)
  , IN p_oauth_id int
  , IN p_oauth_token varchar(100)
)
BEGIN
	SELECT 	ptf.id, p.id as pessoa_id, p.nome as pessoa, p.email as email, 
			p.registro as registro, f.id as funcao_id, f.nome as funcao, 
            ptf.password, o.id as oauth_id, o.token
	  FROM pessoa_tem_funcao ptf
	 INNER JOIN funcao f
		ON f.id = ptf.funcao_id
	 INNER JOIN pessoa p
		ON p.id = ptf.pessoa_id
	 LEFT JOIN oauth o
		ON o.id = ptf.oauth_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (ptf.id = p_id))
       AND ((p_pessoa_id is null) OR (ptf.pessoa_id = p_pessoa_id))
       AND ((p_funcao_id is null) OR (ptf.funcao_id = p_funcao_id))
       AND ((p_pessoa_registro is null) OR (p.registro = p_pessoa_registro))
       AND ((p_pessoa_email is null) OR (p.email = p_pessoa_email))
       AND ((p_password is null) OR (ptf.password = p_password))
       AND ((p_oauth_id is null) OR (o.id = p_oauth_id))
       AND ((p_oauth_token is null) OR (o.token = p_oauth_token))
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPessoaTemPermissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemPermissao`(
		IN id INT
	, 	IN pessoa_id INT
	, 	IN permissao_id INT
	)
BEGIN
	SELECT ptp.id, ptf.id as pessoa_tem_funcao_id, p.id as pessoa_id, p.nome as pessoa, pe.id as permissao_id, pe.modulo
    FROM pessoa_tem_permissao ptp
    INNER JOIN pessoa_tem_funcao ptf ON ptp.pessoa_tem_funcao_id = ptf.id
    INNER JOIN pessoa p ON ptf.pessoa_id = p.id
    INNER JOIN permissao pe ON ptp.permissoes_id = pe.id
    WHERE 1 = 1
    AND ((id IS NULL) or (ptp.id = id))
    AND ((pessoa_id IS NULL) or (p.id = pessoa_id))
    AND ((permissao_id IS NULL) or (pe.id = permissao_id))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPessoaTemRedeSocial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemRedeSocial`(
	IN p_id int
  , IN p_perfil varchar(200)
  , IN p_pessoa_id int
  , IN p_rede_social_id int
)
BEGIN
	SELECT ptrs.id, pes.id as pessoa_id, pes.nome as pessoa, ptrs.perfil, rs.id as rede_soical_id, rs.nome as rede_social
	  FROM pessoa_tem_rede_social ptrs
	 INNER JOIN pessoa pes
		ON pes.id = ptrs.pessoa_id
	 INNER JOIN rede_social rs
		ON rs.id = ptrs.rede_social_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (ptrs.id = p_id))
       AND ((p_perfil is null) OR (ptrs.perfil like concat('%', p_perfil, '%')))
       AND ((p_rede_social_id is null) OR (ptrs.rede_social_id = p_rede_social_id))
       AND ((p_pessoa_id is null) OR (ptrs.pessoa_id = p_pessoa_id));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPorte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPorte`(
		IN id int
	,	IN nome VARCHAR(50)
)
BEGIN
	
    SELECT p.id, p.nome, p.tamanho_minimo, p.tamanho_maximo, p.peso_minimo, p.peso_maximo
	FROM porte p
    WHERE 1 = 1
    AND ((id IS NULL) or (p.id = id))
    AND ((nome IS NULL) or (p.nome = nome))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRaca`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_especie_id int
  , IN p_porte_id int
)
BEGIN
	SELECT r.id, r.nome, e.id as especia_id, e.nome as especie, p.id as porte_id, p.nome as porte
		FROM raca r
		INNER JOIN especie e, porte p
		WHERE r.especie_id = e.id
        AND r.porte_id = p.id
		AND ((p_id is null) OR (r.id = p_id))
		AND ((p_nome is null) OR (r.nome like concat('%', p_nome, '%')))
		AND ((p_especie_id is null) OR (r.especie_id = p_especie_id))
		AND ((p_porte_id is null) OR (r.porte_id = p_porte_id));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRedeSocial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRedeSocial`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT id, nome
		FROM rede_social rs
		WHERE 1 = 1
		AND ((p_id is null) OR (rs.id = p_id))
		AND ((p_nome is null) OR (rs.nome like concat('%', p_nome, '%')));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRestricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRestricao`(
		IN id INT
	,	IN restricao VARCHAR(50)
    )
BEGIN
	SELECT r.id, r.restricao, r.descricao
    FROM restricao r
    WHERE 1 = 1
    AND ((id IS NULL) or (r.id = id))
    AND ((restricao IS NULL) or (r.restricao = restricao))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getServico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServico`(
    IN id INT,
    IN nome VARCHAR(50)
)
BEGIN
    SELECT s.id, s.nome 
    FROM servico s
    WHERE 1 = 1
    AND ((id IS NULL) or (s.id = id))
    AND ((nome IS NULL) or (s.nome = nome));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getServicoAgendado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicoAgendado`(
	IN id INT,
    IN servico_contratado_id INT,
    IN data_inicio DATETIME,
    IN data_fim DATETIME,
    IN recorrente TINYINT,
    IN executado TINYINT,
    IN pago TINYINT,
    IN data_executado_inicio DATETIME,
    IN data_executado_fim DATETIME,
    IN animal_id INT,
    IN servico_id INT,
    IN cancelado TINYINT
)
BEGIN

	SELECT 	sa.id, sa.data_hora, stp.id as servico_tem_porte_id, stp.preco, s.id as servico_id, s.nome as servico,
			p.id as porte_id, p.nome as porte, a.id as animal_id, a.nome as animal, sa.servico_contratado_id,
			sa.recorrente, sa.executado, sa.pago, sa.observacao, sa.data_hora_executado, 
            sa.funcionario_executa_id as pessoa_tem_funcao_funcionario_id, pes.id as pessoa_id, pes.nome as pessoa_nome,
            sa.preco, sa.cancelado
		FROM servico_agendado sa
		INNER JOIN servico_tem_porte stp ON sa.servico_tem_porte_id = stp.id
        INNER JOIN servico s ON stp.servico_id = s.id
        INNER JOIN animal a ON sa.animal_id = a.id
        INNER JOIN porte p ON stp.porte_id = p.id
        LEFT JOIN pessoa_tem_funcao ptf ON sa.funcionario_executa_id = ptf.id
        LEFT JOIN pessoa pes ON ptf.pessoa_id = pes.id
		WHERE 1 = 1
        AND ((id IS NULL) or(sa.id = id))
        AND ((servico_contratado_id IS NULL) or(sa.servico_contratado_id = servico_contratado_id))
        AND ((data_inicio IS NULL AND data_fim IS NULL) or(sa.data_hora BETWEEN data_inicio AND data_fim))
        AND ((recorrente IS NULL) or(sa.recorrente = recorrente))
        AND ((executado IS NULL) or(sa.executado = executado))
        AND ((pago IS NULL) or(sa.pago = pago))
        AND ((data_executado_inicio IS NULL AND data_executado_fim IS NULL) or(sa.data_hora_executado BETWEEN data_executado_inicio AND data_executado_fim))
        AND ((animal_id IS NULL) or(a.id = animal_id))
        AND ((servico_id IS NULL) or(s.id = servico_id))
        AND ((cancelado IS NULL) or(sa.cancelado = cancelado))
        ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getServicoContratado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicoContratado`(
		IN id int
	,	IN data_hora_inicio DATETIME
    ,	IN data_hora_fim DATETIME
	)
BEGIN

  SELECT 	s.id, pf.id as pessoa_tem_funcao_funcionario_id, p.id as pessoa_id, p.nome as pessoa, 
			s.data_hora, s.preco, s.transacao_id
      FROM servico_contratado s
          INNER JOIN pessoa_tem_funcao pf, pessoa p
          WHERE s.pessoa_tem_funcao_id_funcionario = pf.id
          AND pf.pessoa_id = p.id
      AND ((id IS NULL) or (s.id = id))
      AND ((data_hora_inicio IS NULL AND data_hora_fim IS NULL) or (s.data_hora BETWEEN data_hora_inicio AND data_hora_fim))
      ;
          
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getServicoTemPorte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicoTemPorte`(
	IN id INT,
	IN servico_id INT,
	IN porte_id INT
)
BEGIN
	SELECT sp.id, s.id as servico_id, s.nome as servico, p.id as porte_id, p.nome as porte, sp.preco 
    FROM servico_tem_porte sp
    INNER JOIN porte p, servico s
    WHERE sp.porte_id = p.id
    AND sp.servico_id = s.id
    AND ((id IS NULL) or (sp.id = id))
    AND ((servico_id IS NULL) or (sp.servico_id = servico_id))
    AND ((porte_id IS NULL) or (sp.porte_id = porte_id));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTelefone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTelefone`(
		IN id INT
	, 	IN pessoa_id INT
    , 	IN codigo_pais VARCHAR(3)
    , 	IN codigo_area VARCHAR(3)
    )
BEGIN
	SELECT t.id, t.codigo_pais, t.codigo_area, t.numero, p.id as pessoa_id, p.nome as pessoa
    FROM telefone t
    INNER JOIN pessoa p ON t.pessoa_id = p.id
    WHERE 1 = 1
    AND ((id IS NULL) or (t.id = id))
    AND ((pessoa_id IS NULL) or (p.id = pessoa_id))
    AND ((codigo_pais IS NULL) or (t.codigo_pais = codigo_pais))
    AND ((codigo_area IS NULL) or (t.codigo_area = codigo_area))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTransacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTransacao`(
	IN p_id int
  , IN p_tipo char(1)
  , IN p_data_inicio datetime
  , IN p_data_fim datetime
)
BEGIN
	SELECT t.id, t.tipo, t.data_hora, t.valor, t.comentario
		FROM transacao t
		WHERE 1 = 1
		AND ((p_id is null) OR (t.id = p_id))
		AND ((p_tipo is null) OR (t.tipo = p_tipo))
		AND ((p_data_inicio is null and p_data_fim is null) OR (t.data_hora between p_data_inicio and p_data_fim));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getVacina` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getVacina`(
		IN id INT
    , 	IN nome VARCHAR(50)
	)
BEGIN
	SELECT v.id, v.nome, v.dose as total_doses, v.intervalo
    FROM vacina v
    WHERE 1 = 1
    AND ((id IS NULL) or (v.id = id))
    AND ((nome IS NULL) or (v.nome = nome))
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getVacinaTemLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getVacinaTemLote`(
		IN p_id INT
	,	IN p_vacina_id INT
    ,	IN p_vacina_nome VARCHAR(50)
    ,	IN p_lote_id INT
    ,	IN p_lote_numero VARCHAR(50)
    ,	IN p_lote_vencimento_inicio DATE
    ,	IN p_lote_vencimento_fim DATE
)
BEGIN

	SELECT vtl.id, v.id, v.nome, l.id, l.numero, l.vencimento, l.preco, vtl.quantidade
    FROM vacina_tem_lote vtl
    INNER JOIN vacina v ON vtl.vacina_id = v.id
    INNER JOIN lote l ON vtl.lote_id = l.id
    WHERE 1 = 1
    AND ((p_id IS NULL) or (vtl.id = p_id))
    AND ((p_vacina_id IS NULL) or (v.id = p_vacina_id))
    AND ((p_vacina_nome IS NULL) or (v.nome = p_vacina_nome))
    AND ((p_lote_id IS NULL) or (l.id = p_lote_id))
    AND ((p_lote_numero IS NULL) or (l.numero = p_lote_numero))
    AND ((p_lote_vencimento_inicio IS NULL AND p_lote_vencimento_fim IS NULL) or (l.vencimento BETWEEN p_lote_vencimento_inicio AND p_lote_vencimento_fim))
    ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insAnamnese` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insAnamnese`(
	IN p_peso int
  , IN p_tamanho int
  , IN p_temperatura int
  , IN p_servico_agendado_id int
  , IN p_queixa varchar(100)
  , IN p_tempo_evolucao int
  , IN p_tratamento tinyint
  , IN p_medicacao_continua tinyint
  , IN p_alimentacao varchar(100)
  , IN p_fezes_normais tinyint
  , IN p_urina_normal tinyint
  , IN p_convulsao tinyint
  , IN p_desmaio tinyint
  , IN p_tosse tinyint
  , IN p_espirro tinyint
  , IN p_cansaco_facil tinyint
  , IN p_ambiente_vive varchar(100)
  , IN p_contato_animais tinyint
  , IN p_acesso_rua tinyint
  , IN p_castrado tinyint
  , IN p_doencas_anteriores varchar(100)
  , IN p_pulga tinyint
  , IN p_carrapato tinyint
)
BEGIN
    DECLARE c_servico_agendado INT;
    
    IF p_peso IS NULL OR p_tamanho IS NULL OR p_temperatura IS NULL OR p_servico_agendado_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_servico_agendado
    FROM servico_agendado
    WHERE servico_agendado.id = p_servico_agendado_id;
    IF c_servico_agendado = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Servico Agendado não cadastrado';
    END IF;
	
    INSERT INTO anamnese
		(peso, tamanho, temperatura, servico_agendado_id, queixa,
		tempo_evolucao, tratamento, medicacao_continua, alimentacao,
		fezes_normais, urina_normal, convulsao, desmaio, tosse,
		espirro, cansaco_facil, ambiente_vive, contato_animais,
		acesso_rua, castrado, doencas_anteriores, pulga, carrapato)
	VALUES
		(p_peso, p_tamanho, p_temperatura, p_servico_agendado_id,
        p_queixa, p_tempo_evolucao, p_tratamento, p_medicacao_continua, 
        p_alimentacao, p_fezes_normais, p_urina_normal, p_convulsao, 
        p_desmaio, p_tosse, p_espirro, p_cansaco_facil, p_ambiente_vive, 
        p_contato_animais, p_acesso_rua, p_castrado, p_doencas_anteriores, 
        p_pulga, p_carrapato);
        
	SELECT LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insAnimal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insAnimal`(
		IN a_nome VARCHAR(100)
	,	IN a_sexo CHAR(1)
    ,	IN a_data_nascimento DATE
    ,	IN a_pessoa_tem_funcao_id INT
    ,	IN a_raca_id INT
    ,	IN a_porte_id INT	
  )
BEGIN
    DECLARE c_pessoa_tem_funcao INT;
    DECLARE c_raca INT;
    DECLARE c_porte INT;
    
    IF a_nome IS NULL OR a_sexo IS NULL OR a_pessoa_tem_funcao_id IS NULL OR a_raca_id IS NULL OR a_porte_id IS NULL THEN
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_pessoa_tem_funcao
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = a_pessoa_tem_funcao_id;
    IF c_pessoa_tem_funcao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_raca
    FROM raca
    WHERE raca.id = a_raca_id;
    IF c_raca = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Raça não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_porte
    FROM porte
    WHERE porte.id = a_porte_id;
    IF c_porte = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte não cadastrado';
    END IF;
    
	INSERT INTO animal
		(nome,sexo,data_hora_cadastro,data_nascimento,pessoa_tem_funcao_id,raca_id,porte_id)
	VALUES
		(a_nome, a_sexo, NOW(), a_data_nascimento, a_pessoa_tem_funcao_id, a_raca_id, a_porte_id);
        
	SELECT LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insAnimalTemRestricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insAnimalTemRestricao`(
	IN p_restricao_id int
  , IN p_animal_id int
)
BEGIN
	
	DECLARE c_restricao INT;
    DECLARE c_animal INT;
    DECLARE c_animal_tem_restricao INT;
    
    IF p_restricao_id IS NULL OR p_animal_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_restricao
    FROM restricao
    WHERE restricao.id = p_restricao_id;
    IF c_restricao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Restrição não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_animal
    FROM animal
    WHERE animal.id = p_animal_id;
    IF c_animal = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Animal não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_animal_tem_restricao
    FROM animal_tem_restricao
    WHERE animal_tem_restricao.animal_id = p_animal_id
     AND animal_tem_restricao.restricao_id = p_restricao_id;
    IF c_animal_tem_restricao > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Restrição ja atribuída à Animal';
    END IF;
    
    INSERT INTO animal_tem_restricao
		(restricao_id, animal_id)
	VALUES
		(p_restricao_id, p_animal_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insAplicacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insAplicacao`(
	IN p_data_hora datetime
  , IN p_aplicado tinyint
  , IN p_dose int
  , IN p_vacina_tem_lote_id int
  , IN p_servico_agendado_id int
)
BEGIN
    DECLARE c_vacina_tem_lote INT;
    DECLARE c_servico_agendado INT;
    
    IF p_data_hora IS NULL OR p_aplicado IS NULL OR p_dose IS NULL OR p_vacina_tem_lote_id IS NULL OR p_servico_agendado_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_vacina_tem_lote
    FROM vacina_tem_lote
    WHERE vacina_tem_lote.id = p_vacina_tem_lote_id;
    IF c_vacina_tem_lote = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Vacina não possui Lote';
    END IF;
    
    SELECT COUNT(*) INTO c_servico_agendado
    FROM servico_agendado
    WHERE servico_agendado.id = p_servico_agendado_id;
    IF c_servico_agendado = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Servico Agendado não cadastrado';
    END IF;
    
	INSERT INTO aplicacao
		(data_hora, aplicado, dose, vacina_tem_lote_id, servico_agendado_id)
	VALUES
		(p_data_hora, p_aplicado, p_dose, p_vacina_tem_lote_id, p_servico_agendado_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insConfiguracao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insConfiguracao`(
	IN p_quantidade_animais int
  , IN p_periodos_dia int
)
BEGIN
    IF p_quantidade_animais IS NULL OR p_periodos_dia IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
	INSERT INTO configuracao
		(quantidade_animais, periodos_dia)
	VALUES
		(p_quantidade_animais, p_periodos_dia);
        
	SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insEspecie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insEspecie`(
	IN p_nome varchar(50)
)
BEGIN
	
    DECLARE c_nome INT;

    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_nome
    FROM especie
    WHERE especie.nome = p_nome;
    IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Espécie já cadastrada';
    END IF;
    
	INSERT INTO especie
		(nome)
	VALUES
		(p_nome);
        
	SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insFuncao`(
	IN p_nome varchar(50)
)
BEGIN
	
    DECLARE c_nome INT;

    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_nome
    FROM funcao
    WHERE funcao.nome = p_nome;
    IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Função já cadastrada';
    END IF;
    
	INSERT INTO funcao
		(nome)
	VALUES
		(p_nome);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insGrupoDeItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insGrupoDeItem`(
	IN p_nome varchar(50)
)
BEGIN
	
    DECLARE c_nome INT;

    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_nome
    FROM grupo_de_item
    WHERE grupo_de_item.nome = p_nome;
    IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Grupo de Item já cadastrado';
    END IF;
    
	INSERT INTO grupo_de_item
		(nome)
	VALUES
		(p_nome);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insItem`(
	IN p_nome varchar(100)
  , IN p_preco decimal(10, 2)
  , IN p_quantidade int
  , IN p_grupo_de_item_id int
)
BEGIN
	
    DECLARE c_nome INT;
    DECLARE c_grupo_de_item INT;

    IF p_nome IS NULL OR p_preco IS NULL OR p_quantidade IS NULL OR p_grupo_de_item_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_nome
    FROM item
    WHERE item.nome = p_nome;
    IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Item já cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_grupo_de_item
    FROM grupo_de_item
    WHERE grupo_de_item.id = p_grupo_de_item_id;
    IF c_grupo_de_item = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Grupo de Item não cadastrado';
    END IF;
    
	INSERT INTO item
		(nome, preco, quantidade, grupo_de_item_id, data_hora_cadastro)
	VALUES
		(p_nome, p_preco, p_quantidade, p_grupo_de_item_id, NOW());
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insItemDeVenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insItemDeVenda`(
    IN p_preco decimal(10, 2)
  , IN p_quantidade int
  , IN p_item_id int
  , IN p_pedido_id int
)
BEGIN
	DECLARE c_item INT;
    DECLARE c_pedido INT;

    IF p_preco IS NULL OR p_quantidade IS NULL OR p_item_id IS NULL OR p_pedido_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_item
    FROM item
    WHERE item.id = p_item_id;
    IF c_item = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Item não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_pedido
    FROM pedido
    WHERE pedido.id = p_pedido_id;
    IF c_pedido = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pedido não cadastrado';
    END IF;
    
	INSERT INTO item_de_venda
		(preco, quantidade, item_id, pedido_id)
	VALUES
		(p_preco, p_quantidade, p_item_id, p_pedido_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insLembrete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insLembrete`(
	IN p_descricao varchar(200)
  , IN p_data_hora datetime
  , IN p_executado tinyint(1)
  , IN p_pessoa_id INT
)
BEGIN
    
    DECLARE c_pessoa INT;
    
    IF p_descricao IS NULL OR p_data_hora IS NULL OR p_executado IS NULL OR p_pessoa_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_pessoa
    FROM pessoa
    WHERE pessoa.id = p_pessoa_id;
    IF c_pessoa = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
	INSERT INTO lembrete
		(descricao, data_hora, executado, pessoa_id)
	VALUES
		(p_descricao, p_data_hora, p_executado, p_pessoa_id);
        
	SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insLog` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insLog`(
	IN p_mensagem varchar(500)
  , IN p_json varchar(500)
  , IN p_tabela varchar(50)
  , IN p_metodo varchar(10)
)
BEGIN

	INSERT INTO log
		(mensagem, tabela, json, metodo, data_hora)
	VALUES
		(p_mensagem, p_tabela, p_json, p_metodo, NOW());

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insLote`(
	IN p_numero VARCHAR(50)
  , IN p_vencimento DATE
  , IN p_preco DECIMAL(10,2)
  )
BEGIN
    DECLARE c_numero INT;
	DECLARE error_message VARCHAR(100);
    
    IF p_numero IS NULL OR p_vencimento IS NULL OR p_preco IS NULL THEN
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
	SELECT count(*)
	INTO c_numero
	FROM lote
	WHERE lote.numero = p_numero;
	IF c_numero > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lote já está cadastrado';
	END IF;
    
	INSERT INTO lote
		(numero, vencimento, preco)
	VALUES
		(p_numero, p_vencimento, p_preco);
        
	SELECT LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insOAuth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insOAuth`(
		IN p_token VARCHAR(160)
	,	IN p_refresh_token VARCHAR(160)
)
BEGIN
	
	DECLARE c_token INT;
    DECLARE c_refresh_token INT;
	DECLARE error_message VARCHAR(100);
    
    IF p_token IS NULL OR p_refresh_token IS NULL THEN
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
	SELECT count(*)
	INTO c_token
	FROM oauth
	WHERE oauth.token = p_token;
	IF c_token > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Token já está em uso';
	END IF;
    
    SELECT count(*)
	INTO c_refresh_token
	FROM oauth
	WHERE oauth.refresh_token = p_refresh_token;
	IF c_refresh_token > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Refresh Token já está em uso';
	END IF;
    
    INSERT INTO `pet_shop`.`oauth`
		(`data_hora`, `vencimento`, `token`, `refresh_token`)
	VALUES
		(NOW(), DATE_ADD(NOW(), INTERVAL 3 HOUR), p_token, p_refresh_token);
        
	SELECT LAST_INSERT_ID();
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPedido`(
	IN p_valor decimal(10, 2)
  , IN p_desconto decimal(10, 2)
  , IN p_transacao_id int
  , IN p_cliente_id int
  , IN p_funcionario_id int
)
BEGIN

	DECLARE c_transacao INT;
    DECLARE c_cliente INT;
    DECLARE c_funcionario INT;
	
    IF p_valor IS NULL OR p_desconto IS NULL OR p_transacao_id IS NULL OR p_cliente_id IS NULL OR p_funcionario_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_transacao
    FROM transacao
    WHERE transacao.id = p_transacao_id;
    IF c_transacao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Transação não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_cliente
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_cliente_id;
    IF c_cliente = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Cliente não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_funcionario
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_funcionario_id;
    IF c_funcionario = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Funcionário não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_cliente
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_cliente_id;
    IF c_funcionario = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Cliente não cadastrado';
    END IF;
    
	INSERT INTO pedido
		(valor, desconto, transacao_id, cliente_id, funcionario_id)
	VALUES
		(p_valor, p_desconto, p_transacao_id, p_cliente_id, p_funcionario_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPermissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPermissao`(
	IN p_modulo varchar(50)
)
BEGIN

	DECLARE c_modulo INT;

    IF p_modulo IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_modulo
    FROM permissao
    WHERE permissao.modulo = p_modulo;
    IF c_modulo > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Permissão já cadastrada';
    END IF;
    
	INSERT INTO permissao
		(modulo)
	VALUES
		(p_modulo);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPessoa`(
	IN p_nome varchar(100)
  , IN p_email varchar(50)
  , IN p_registro varchar(14)
  , IN p_logradouro varchar(100)
  , IN p_numero int
  , IN p_complemento varchar(50)
  , IN p_cep varchar(8)
  , IN p_ponto_de_referencia varchar(200)
  , IN p_cidade varchar(100)
  , IN p_estado varchar(50)
  , IN p_estado_uf varchar(2)
  , IN p_pais varchar(50)
  , IN p_rg varchar(10)
  , IN p_inscricao varchar(10)
  , IN p_orgao varchar(10)
  , IN p_bairro varchar(10)
)
BEGIN
	DECLARE c_cidade INT;
	DECLARE c_email INT;
    DECLARE c_registro INT;
    DECLARE c_rg INT;
    
    IF p_nome IS NULL OR p_email IS NULL OR p_registro IS NULL 
    OR p_logradouro IS NULL OR p_numero IS NULL OR p_cep IS NULL 
    OR p_cidade IS NULL OR p_estado IS NULL OR p_estado_uf IS NULL
    OR p_pais IS NULL OR p_bairro IS NULL THEN
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT count(*)
      INTO c_email
      FROM pet_shop.pessoa p
	 WHERE p.email = p_email;
	IF c_email > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Email já está sendo utilizado por outra pessoa';
	END IF;
    
    SELECT count(*)
      INTO c_registro
      FROM pet_shop.pessoa p
	 WHERE p.registro = p_registro;
	IF c_registro > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Registro já está sendo utilizado por outra pessoa';
	END IF;
    
    SELECT count(*)
      INTO c_rg
      FROM pet_shop.pessoa p
	 WHERE p.rg = p_rg;
	IF c_rg > 0 AND p_rg IS NOT NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'RG já está sendo utilizado por outra pessoa';
	END IF;
    
	INSERT INTO pessoa
		(nome, data_hora_cadastro, email, registro, logradouro, numero, complemento, cep, ponto_de_referencia, cidade, estado, uf, pais, rg, inscricao_estadual, orgao_expedidor, bairro)
	VALUES
		(p_nome, NOW(), p_email, p_registro, p_logradouro, p_numero, p_complemento, p_cep, p_ponto_de_referencia, p_cidade, p_estado, p_estado_uf, p_pais, p_rg, p_inscricao, p_orgao, p_bairro);

	SELECT LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPessoaTemFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPessoaTemFuncao`(
	IN p_pessoa_id int
  , IN p_funcao_id int
  , IN p_password varchar(50)
  , IN p_oauth_id int
)
BEGIN
	
    DECLARE c_pessoa INT;
    DECLARE c_funcao INT;
    DECLARE c_pessoa_tem_funcao INT;
    
    IF p_pessoa_id IS NULL OR p_funcao_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT count(*) INTO c_pessoa
      FROM pessoa
	 WHERE pessoa.id = p_pessoa_id;
	IF c_pessoa = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
	END IF;
    
    SELECT count(*) INTO c_funcao
      FROM funcao
	 WHERE funcao.id = p_funcao_id;
	IF c_funcao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Função não cadastrada';
	END IF;
    
    SELECT count(*) INTO c_pessoa_tem_funcao
      FROM pessoa_tem_funcao
	 WHERE pessoa_tem_funcao.pessoa_id = p_pessoa_id
	   AND pessoa_tem_funcao.funcao_id = p_funcao_id;
	IF c_pessoa_tem_funcao > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Função já atribuída à Pessoa';
	END IF;
    
	INSERT INTO pessoa_tem_funcao
		(pessoa_id, funcao_id, password, oauth_id)
	VALUES
		(p_pessoa_id, p_funcao_id, p_password, p_oauth_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPessoaTemPermissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPessoaTemPermissao`(
	IN p_pessoa_tem_funcao_id int
  , IN p_permissao_id int
)
BEGIN

	DECLARE c_pessoa_tem_funcao INT;
    DECLARE c_permissao INT;
	DECLARE c_pessoa_tem_permissoes INT;
    
    IF p_pessoa_tem_funcao_id IS NULL OR p_permissao_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
	SELECT COUNT(*) INTO c_pessoa_tem_funcao
    FROM pessoa_tem_funcao
    WHERE pessoa_tem_funcao.id = p_pessoa_tem_funcao_id;
    IF c_pessoa_tem_funcao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
	SELECT COUNT(*) INTO c_permissao
    FROM permissao
    WHERE permissao.id = p_permissao_id;
    IF c_permissao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Permissão não cadastrada';
    END IF;
    
    SELECT count(*) INTO c_pessoa_tem_permissoes
      FROM pessoa_tem_permissao
	 WHERE pessoa_tem_funcao_id = p_pessoa_tem_funcao_id
	   AND pessoa_tem_permissao.permissoes_id = p_permissao_id;
	IF c_pessoa_tem_permissoes > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Permissão já atribuída à Pessoa';
	END IF;
    
	INSERT INTO pessoa_tem_permissao
		(pessoa_tem_funcao_id, permissoes_id)
	VALUES
		(p_pessoa_tem_funcao_id, p_permissao_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPessoaTemRedeSocial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPessoaTemRedeSocial`(
	IN p_perfil varchar(200)
  , IN p_rede_social_id int
  , IN p_pessoa_id int
)
BEGIN
	DECLARE c_rede_social INT;
    DECLARE c_pessoa INT;
    DECLARE c_pessoa_tem_rede_social INT;
    
    IF p_perfil IS NULL OR p_rede_social_id IS NULL OR p_pessoa_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_rede_social
    FROM rede_social
    WHERE rede_social.id = p_rede_social_id;
    IF c_rede_social = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Rede Social não cadastrada';
    END IF;

	SELECT COUNT(*) INTO c_pessoa
    FROM pessoa
    WHERE pessoa.id = p_pessoa_id;
    IF c_pessoa = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_pessoa_tem_rede_social
    FROM pessoa_tem_rede_social
    WHERE pessoa_tem_rede_social.pessoa_id = p_pessoa_id
     AND pessoa_tem_rede_social.rede_social_id = p_rede_social_id;
    IF c_pessoa_tem_rede_social > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Rede Social ja atribuída à Pessoa';
    END IF;
    
	INSERT INTO pessoa_tem_rede_social
		(perfil, rede_social_id, pessoa_id)
	VALUES
		(p_perfil, p_rede_social_id, p_pessoa_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPorte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPorte`(
	IN p_nome varchar(50)
  , IN p_tamanho_minimo int
  , IN p_tamanho_maximo int
  , IN p_peso_minimo int
  , IN p_peso_maximo int
)
BEGIN
	DECLARE c_nome INT;
    
    IF p_nome IS NULL OR p_tamanho_minimo IS NULL OR p_tamanho_maximo IS NULL OR p_peso_minimo IS NULL OR p_peso_maximo IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT count(*) INTO c_nome
      FROM porte
	 WHERE porte.nome = p_nome;
	IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte já cadastrado';
	END IF;
    
	INSERT INTO porte
		(nome, tamanho_minimo, tamanho_maximo, peso_minimo, peso_maximo)
	VALUES
		(p_nome, p_tamanho_minimo, p_tamanho_maximo, p_peso_minimo, p_peso_maximo);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insRaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insRaca`(
	IN p_nome varchar(50)
  , IN p_especie_id int
  , IN p_porte_id int
)
BEGIN

	DECLARE c_nome INT;
    DECLARE c_especie INT;
    DECLARE c_porte INT;

    IF p_nome IS NULL OR p_especie_id IS NULL OR p_porte_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_nome
    FROM raca
    WHERE raca.nome = p_nome;
    IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Raça já cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_especie
    FROM especie
    WHERE especie.id = p_especie_id;
    IF c_especie = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Espécie não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_porte
    FROM porte
    WHERE porte.id = p_porte_id;
    IF c_porte = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte não cadastrado';
    END IF;
    
	INSERT INTO raca
		(nome, especie_id, porte_id)
	VALUES
		(p_nome, p_especie_id, p_porte_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insRedeSocial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insRedeSocial`(
	IN p_nome varchar(50)
)
BEGIN
    
    DECLARE c_nome INT;
    
    IF p_nome IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_nome
    FROM rede_social
    WHERE rede_social.nome = p_nome;
    IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Rede Social já cadastrada';
    END IF;
    
	INSERT INTO rede_social
		(nome)
	VALUES
		(p_nome);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insRestricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insRestricao`(
	IN p_restricao varchar(50)
  , IN p_descricao varchar(200)
)
BEGIN

	DECLARE c_restricao INT;

    IF p_restricao IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_restricao
    FROM restricao
    WHERE restricao.restricao = p_restricao;
    IF c_restricao > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Restrição já cadastrada';
    END IF;
    
	INSERT INTO restricao
		(restricao, descricao)
	VALUES
		(p_restricao, p_descricao);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insServico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insServico`(
	IN p_servico varchar(50)
)
BEGIN

	DECLARE c_nome INT;
    
    IF p_servico IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_nome
    FROM servico
    WHERE servico.nome = p_servico;
    IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Servico já cadastrado';
    END IF;
    
	INSERT INTO servico
		(nome)
	VALUES
		(p_servico);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insServicoAgendado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insServicoAgendado`(
	IN p_preco decimal(10, 2)
  , IN p_recorrente tinyint(1)
  , IN p_data_hora datetime
  , IN p_servico_id int
  , IN p_animal_id int
  , IN p_servico_contratado_id int
  , IN p_executado tinyint(1)
  , IN p_pago tinyint(1)
  , IN p_observacao varchar(200)
  , IN p_data_hora_executado datetime
  , IN p_funcionario_executa_id int
  , IN p_cancelado tinyint(1)
)
BEGIN

	DECLARE c_servico INT;
    DECLARE c_animal INT;
    DECLARE c_servico_contratado INT;
    DECLARE c_servico_tem_porte INT;
    
    IF p_preco IS NULL OR p_recorrente IS NULL OR p_data_hora IS NULL
    OR p_servico_id IS NULL OR p_animal_id IS NULL OR p_servico_contratado_id IS NULL
    OR p_executado IS NULL OR p_pago IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_servico
    FROM servico
    WHERE servico.id = p_servico_id;
    IF c_servico = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_animal
    FROM animal
    WHERE animal.id = p_animal_id;
    IF c_animal = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Animal não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_servico_contratado
    FROM servico_contratado
    WHERE servico_contratado.id = p_servico_contratado_id;
    IF c_servico_contratado = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço Contratado não cadastrado';
    END IF;
    
    SELECT stp.id INTO c_servico_tem_porte
    FROM servico_tem_porte as stp
    INNER JOIN porte as p
    ON stp.porte_id = p.id
    WHERE stp.servico_id = p_servico_id
    AND stp.porte_id = (SELECT a.porte_id FROM animal as a WHERE a.id = p_animal_id);
    
	INSERT INTO servico_agendado
		(preco, recorrente, data_hora, servico_tem_porte_id, animal_id, servico_contratado_id
        , executado, pago, observacao, data_hora_executado, funcionario_executa_id, cancelado)
	VALUES
		(p_preco, p_recorrente, p_data_hora, c_servico_tem_porte, p_animal_id, p_servico_contratado_id
        , p_executado, p_pago, p_observacao, p_data_hora_executado, p_funcionario_executa_id, p_cancelado);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insServicoContratado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insServicoContratado`(
	IN p_pessoa_tem_funcao_id_funcionario int
  , IN p_preco decimal(10, 2)
  , IN p_transacao_id int
)
BEGIN

    DECLARE c_transacao INT;
    DECLARE c_funcionario INT;
    
	IF p_pessoa_tem_funcao_id_funcionario IS NULL OR p_preco IS NULL OR p_transacao_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Necessário informar código de registro';
    END IF;
    
    SELECT count(*) INTO c_transacao
	FROM transacao
	WHERE transacao.id = p_transacao_id;
	IF c_transacao = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Transação não cadastrada';
	END IF;
    
    SELECT count(*) INTO c_funcionario
	FROM pessoa_tem_funcao
	WHERE pessoa_tem_funcao.id = p_pessoa_tem_funcao_id_funcionario;
	IF c_funcionario = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Funcionário não cadastrado';
	END IF;
    
    INSERT INTO servico_contratado
		(pessoa_tem_funcao_id_funcionario, preco, data_hora, transacao_id)
	VALUES
		(p_pessoa_tem_funcao_id_funcionario, p_preco, NOW(), p_transacao_id);
    
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insServicoTemPorte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insServicoTemPorte`(
	IN p_servico_id int
  , IN p_porte_id int
  , IN p_preco decimal(10, 2)
)
BEGIN
    
    DECLARE c_servico INT;
    DECLARE c_porte INT;
    DECLARE c_servico_tem_porte INT;
    
    IF p_servico_id IS NULL OR p_porte_id IS NULL OR p_preco IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_servico
    FROM servico
    WHERE servico.id = p_servico_id;
    IF c_servico = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço não cadastrado';
    END IF;
    
    SELECT COUNT(*) INTO c_porte
    FROM porte
    WHERE porte.id = p_porte_id;
    IF c_porte = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Porte não cadastrado';
    END IF;
    
	SELECT COUNT(*) INTO c_servico_tem_porte
    FROM servico_tem_porte
    WHERE servico_tem_porte.servico_id = p_servico_id
     AND servico_tem_porte.porte_id = p_porte_id;
    IF c_servico_tem_porte > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Serviço já atribuído à Porte';
    END IF;
    
	INSERT INTO servico_tem_porte
		(servico_id, porte_id, preco)
	VALUES
		(p_servico_id, p_porte_id, p_preco);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insTelefone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insTelefone`(
	IN p_numero int
  , IN p_codigo_area int
  , IN p_codigo_pais varchar(3)
  , IN p_pessoa_id int
)
BEGIN

	DECLARE c_telefone INT;
	DECLARE c_pessoa INT;
    
    IF p_numero IS NULL OR p_codigo_area IS NULL OR p_codigo_pais IS NULL OR p_pessoa_id IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_pessoa
    FROM pessoa
    WHERE pessoa.id = p_pessoa_id;
    IF c_pessoa = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Pessoa não cadastrada';
    END IF;
    
    SELECT COUNT(*) INTO c_telefone 
    FROM telefone 
    WHERE telefone.codigo_area = p_codigo_area 
    AND telefone.codigo_pais = p_codigo_pais 
    AND telefone.numero = p_numero;
    IF c_telefone > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Telefone já cadastrado';
	END IF;
    
	INSERT INTO telefone
		(numero, codigo_area, codigo_pais, pessoa_id)
	VALUES
		(p_numero, p_codigo_area, p_codigo_pais, p_pessoa_id);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insTransacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insTransacao`(
	IN p_tipo char(1)
  , IN p_valor decimal(10, 2)
  , IN p_comentario decimal(10, 2)
)
BEGIN
    
    IF p_tipo IS NULL OR p_valor IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
	INSERT INTO transacao
		(tipo, valor, data_hora, comentario)
	VALUES
		(p_tipo, p_valor, NOW(), p_comentario);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insVacina` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insVacina`(
	IN p_nome varchar(50)
  , IN p_dose int
  , IN p_intervalo int
)
BEGIN

	DECLARE c_lote INT;
	DECLARE c_nome INT;

    IF p_nome IS NULL OR p_dose IS NULL OR p_intervalo IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT COUNT(*) INTO c_nome
    FROM vacina
    WHERE vacina.nome = p_nome;
    IF c_nome > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Vacina já cadastrada';
    END IF;
    
	INSERT INTO vacina
		(nome, dose, intervalo)
	VALUES
		(p_nome, p_dose, p_intervalo);
	
    SELECT last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insVacinaTemLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insVacinaTemLote`(
		IN p_vacina_id INT
	,	IN p_lote_id INT
    ,	IN p_quantidade INT
)
BEGIN

	DECLARE c_vacina INT;
    DECLARE c_lote INT;
    DECLARE c_vacina_tem_lote INT;
    
    IF p_vacina_id IS NULL OR p_lote_id IS NULL OR p_quantidade IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT count(*) INTO c_vacina
      FROM vacina
	 WHERE vacina.id = p_vacina_id;
	IF c_vacina = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Vacina não cadastrada';
	END IF;
    
    SELECT count(*) INTO c_lote
      FROM lote
	 WHERE lote.id = p_lote_id;
	IF c_lote = 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lote não cadastrada';
	END IF;
    
    SELECT count(*) INTO c_vacina_tem_lote
      FROM vacina_tem_lote
	 WHERE vacina_id = p_vacina_id
	   AND lote_id = p_lote_id;
	IF c_vacina_tem_lote > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Lote já atribuído à Vacina';
	END IF;
    
	INSERT INTO vacina_tem_lote
		(vacina_id, lote_id, quantidade)
	VALUES
		(p_vacina_id, p_lote_id, p_quantidade);
	
    SELECT last_insert_id();
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `animais_dia`
--

/*!50001 DROP TABLE IF EXISTS `animais_dia`*/;
/*!50001 DROP VIEW IF EXISTS `animais_dia`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `animais_dia` AS select `animal`.`nome` AS `nome`,`servico_agendado`.`data_hora` AS `data_hora` from (`servico_agendado` join `animal`) where ((`servico_agendado`.`animal_id` = `animal`.`id`) and (`servico_agendado`.`executado` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tipo_funcao`
--

/*!50001 DROP TABLE IF EXISTS `tipo_funcao`*/;
/*!50001 DROP VIEW IF EXISTS `tipo_funcao`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tipo_funcao` AS select `funcao`.`nome` AS `nome`,`pessoa_tem_funcao`.`id` AS `id` from (`pessoa_tem_funcao` join `funcao`) where (`pessoa_tem_funcao`.`funcao_id` = `funcao`.`id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tipo_servico`
--

/*!50001 DROP TABLE IF EXISTS `tipo_servico`*/;
/*!50001 DROP VIEW IF EXISTS `tipo_servico`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tipo_servico` AS select `servico`.`nome` AS `nome`,`servico_agendado`.`id` AS `id` from ((`servico_agendado` join `servico`) join `servico_tem_porte`) where ((`servico_agendado`.`servico_tem_porte_id` = `servico_tem_porte`.`id`) and (`servico_tem_porte`.`servico_id` = `servico`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-21 23:48:56
