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
  `data_hora` datetime NOT NULL,
  `executado` varchar(45) NOT NULL,
  `pessoa_id` int(9) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lembrete_pessoa1_idx` (`pessoa_id`),
  CONSTRAINT `fk_lembrete_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lote`
--

DROP TABLE IF EXISTS `lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(50) NOT NULL,
  `vencimento` date NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `permissao`
--

DROP TABLE IF EXISTS `permissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissao` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `modulo` varchar(50) NOT NULL COMMENT 'Descrição da permissão, somente o administrador pode alterar',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
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
BEFORE INSERT ON `pessoa_tem_permissao` FOR EACH ROW
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
BEFORE UPDATE ON `pessoa_tem_permissao` FOR EACH ROW
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `servico_tem_porte_id` int(11) NOT NULL COMMENT 'O serviço agendado',
  `animal_id` int(11) NOT NULL COMMENT 'Animal que vai receber o serviço',
  `servico_contratado_id` int(11) NOT NULL COMMENT 'O serviço agendado pertence à um contrato',
  `executado` tinyint(1) NOT NULL COMMENT 'Controla se já foi executado ou não',
  `pago` tinyint(1) NOT NULL COMMENT 'Controla se já foi realizado seu pagamento',
  `observacao` varchar(200) DEFAULT NULL COMMENT 'Informações adicionais',
  `data_hora_executado` datetime DEFAULT NULL COMMENT 'Momento em que foi executado',
  `funcionario_executa_id` int(11) DEFAULT NULL COMMENT 'Funcionário que executou o serviço',
  PRIMARY KEY (`id`),
  KEY `fk_servico_agendado_animal1_idx` (`animal_id`),
  KEY `fk_servico_agendado_servico_contratado1_idx` (`servico_contratado_id`),
  KEY `fk_servico_agendado_pessoa_tem_funcao1_idx` (`funcionario_executa_id`),
  KEY `fk_servico_agendado_servico_tem_porte1_idx` (`servico_tem_porte_id`),
  CONSTRAINT `fk_servico_agendado_animal1` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_pessoa_tem_funcao1` FOREIGN KEY (`funcionario_executa_id`) REFERENCES `pessoa_tem_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_servico_contratado1` FOREIGN KEY (`servico_contratado_id`) REFERENCES `servico_contratado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_agendado_servico_tem_porte1` FOREIGN KEY (`servico_tem_porte_id`) REFERENCES `servico_tem_porte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
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

        SET invalid = 0;
		SET error_message = "[tabela:servico_contratado] - ";

		IF (NEW.preco <> 0) THEN
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação com autoincremento',
  `numero` int(9) NOT NULL COMMENT 'Número do telefone. Somente dígitos. Tamanho máximo ''9'' permite números de outros estados',
  `codigo_area` varchar(3) NOT NULL COMMENT 'Código de área da região',
  `codigo_pais` varchar(3) NOT NULL COMMENT 'Código do país',
  `pessoa_id` int(11) NOT NULL COMMENT 'Telefone pertence à uma pessoa',
  PRIMARY KEY (`id`),
  KEY `fk_telefone_pessoa1_idx` (`pessoa_id`),
  CONSTRAINT `fk_telefone_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
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
	SET error_message = "[tabela:transacao] - ";

    IF(NEW.tipo <> 'C' AND NEW.tipo <> 'D') THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", tipo");
		ELSE
			SET error_message = CONCAT(error_message, "tipo");
		END IF;
    END IF;

    IF(NEW.valor <> 0) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", valor");
		ELSE
			SET error_message = CONCAT(error_message, "valor");
		END IF;
    END IF;

    IF(NEW.data_hora <> NOW()) THEN
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
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

    IF(NEW.valor <> 0) THEN
		SET invalid = invalid + 1;
		IF (invalid > 1) THEN
			SET error_message = CONCAT(error_message, ", valor");
		ELSE
			SET error_message = CONCAT(error_message, "valor");
		END IF;
    END IF;

    IF(NEW.data_hora <> NOW()) THEN
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-09 22:52:49
