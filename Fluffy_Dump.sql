CREATE DATABASE  IF NOT EXISTS `pet_shop` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `pet_shop`;
-- MySQL dump 10.13  Distrib 5.5.50, for debian-linux-gnu (i686)
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
  `peso` int(11) DEFAULT NULL COMMENT 'Em gramas, maior que 0',
  `tamanho` int(11) DEFAULT NULL COMMENT 'Em centímetros, maior que 0',
  `temperatura` int(11) DEFAULT NULL COMMENT 'Em graus, maior que 0',
  `servico_agendado_id` int(11) NOT NULL COMMENT 'Serviço (consulta) no qual a anamnese foi feita',
  PRIMARY KEY (`id`),
  KEY `fk_anamnese_servico_agendado1_idx` (`servico_agendado_id`),
  CONSTRAINT `fk_anamnese_servico_agendado1` FOREIGN KEY (`servico_agendado_id`) REFERENCES `servico_agendado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anamnese`
--

LOCK TABLES `anamnese` WRITE;
/*!40000 ALTER TABLE `anamnese` DISABLE KEYS */;
/*!40000 ALTER TABLE `anamnese` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`anamnese_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`anamnese`
FOR EACH ROW
BEGIN
		DECLARE servico VARCHAR(50);
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:anamnese] - ";

		IF (NEW.peso <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", peso");
            ELSE
				SET error_message = CONCAT(error_message, "peso");
            END IF;
		END IF;
        
        IF (NEW.tamanho <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", tamanho");
            ELSE
				SET error_message = CONCAT(error_message, "tamanho");
            END IF;
		END IF;
		
		IF (NEW.temperatura <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", temperatura");
            ELSE
				SET error_message = CONCAT(error_message, "temperatura");
            END IF;
		END IF;
        
        SELECT nome INTO servico FROM tipo_servico WHERE id = NEW.servico_agendado_id;
		IF(servico <> 'consulta') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", servico");
			ELSE
				SET error_message = CONCAT(error_message, "servico");
			END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`anamnese_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`anamnese`
FOR EACH ROW
BEGIN
DECLARE servico VARCHAR(50);
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:anamnese] - ";

		IF (NEW.peso <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", peso");
            ELSE
				SET error_message = CONCAT(error_message, "peso");
            END IF;
		END IF;
        
        IF (NEW.tamanho <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", tamanho");
            ELSE
				SET error_message = CONCAT(error_message, "tamanho");
            END IF;
		END IF;
		
		IF (NEW.temperatura <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", temperatura");
            ELSE
				SET error_message = CONCAT(error_message, "temperatura");
            END IF;
		END IF;
        
        SELECT nome INTO servico FROM tipo_servico WHERE id = NEW.servico_agendado_id;
		IF(servico <> 'consulta') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", servico");
			ELSE
				SET error_message = CONCAT(error_message, "servico");
			END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
  `pessoa_tem_funcao_id` int(11) NOT NULL COMMENT 'O animal pertence à uma pessoa',
  `raca_id` int(11) NOT NULL COMMENT 'O animal possui uma raça',
  `porte_id` int(11) NOT NULL COMMENT 'O animal está com um porte específico',
  PRIMARY KEY (`id`),
  KEY `fk_animal_pessoa_tem_funcao1_idx` (`pessoa_tem_funcao_id`),
  KEY `fk_animal_raca1_idx` (`raca_id`),
  KEY `fk_animal_porte1_idx` (`porte_id`),
  CONSTRAINT `fk_animal_pessoa_tem_funcao1` FOREIGN KEY (`pessoa_tem_funcao_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_porte1` FOREIGN KEY (`porte_id`) REFERENCES `porte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_raca1` FOREIGN KEY (`raca_id`) REFERENCES `raca` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (1,'Nina','F','2016-08-29 21:39:44','2013-05-11 00:00:00',2,3,16),(2,'Luna','F','2016-08-29 21:40:15','2016-01-21 00:00:00',2,2,16),(3,'Suzy','F','2016-08-29 21:42:03','2006-10-03 00:00:00',2,1,17),(4,'Pucca','F','2016-08-29 21:42:10','2006-10-03 00:00:00',2,1,17);
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`animal_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`animal`
FOR EACH ROW
BEGIN

	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE tipo_pessoa VARCHAR(50);
        
	SET invalid = 0;
	SET error_message = "[tabela:animal] - ";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
    END IF;
    
    
    IF(NEW.sexo <> 'M' && NEW.sexo <> 'F') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", sexo");
		ELSE
			SET error_message = CONCAT(error_message, "sexo");
		END IF;
    END IF;
    
    IF(NEW.data_hora_cadastro <> NOW()) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", data_hora_cadastro");
		ELSE
			SET error_message = CONCAT(error_message, "data_hora_cadastro");
		END IF;
    END IF;
    
    IF(NEW.data_nascimento > NOW()) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", data_nascimento");
		ELSE
			SET error_message = CONCAT(error_message, "data_nascimento");
		END IF;
    END IF;
    
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id;
    IF(tipo_pessoa <> 'cliente' AND tipo_pessoa <> 'cliente_especial') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", pessoa");
		ELSE
			SET error_message = CONCAT(error_message, "pessoa");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`animal_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`animal`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE tipo_pessoa VARCHAR(50);
        
	SET invalid = 0;
	SET error_message = "[tabela:animal] - ";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
    END IF;
    
    IF(NEW.sexo <> 'M' OR NEW.sexo <> 'F') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", sexo");
		ELSE
			SET error_message = CONCAT(error_message, "sexo");
		END IF;
    END IF;
    
    IF(NEW.data_hora_cadastro <> NOW()) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", data_hora_cadastro");
		ELSE
			SET error_message = CONCAT(error_message, "data_hora_cadastro");
		END IF;
    END IF;
    
    IF(NEW.data_nascimento > NOW()) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", data_nascimento");
		ELSE
			SET error_message = CONCAT(error_message, "data_nascimento");
		END IF;
    END IF;
    
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE pessoa_tem_funcao_id = NEW.pessoa_tem_funcao_id;
    IF(nome <> 'cliente' OR nome <> 'cliente_especial') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", pessoa");
		ELSE
			SET error_message = CONCAT(error_message, "pessoa");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, " inválidos!");
		ELSE
			SET error_message = CONCAT(error_message, " inválido!");
		END IF;
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
  `animal_id` int(11) NOT NULL COMMENT 'Qual é a restrição do animal',
  PRIMARY KEY (`id`),
  KEY `fk_animal_tem_restricao_restricao1_idx` (`restricao_id`),
  KEY `fk_animal_tem_restricao_animal1_idx` (`animal_id`),
  CONSTRAINT `fk_animal_tem_restricao_animal1` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_tem_restricao_restricao1` FOREIGN KEY (`restricao_id`) REFERENCES `restricao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal_tem_restricao`
--

LOCK TABLES `animal_tem_restricao` WRITE;
/*!40000 ALTER TABLE `animal_tem_restricao` DISABLE KEYS */;
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
  `vacina_id` int(11) NOT NULL COMMENT 'Aplicação de qual vacina',
  `servico_agendado_id` int(11) NOT NULL COMMENT 'Serviço associado (consulta)',
  PRIMARY KEY (`id`),
  KEY `fk_aplicacao_vacina1_idx` (`vacina_id`),
  KEY `fk_aplicacao_servico_agendado1_idx` (`servico_agendado_id`),
  CONSTRAINT `fk_aplicacao_servico_agendado1` FOREIGN KEY (`servico_agendado_id`) REFERENCES `servico_agendado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_aplicacao_vacina1` FOREIGN KEY (`vacina_id`) REFERENCES `vacina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aplicacao`
--

LOCK TABLES `aplicacao` WRITE;
/*!40000 ALTER TABLE `aplicacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `aplicacao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`aplicacao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`aplicacao`
FOR EACH ROW
BEGIN
		DECLARE vencimento_data DATE;
		DECLARE servico VARCHAR(50);
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:aplicacao] - ";
        
        SELECT nome INTO servico FROM tipo_servico WHERE id = NEW.servico_agendado_id;
		IF(servico <> 'consulta') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", servico");
			ELSE
				SET error_message = CONCAT(error_message, "servico");
			END IF;
		END IF;
        
        SELECT vencimento INTO vencimento_data FROM vacina WHERE NEW.vacina_id = vacina.id;
        IF (vencimento_data < NOW()) THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", validade");
			ELSE
				SET error_message = CONCAT(error_message, "validade");
			END IF;
        END IF;
        
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`aplicacao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`aplicacao`
FOR EACH ROW
BEGIN
DECLARE vencimento_data DATE;
		DECLARE servico VARCHAR(50);
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:aplicacao] - ";
        
        SELECT nome INTO servico FROM tipo_servico WHERE id = NEW.servico_agendado_id;
		IF(servico <> 'consulta') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", servico");
			ELSE
				SET error_message = CONCAT(error_message, "servico");
			END IF;
		END IF;
        
        SELECT vencimento INTO vencimento_data FROM vacina WHERE NEW.vacina_id = vacina.id;
        IF (vencimento_data < NOW()) THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", validade");
			ELSE
				SET error_message = CONCAT(error_message, "validade");
			END IF;
        END IF;
        
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
-- Table structure for table `cidade`
--

DROP TABLE IF EXISTS `cidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(100) NOT NULL COMMENT 'Nome da cidade',
  `estado_id` int(11) NOT NULL COMMENT 'Estado à qual pertence',
  PRIMARY KEY (`id`),
  KEY `fk_cidade_estado1_idx` (`estado_id`),
  CONSTRAINT `fk_cidade_estado1` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidade`
--

LOCK TABLES `cidade` WRITE;
/*!40000 ALTER TABLE `cidade` DISABLE KEYS */;
INSERT INTO `cidade` VALUES (1,'Ponta Grossa',1);
/*!40000 ALTER TABLE `cidade` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`cidade_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`cidade`
FOR EACH ROW
BEGIN

	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:cidade] - ";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`cidade_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`cidade`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:cidade] - ";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
-- Table structure for table `configuracao`
--

DROP TABLE IF EXISTS `configuracao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracao` (
  `quantidade_animais` int(11) NOT NULL DEFAULT '0' COMMENT 'Quantidade em unidades máxima de animais por período',
  `periodos_dia` int(11) NOT NULL DEFAULT '0' COMMENT 'Quantidade em unidades de períodos em um dia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracao`
--

LOCK TABLES `configuracao` WRITE;
/*!40000 ALTER TABLE `configuracao` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuracao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`configuracao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`configuracao`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:configuracao] - ";

		IF (NEW.quantidade_animais < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", quantidade_animais");
            ELSE
				SET error_message = CONCAT(error_message, "quantidade_animais");
            END IF;
		END IF;
		
		IF (NEW.periodos_dia < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", periodos_dia");
            ELSE
				SET error_message = CONCAT(error_message, "periodos_dia");
            END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`configuracao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`configuracao`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:configuracao] - ";

		IF (NEW.quantidade_animais < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", quantidade_animais");
            ELSE
				SET error_message = CONCAT(error_message, "quantidade_animais");
            END IF;
		END IF;
		
		IF (NEW.periodos_dia < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", periodos_dia");
            ELSE
				SET error_message = CONCAT(error_message, "periodos_dia");
            END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Nome do estado',
  `uf` varchar(2) NOT NULL COMMENT 'Unidade Federativa',
  `pais_id` int(11) NOT NULL COMMENT 'País à qual pertence',
  PRIMARY KEY (`id`),
  KEY `fk_estado_pais1_idx` (`pais_id`),
  CONSTRAINT `fk_estado_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'Paraná','PR',1);
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`estado_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`estado`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:estado] - ";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`estado_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`estado`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:estado] - ";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcao`
--

LOCK TABLES `funcao` WRITE;
/*!40000 ALTER TABLE `funcao` DISABLE KEYS */;
INSERT INTO `funcao` VALUES (1,'cliente'),(2,'cliente-especial'),(3,'funcionario'),(4,'administrador');
/*!40000 ALTER TABLE `funcao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`funcao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`funcao`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:funcao] - ";

	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
	END IF;
	
	IF (invalid > 0) THEN
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, " inválidos!");
		ELSE
			SET error_message = CONCAT(error_message, " inválido!");
		END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`funcao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`funcao`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	
    SET invalid = 0;
	SET error_message = "[tabela:funcao] - ";

	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
	END IF;
	
	IF (invalid > 0) THEN
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, " inválidos!");
		ELSE
			SET error_message = CONCAT(error_message, " inválido!");
		END IF;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_de_item`
--

LOCK TABLES `grupo_de_item` WRITE;
/*!40000 ALTER TABLE `grupo_de_item` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`item`
FOR EACH ROW
BEGIN

        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:item] - ";

		IF (NEW.preco <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", preco");
            ELSE
				SET error_message = CONCAT(error_message, "preco");
            END IF;
		END IF;
        
        IF (NEW.data_hora_cadastro <> NOW()) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", data_hora_cadastro");
            ELSE
				SET error_message = CONCAT(error_message, "data_hora_cadastro");
            END IF;
		END IF;
		
        IF (NEW.quantidade < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", quantidade");
            ELSE
				SET error_message = CONCAT(error_message, "quantidade");
            END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`item`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:item] - ";

		IF (NEW.preco <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", preco");
            ELSE
				SET error_message = CONCAT(error_message, "preco");
            END IF;
		END IF;
        
        IF (NEW.data_hora_cadastro <> NOW()) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", data_hora_cadastro");
            ELSE
				SET error_message = CONCAT(error_message, "data_hora_cadastro");
            END IF;
		END IF;
		
        IF (NEW.quantidade < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", quantidade");
            ELSE
				SET error_message = CONCAT(error_message, "quantidade");
            END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_de_venda`
--

LOCK TABLES `item_de_venda` WRITE;
/*!40000 ALTER TABLE `item_de_venda` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_de_venda` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_de_venda_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`item_de_venda`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:item_de_venda] - ";

		IF (NEW.preco <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", preco");
            ELSE
				SET error_message = CONCAT(error_message, "preco");
            END IF;
		END IF;
        
        IF (NEW.quantidade < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", quantidade");
            ELSE
				SET error_message = CONCAT(error_message, "quantidade");
            END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`item_de_venda_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`item_de_venda`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:item_de_venda] - ";

		IF (NEW.preco <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", preco");
            ELSE
				SET error_message = CONCAT(error_message, "preco");
            END IF;
		END IF;
        
        IF (NEW.quantidade < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", quantidade");
            ELSE
				SET error_message = CONCAT(error_message, "quantidade");
            END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
-- Table structure for table `lembrete`
--

DROP TABLE IF EXISTS `lembrete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lembrete` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `descricao` varchar(200) NOT NULL COMMENT 'Descrição do lembrete',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lembrete`
--

LOCK TABLES `lembrete` WRITE;
/*!40000 ALTER TABLE `lembrete` DISABLE KEYS */;
/*!40000 ALTER TABLE `lembrete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote`
--

DROP TABLE IF EXISTS `lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lote` (
  `id` int(11) NOT NULL,
  `numero` varchar(50) NOT NULL,
  `vencimento` date NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote`
--

LOCK TABLES `lote` WRITE;
/*!40000 ALTER TABLE `lote` DISABLE KEYS */;
/*!40000 ALTER TABLE `lote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `nome` varchar(50) NOT NULL COMMENT 'Nome do país',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES (1,'Brasil');
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pais_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`pais`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:pais] - ";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pais_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`pais`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:pais] - ";
    
	IF NOT nome_valido(NEW.nome) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", nome");
		ELSE
			SET error_message = CONCAT(error_message, "nome");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pedido_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`pedido`
FOR EACH ROW
BEGIN
		DECLARE pessoa_cliente VARCHAR(50);
        DECLARE pessoa_funcionario VARCHAR(50);
		DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:pedido] - ";

		IF (NEW.valor <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", valor");
            ELSE
				SET error_message = CONCAT(error_message, "valor");
            END IF;
		END IF;
        
        IF (NEW.desconto < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", desconto");
            ELSE
				SET error_message = CONCAT(error_message, "desconto");
            END IF;
		END IF;
        
        SELECT nome INTO pessoa_funcionario FROM tipo_funcao WHERE id = NEW.funcionario_id;
		IF(pessoa_funcionario <> 'funcionario' AND pessoa_funcionario <> 'fornecedor') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", funcionario");
			ELSE
				SET error_message = CONCAT(error_message, "funcionario");
			END IF;
		END IF;
        
        SELECT nome INTO pessoa_cliente FROM tipo_funcao WHERE id = NEW.cliente_id;
		IF(pessoa_cliente <> 'cliente' AND pessoa_cliente <> 'cliente_especial') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", cliente");
			ELSE
				SET error_message = CONCAT(error_message, "cliente");
			END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pedido_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`pedido`
FOR EACH ROW
BEGIN
		DECLARE pessoa_cliente VARCHAR(50);
        DECLARE pessoa_funcionario VARCHAR(50);
		DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:pedido] - ";

		IF (NEW.valor <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", valor");
            ELSE
				SET error_message = CONCAT(error_message, "valor");
            END IF;
		END IF;
        
        IF (NEW.desconto < 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", desconto");
            ELSE
				SET error_message = CONCAT(error_message, "desconto");
            END IF;
		END IF;
        
        SELECT nome INTO pessoa_funcionario FROM tipo_funcao WHERE id = NEW.funcionario_id;
		IF(pessoa_funcionario <> 'funcionario' AND pessoa_funcionario <> 'fornecedor') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", funcionario");
			ELSE
				SET error_message = CONCAT(error_message, "funcionario");
			END IF;
		END IF;
        
        SELECT nome INTO pessoa_cliente FROM tipo_funcao WHERE id = NEW.cliente_id;
		IF(pessoa_cliente <> 'cliente' AND pessoa_cliente <> 'cliente_especial') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", cliente");
			ELSE
				SET error_message = CONCAT(error_message, "cliente");
			END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
-- Table structure for table `permissoes`
--

DROP TABLE IF EXISTS `permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `modulo` varchar(50) NOT NULL COMMENT 'Descrição da permissão, somente o administrador pode alterar',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissoes`
--

LOCK TABLES `permissoes` WRITE;
/*!40000 ALTER TABLE `permissoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissoes` ENABLE KEYS */;
UNLOCK TABLES;

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
  `logradouro` varchar(100) NOT NULL,
  `numero` int(11) NOT NULL,
  `complemento` varchar(50) DEFAULT NULL,
  `cep` varchar(8) NOT NULL,
  `ponto_de_referencia` varchar(200) DEFAULT NULL,
  `cidade_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `registro_UNIQUE` (`registro`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_pessoa_cidade1_idx` (`cidade_id`),
  CONSTRAINT `fk_pessoa_cidade1` FOREIGN KEY (`cidade_id`) REFERENCES `cidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (11,'Andre Cadamuro Garcia','2016-08-29 00:00:31','andrecadgarcia@gmail.com','08815094938','Rua do Rosário',1060,'Apartamento 202','84010150','Farmácia',1),(13,'Alessandra Bitobrovec','2016-08-29 00:03:20','alebito@gmail.com','79488137134','Rua ludgéro Pavão',402,NULL,'84020580',NULL,1);
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`pessoa`
FOR EACH ROW
BEGIN
		
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:pessoa] - ";

		IF NOT nome_valido(NEW.nome) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", nome");
            ELSE
				SET error_message = CONCAT(error_message, "nome");
            END IF;
		END IF;
        
        IF (NEW.data_hora_cadastro <> NOW()) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", data_hora_cadastro");
            ELSE
				SET error_message = CONCAT(error_message, "data_hora_cadastro");
            END IF;
		END IF;
		
		IF NOT email_valido(NEW.email) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", email");
            ELSE
				SET error_message = CONCAT(error_message, "email");
            END IF;
		END IF;
        
        IF NOT (cpf_valido(NEW.registro) OR cnpj_valido(NEW.registro)) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", registro");
            ELSE
				SET error_message = CONCAT(error_message, "registro");
            END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`pessoa`
FOR EACH ROW
BEGIN
	
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:pessoa] - ";

		IF NOT nome_valido(NEW.nome) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", nome");
            ELSE
				SET error_message = CONCAT(error_message, "nome");
            END IF;
		END IF;
        
        IF (NEW.data_hora_cadastro <> NOW()) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", data_hora_cadastro");
            ELSE
				SET error_message = CONCAT(error_message, "data_hora_cadastro");
            END IF;
		END IF;
		
		IF NOT email_valido(NEW.email) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", email");
            ELSE
				SET error_message = CONCAT(error_message, "email");
            END IF;
		END IF;
        
        IF NOT (cpf_valido(NEW.registro) OR cnpj_valido(NEW.registro)) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", registro");
            ELSE
				SET error_message = CONCAT(error_message, "registro");
            END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
  PRIMARY KEY (`id`),
  KEY `fk_pessoa_has_funcao_funcao1_idx` (`funcao_id`),
  KEY `fk_pessoa_has_funcao_pessoa1_idx` (`pessoa_id`),
  CONSTRAINT `fk_pessoa_has_funcao_funcao1` FOREIGN KEY (`funcao_id`) REFERENCES `funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_has_funcao_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_tem_funcao`
--

LOCK TABLES `pessoa_tem_funcao` WRITE;
/*!40000 ALTER TABLE `pessoa_tem_funcao` DISABLE KEYS */;
INSERT INTO `pessoa_tem_funcao` VALUES (1,11,1),(2,13,1);
/*!40000 ALTER TABLE `pessoa_tem_funcao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_tem_funcao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`pessoa_tem_funcao`
FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
	DECLARE funcao_nome VARCHAR(50);
    DECLARE verifica VARCHAR(10);
    DECLARE pessoa_registro VARCHAR(15);

	SET error_message = "[tabela:pessoa_tem_funcao] - ";

	SELECT nome INTO funcao_nome
		FROM funcao
		WHERE id = NEW.funcao_id;

    SELECT registro INTO pessoa_registro
		FROM pessoa
		WHERE id = NEW.pessoa_id;
    
	CASE funcao_nome
		WHEN "cliente" THEN SELECT "cpf" INTO verifica;
        WHEN "cliente_especial" THEN SELECT "cpf" INTO verifica;
        WHEN "funcionario" THEN SELECT "cpf" INTO verifica;
        WHEN "fornecedor" THEN SELECT "cnpj" INTO verifica;
        WHEN "terceiro" THEN SELECT "cnpj" INTO verifica;
        ELSE SELECT "erro" INTO verifica;
	END CASE;
    
    IF(verifica = "cpf") THEN
		IF NOT cpf_valido(pessoa_registro) THEN
			SET error_message = CONCAT(error_message, "cpf inválido!"); 
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = error_message;
        END IF;
    ELSEIF(verifica = "cnpj") THEN
		IF NOT cnpj_valido(pessoa_registro) THEN
			SET error_message = CONCAT(error_message, "cnpj inválido!"); 
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = error_message;
        END IF;
    ELSE
		SET error_message = CONCAT(error_message, "tipo de registro não definido!");
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_tem_funcao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`pessoa_tem_funcao`
FOR EACH ROW
BEGIN
	DECLARE error_message VARCHAR(100);
	DECLARE funcao_nome VARCHAR(50);
    DECLARE verifica VARCHAR(10);
    DECLARE registro VARCHAR(15);

	SET error_message = "[tabela:pessoa_tem_funcao] - ";

	SELECT funcao.nome, pessoa.registro INTO funcao_nome, registro
		FROM pessoa_tem_funcao
		INNER JOIN funcao
        INNER JOIN pessoa
        WHERE pessoa.id = NEW.pessoa_id
        AND funcao.id = NEW.funcao_id;
        
	CASE funcao_nome
		WHEN "cliente" THEN SELECT "cpf" INTO verifica;
        WHEN "cliente_especial" THEN SELECT "cpf" INTO verifica;
        WHEN "funcionario" THEN SELECT "cpf" INTO verifica;
        WHEN "fornecedor" THEN SELECT "cnpj" INTO verifica;
        WHEN "terceiro" THEN SELECT "cnpj" INTO verifica;
	END CASE;
    
    IF(verifica = "cpf") THEN
		IF NOT cpf_valido(registro) THEN
			SET error_message = CONCAT(error_message, "cpf inválido!"); 
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = error_message;
        END IF;
    ELSEIF(verifica = "cnpj") THEN
		IF NOT cnpj_valido(registro) THEN
			SET error_message = CONCAT(error_message, "cnpj inválido!"); 
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = error_message;
        END IF;
    ELSE
		SET error_message = CONCAT(error_message, "tipo de registro não definido!");
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
-- Table structure for table `pessoa_tem_permissoes`
--

DROP TABLE IF EXISTS `pessoa_tem_permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa_tem_permissoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `pessoa_tem_funcao_id` int(11) NOT NULL COMMENT 'Dá à uma pessoa alguma permissão no sistema, como funcionário ser banhista',
  `permissoes_id` int(11) NOT NULL COMMENT 'Permissão da pessoa',
  PRIMARY KEY (`id`),
  KEY `fk_pessoa_tem_funcao_has_permissoes_permissoes1_idx` (`permissoes_id`),
  KEY `fk_pessoa_tem_funcao_has_permissoes_pessoa_tem_funcao1_idx` (`pessoa_tem_funcao_id`),
  CONSTRAINT `fk_pessoa_tem_funcao_has_permissoes_permissoes1` FOREIGN KEY (`permissoes_id`) REFERENCES `permissoes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_tem_funcao_has_permissoes_pessoa_tem_funcao1` FOREIGN KEY (`pessoa_tem_funcao_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_tem_permissoes`
--

LOCK TABLES `pessoa_tem_permissoes` WRITE;
/*!40000 ALTER TABLE `pessoa_tem_permissoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `pessoa_tem_permissoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_tem_permissoes_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`pessoa_tem_permissoes`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE tipo_pessoa VARCHAR(50);
        
	SET invalid = 0;
	SET error_message = "[tabela:pessoa_tem_permissoes] - ";
    
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id;
    IF(tipo_pessoa <> 'funcionario' AND tipo_pessoa <> 'administrador') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", pessoa");
		ELSE
			SET error_message = CONCAT(error_message, "pessoa");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`pessoa_tem_permissoes_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`pessoa_tem_permissoes`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
	DECLARE tipo_pessoa VARCHAR(50);
        
	SET invalid = 0;
	SET error_message = "[tabela:pessoa_tem_permissoes] - ";
    
    SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id;
    IF(tipo_pessoa <> 'funcionario' AND tipo_pessoa <> 'administrador') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", pessoa");
		ELSE
			SET error_message = CONCAT(error_message, "pessoa");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_tem_rede_social`
--

LOCK TABLES `pessoa_tem_rede_social` WRITE;
/*!40000 ALTER TABLE `pessoa_tem_rede_social` DISABLE KEYS */;
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
  `tamanho_minimo` int(11) DEFAULT NULL COMMENT 'Tamanho mínimo do animal em centímetros',
  `tamanho_maximo` int(11) DEFAULT NULL COMMENT 'Tamanho máximo do animal em centímetros',
  `peso_minimo` int(11) DEFAULT NULL,
  `peso_maximo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `porte`
--

LOCK TABLES `porte` WRITE;
/*!40000 ALTER TABLE `porte` DISABLE KEYS */;
INSERT INTO `porte` VALUES (15,'Mini',1,28,0,6),(16,'Pequeno',29,35,7,15),(17,'Médio 1',36,49,16,25),(18,'Grande 1',50,69,26,45),(19,'Extra',70,100,46,60),(20,'Pelo Curto',1,100,0,100),(21,'Pelo Longo',1,100,0,100),(22,'Médio 2',36,49,16,25),(23,'Mini Peludo',1,28,0,6),(24,'Grande 2',50,69,26,45),(25,'Todos',1,100,0,100);
/*!40000 ALTER TABLE `porte` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`porte_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`porte`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:porte] - ";
    
    IF(NEW.tamanho_minimo <= 0) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", tamanho_minimo");
		ELSE
			SET error_message = CONCAT(error_message, "tamanho_minimo");
		END IF;
    END IF;
    
    IF(NEW.tamanho_maximo <= NEW.tamanho_minimo) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", tamanho_maximo");
		ELSE
			SET error_message = CONCAT(error_message, "tamanho_maximo");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`porte_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`porte`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:porte] - ";
    
    IF(NEW.tamanho_minimo <= 0) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", tamanho_minimo");
		ELSE
			SET error_message = CONCAT(error_message, "tamanho_minimo");
		END IF;
    END IF;
    
    IF(NEW.tamanho_maximo <= NEW.tamanho_minimo) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", tamanho_maximo");
		ELSE
			SET error_message = CONCAT(error_message, "tamanho_maximo");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
  `porte_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_raca_especie1_idx` (`especie_id`),
  KEY `fk_raca_porte1_idx` (`porte_id`),
  CONSTRAINT `fk_raca_especie1` FOREIGN KEY (`especie_id`) REFERENCES `especie` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_raca_porte1` FOREIGN KEY (`porte_id`) REFERENCES `porte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raca`
--

LOCK TABLES `raca` WRITE;
/*!40000 ALTER TABLE `raca` DISABLE KEYS */;
INSERT INTO `raca` VALUES (1,'Cocker',1,17),(2,'Yorkshire',1,16),(3,'Lhasa apso',1,16);
/*!40000 ALTER TABLE `raca` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rede_social`
--

LOCK TABLES `rede_social` WRITE;
/*!40000 ALTER TABLE `rede_social` DISABLE KEYS */;
/*!40000 ALTER TABLE `rede_social` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restricao`
--

LOCK TABLES `restricao` WRITE;
/*!40000 ALTER TABLE `restricao` DISABLE KEYS */;
/*!40000 ALTER TABLE `restricao` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

LOCK TABLES `servico` WRITE;
/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
INSERT INTO `servico` VALUES (1,'Banho'),(2,'Tosa'),(3,'Pacote'),(4,'Adicional Toalha'),(5,'Escovação de Dentes'),(6,'Remoção de Pelo Morto'),(7,'Taxa de Desembolo'),(8,'Tosa Higiênica'),(9,'Hidratação');
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`servico`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:servico] - ";
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`servico`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:servico] - ";
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
  `servico_id` int(11) NOT NULL COMMENT 'O serviço agendado',
  `animal_id` int(11) NOT NULL COMMENT 'Animal que vai receber o serviço',
  `servico_contratado_id` int(11) NOT NULL COMMENT 'O serviço agendado pertence à um contrato',
  `executado` tinyint(1) NOT NULL COMMENT 'Controla se já foi executado ou não',
  `pago` tinyint(1) NOT NULL COMMENT 'Controla se já foi realizado seu pagamento',
  `observacao` varchar(200) DEFAULT NULL COMMENT 'Informações adicionais',
  `data_hora_executado` datetime DEFAULT NULL COMMENT 'Momento em que foi executado',
  `funcionario_executa_id` int(11) DEFAULT NULL COMMENT 'Funcionário que executou o serviço',
  PRIMARY KEY (`id`),
  KEY `fk_servico_agendado_servico1_idx` (`servico_id`),
  KEY `fk_servico_agendado_animal1_idx` (`animal_id`),
  KEY `fk_servico_agendado_servico_contratado1_idx` (`servico_contratado_id`),
  KEY `fk_servico_agendado_pessoa_tem_funcao1_idx` (`funcionario_executa_id`),
  CONSTRAINT `fk_servico_agendado_animal1` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_pessoa_tem_funcao1` FOREIGN KEY (`funcionario_executa_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_servico_contratado1` FOREIGN KEY (`servico_contratado_id`) REFERENCES `servico_contratado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_agendado`
--

LOCK TABLES `servico_agendado` WRITE;
/*!40000 ALTER TABLE `servico_agendado` DISABLE KEYS */;
/*!40000 ALTER TABLE `servico_agendado` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_agendado_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`servico_agendado`
FOR EACH ROW
BEGIN
		DECLARE numero_animais INT;
        DECLARE tipo_pessoa VARCHAR(50);
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:servico_agendado] - ";

		IF (NEW.preco <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", preco");
            ELSE
				SET error_message = CONCAT(error_message, "preco");
            END IF;
		END IF;
		
        SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.funcionario_executa_id;
		IF(tipo_pessoa <> 'funcionario') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", pessoa");
			ELSE
				SET error_message = CONCAT(error_message, "pessoa");
			END IF;
		END IF;
        
        SELECT COUNT(*) INTO numero_animais FROM animais_dia WHERE data_hora = NEW.data_hora;
		IF(numero_animais <= (SELECT quantidade_animais FROM configuracao)) THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", data_hora");
			ELSE
				SET error_message = CONCAT(error_message, "data_hora");
			END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_agendado_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`servico_agendado`
FOR EACH ROW
BEGIN
DECLARE numero_animais INT;
        DECLARE tipo_pessoa VARCHAR(50);
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:servico_agendado] - ";

		IF (NEW.preco <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", preco");
            ELSE
				SET error_message = CONCAT(error_message, "preco");
            END IF;
		END IF;
		
        SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.funcionario_executa_id;
		IF(tipo_pessoa <> 'funcionario') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", pessoa");
			ELSE
				SET error_message = CONCAT(error_message, "pessoa");
			END IF;
		END IF;
        
        SELECT COUNT(*) INTO numero_animais FROM animais_dia WHERE data_hora = NEW.data_hora;
		IF(numero_animais <= (SELECT quantidade_animais FROM configuracao)) THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", data_hora");
			ELSE
				SET error_message = CONCAT(error_message, "data_hora");
			END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
  `transacao_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_servico_contratado_pessoa_tem_funcao1_idx` (`pessoa_tem_funcao_id_funcionario`),
  KEY `fk_servico_contratado_transacao1_idx` (`transacao_id`),
  CONSTRAINT `fk_servico_contratado_pessoa_tem_funcao1` FOREIGN KEY (`pessoa_tem_funcao_id_funcionario`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_contratado_transacao1` FOREIGN KEY (`transacao_id`) REFERENCES `transacao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_contratado`
--

LOCK TABLES `servico_contratado` WRITE;
/*!40000 ALTER TABLE `servico_contratado` DISABLE KEYS */;
/*!40000 ALTER TABLE `servico_contratado` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_contratado_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`servico_contratado`
FOR EACH ROW
BEGIN
		DECLARE tipo_pessoa VARCHAR(50);
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:servico_contratado] - ";

		IF (NEW.preco <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", preco");
            ELSE
				SET error_message = CONCAT(error_message, "preco");
            END IF;
		END IF;
        
        IF (NEW.data_hora <> NOW()) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", data_hora");
            ELSE
				SET error_message = CONCAT(error_message, "data_hora");
            END IF;
		END IF;
		
        SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id_funcionario;
		IF(tipo_pessoa <> 'funcionario') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", pessoa");
			ELSE
				SET error_message = CONCAT(error_message, "pessoa");
			END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`servico_contratado_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`servico_contratado`
FOR EACH ROW
BEGIN
DECLARE tipo_pessoa VARCHAR(50);
        DECLARE invalid INT;
        DECLARE error_message VARCHAR(100);
        
        SET invalid = 0;
		SET error_message = "[tabela:servico_contratado] - ";

		IF (NEW.preco <= 0) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", preco");
            ELSE
				SET error_message = CONCAT(error_message, "preco");
            END IF;
		END IF;
        
        IF (NEW.data_hora <> NOW()) THEN
			SET invalid = invalid + 1;
            IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", data_hora");
            ELSE
				SET error_message = CONCAT(error_message, "data_hora");
            END IF;
		END IF;
		
        SELECT nome INTO tipo_pessoa FROM tipo_funcao WHERE id = NEW.pessoa_tem_funcao_id_funcionario;
		IF(tipo_pessoa <> 'funcionario') THEN
			SET invalid = invalid + 1;
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, ", pessoa");
			ELSE
				SET error_message = CONCAT(error_message, "pessoa");
			END IF;
		END IF;
        
        IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
-- Table structure for table `servico_tem_porte`
--

DROP TABLE IF EXISTS `servico_tem_porte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico_tem_porte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `servico_id` int(11) NOT NULL,
  `porte_id` int(11) NOT NULL,
  `preco` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_servico_tem_porte_servico_id_idx` (`servico_id`),
  KEY `fk_servico_tem_porte_porte_id_idx` (`porte_id`),
  CONSTRAINT `fk_servico_tem_porte_porte` FOREIGN KEY (`porte_id`) REFERENCES `porte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_tem_porte_servico` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_tem_porte`
--

LOCK TABLES `servico_tem_porte` WRITE;
/*!40000 ALTER TABLE `servico_tem_porte` DISABLE KEYS */;
INSERT INTO `servico_tem_porte` VALUES (8,1,15,'21,00'),(9,3,15,'75,00'),(10,6,15,'7,00'),(11,7,15,'10,00'),(12,8,15,'7,00'),(13,9,15,'15,00');
/*!40000 ALTER TABLE `servico_tem_porte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `numero` int(9) NOT NULL COMMENT 'Número do telefone. Somente dígitos. Tamanho máximo ''9'' permite números de outros estados',
  `codigo_area` int(3) NOT NULL COMMENT 'Código de área da região',
  `codigo_pais` varchar(3) NOT NULL COMMENT 'Código do país',
  `pessoa_id` int(11) NOT NULL COMMENT 'Telefone pertence à uma pessoa',
  PRIMARY KEY (`id`),
  KEY `fk_telefone_pessoa1_idx` (`pessoa_id`),
  CONSTRAINT `fk_telefone_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefone`
--

LOCK TABLES `telefone` WRITE;
/*!40000 ALTER TABLE `telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `telefone` ENABLE KEYS */;
UNLOCK TABLES;

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
  `tipo` char(1) NOT NULL COMMENT 'Se é receita ou despesa (''R'' ou ''D'')',
  `data_hora` datetime NOT NULL COMMENT 'Controla o momento em que a transação foi cadastrada\n',
  `valor` decimal(10,2) NOT NULL COMMENT 'Valor em reais',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacao`
--

LOCK TABLES `transacao` WRITE;
/*!40000 ALTER TABLE `transacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `transacao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`transacao_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`transacao`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:vacina] - ";
    
    IF(NEW.tipo <> 'C' OR NEW.tipo <> 'D') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", tipo");
		ELSE
			SET error_message = CONCAT(error_message, "tipo");
		END IF;
    END IF;
    
    IF(NEW.valor <= 0) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", valor");
		ELSE
			SET error_message = CONCAT(error_message, "valor");
		END IF;
    END IF;
    
    IF(NEW.data_hora <= NOW()) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", data_hora");
		ELSE
			SET error_message = CONCAT(error_message, "data_hora");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`transacao_BEFORE_UPDATE`
BEFORE UPDATE ON `pet_shop`.`transacao`
FOR EACH ROW
BEGIN
DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:vacina] - ";
    
    IF(NEW.tipo <> 'C' OR NEW.tipo <> 'D') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", tipo");
		ELSE
			SET error_message = CONCAT(error_message, "tipo");
		END IF;
    END IF;
    
    IF(NEW.valor <= 0) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", valor");
		ELSE
			SET error_message = CONCAT(error_message, "valor");
		END IF;
    END IF;
    
    IF(NEW.data_hora <= NOW()) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", data_hora");
		ELSE
			SET error_message = CONCAT(error_message, "data_hora");
		END IF;
    END IF;
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
  `lote_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vacina_lote1_idx` (`lote_id`),
  CONSTRAINT `fk_vacina_lote1` FOREIGN KEY (`lote_id`) REFERENCES `lote` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacina`
--

LOCK TABLES `vacina` WRITE;
/*!40000 ALTER TABLE `vacina` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacina` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pet_shop`.`vacina_BEFORE_INSERT`
BEFORE INSERT ON `pet_shop`.`vacina`
FOR EACH ROW
BEGIN
	DECLARE invalid INT;
	DECLARE error_message VARCHAR(100);
        
	SET invalid = 0;
	SET error_message = "[tabela:vacina] - ";
    
    IF (invalid > 0) THEN
			IF (invalid > 1) THEN
				SET error_message = CONCAT(error_message, " inválidos!");
			ELSE
				SET error_message = CONCAT(error_message, " inválido!");
			END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nome_valido`(nome VARCHAR(100)) RETURNS tinyint(1)
BEGIN

	IF NOT (SELECT nome REGEXP '^[A-Za-zÇçãÃâÂõáÁÕôÔóÓêÊéÉ\ -]+$') THEN
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnimal`(in id INT)
BEGIN
	DECLARE pessoa_tem_funcao_id INT;
	IF id IS NOT NULL THEN
		SELECT pessoa_tem_funcao.id INTO pessoa_tem_funcao_id FROM pessoa_tem_funcao WHERE pessoa_id = id;
		SELECT * FROM animal WHERE animal.pessoa_tem_funcao_id = pessoa_tem_funcao_id;
	ELSE
		SELECT * FROM animal;
    END IF;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoa`(IN pessoa_id VARCHAR(255))
BEGIN
	IF pessoa_id IS NULL THEN
		SELECT * FROM pessoa;
    ELSE 
		SELECT * FROM pessoa WHERE id = pessoa_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `log`(message VARCHAR(100))
BEGIN
	INSERT INTO log SELECT message;
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
/*!50001 VIEW `tipo_servico` AS select `servico`.`nome` AS `nome`,`servico_agendado`.`id` AS `id` from (`servico_agendado` join `servico`) where (`servico_agendado`.`servico_id` = `servico`.`id`) */;
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

-- Dump completed on 2016-09-03 15:49:42
