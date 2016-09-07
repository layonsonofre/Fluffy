-- MySQL dump 10.15  Distrib 10.0.25-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: pet_shop
-- ------------------------------------------------------
-- Server version	10.0.25-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

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
/*!50003 DROP FUNCTION IF EXISTS `senha_valida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altAnamnese`(
	IN p_id int
  , IN p_peso int
  , IN p_tamanho int
  , IN p_temperatura int
  , IN p_servico_agendado_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_peso IS NULL OR p_tamanho IS NULL OR p_temperatura IS NULL OR p_servico_agendado_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE `pet_shop`.`anamnese`
	   SET `peso` = p_peso
         , `tamanho` = p_tamanho
         , `temperatura` = p_temperatura
         , `servico_agendado_id` = p_servico_agendado_id
	 WHERE `id` = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altAnimal`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_sexo char(1)
  , IN p_data_nascimento datetime
  , IN p_pessoa_tem_funcao_id int
  , IN p_raca_id int
  , IN p_porte_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_nome IS NULL OR p_sexo IS NULL OR p_data_nascimento IS NULL OR p_pessoa_tem_funcao_id IS NULL OR p_raca_id IS NULL OR p_porte_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;

	UPDATE `pet_shop`.`animal`
       SET `nome` = p_nome
         , `sexo` = p_sexo
         , `data_nascimento` = p_data_nascimento
         , `pessoa_tem_funcao_id` = p_pessoa_tem_funcao_id
         , `raca_id` = p_raca_id
         , `porte_id` = p_porte_id
	 WHERE `id` = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altAnimalTemRestricao`(
	IN p_id int
  , IN p_restricao_id int
  , IN p_animal_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_restricao_id IS NULL OR p_animal_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE `pet_shop`.`animal_tem_restricao`
       SET `restricao_id` = p_restricao_id
         , `animal_id` = p_animal_id
	 WHERE `id` = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altAplicacao`(
	IN p_id int
  , IN p_data_hora datetime
  , IN p_aplicado tinyint
  , IN p_dose int
  , IN p_vacina_id int
  , IN p_servico_agendado_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_data_hora IS NULL OR p_aplicado IS NULL OR p_dose IS NULL OR p_vacina_id IS NULL OR p_servico_agendado_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.aplicacao
       SET data_hora = p_restricao_id
         , aplicado = p_aplicado
         , dose = p_dose
         , vacina_id = p_vacina_id
         , servico_agendado_id = servico_agendado_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altCidade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altCidade`(
	IN p_id int
  , IN p_nome varchar(100)
  , IN p_estado_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_nome IS NULL OR p_estado_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.cidade
       SET nome = p_nome
         , estado_id = p_estado_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altConfiguracao`(
	IN p_id int
  , IN p_quantidade_animais int
  , IN p_periodos_dia int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_quantidade_animais IS NULL OR p_periodos_dia IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.configuracao
       SET quantidade_animais = p_quantidade_animais
         , periodos_dia = p_periodos_dia
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altEspecie`(
	IN p_id int
  , IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.especie
       SET nome = p_nome
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altEstado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altEstado`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_uf varchar(2)
  , IN p_pais_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_nome IS NULL OR p_uf IS NULL OR p_pais_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.estado
       SET nome = p_nome
         , uf = p_uf
         , pais_id = p_pais_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altFuncao`(
	IN p_id int
  , IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.funcao
       SET nome = p_nome
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altGrupoDeItem`(
	IN p_id int
  , IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.grupo_de_item
       SET nome = p_nome
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altItem`(
	IN p_id int
  , IN p_nome varchar(100)
  , IN p_preco decimal(10, 2)
  , IN p_quantidade int
  , IN p_grupo_de_item_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_nome IS NULL OR p_preco IS NULL OR p_quantidade IS NULL OR p_grupo_de_item_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.item
       SET nome = p_nome
         , preco = p_preco
         , quantidade = p_quantidade
         , grupo_de_item_id = p_grupo_de_item_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altItemDeVenda`(
	IN p_id int
  , IN p_preco decimal(10, 2)
  , IN p_quantidade int
  , IN p_item_id int
  , IN p_pedido_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_preco IS NULL OR p_quantidade IS NULL OR p_item_id IS NULL OR p_pedido_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.item_de_venda
       SET preco = p_preco
         , quantidade = p_quantidade
         , item_id = p_item_id
         , pedido_id = p_pedido_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altLembrete`(
	IN p_id int
  , IN p_descricao varchar(200)
  , IN p_data_hora_apontamento datetime
  , IN p_executado tinyint(1)
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_descricao IS NULL OR p_data_hora_apontamento IS NULL OR p_executado IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.lembrete
       SET descricao = p_descricao
         , data_hora_apontamento = p_data_hora_apontamento
         , executado = p_executado
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altLote`(
	IN p_id int
  , IN p_numero varchar(50)
  , IN p_vencimento date
  , IN p_preco decimal(10, 2)
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_numero IS NULL OR p_vencimento IS NULL OR p_preco IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.lote
       SET numero = p_numero
         , vencimento = p_vencimento
         , preco = p_preco
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPais`(
	IN p_id int
  , IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.pais
       SET nome = p_nome
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altParcela` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altParcela`(
	IN p_id int
  , IN p_valor decimal(10, 2)
  , IN p_data_vencimento date
  , IN p_transacao_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_valor IS NULL OR p_data_vencimento IS NULL OR p_transacao_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.parcela
       SET valor = p_valor
         , data_vencimento = p_data_vencimento
         , transacao_id = p_transacao_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPedido`(
	IN p_id int
  , IN p_valor decimal(10, 2)
  , IN p_desconto decimal(10, 2)
  , IN p_transacao_id int
  , IN p_cliente_id int
  , IN p_funcionario_id int
  , OUT ret varchar(200)
)
label: BEGIN
	IF p_id IS NULL OR p_valor IS NULL OR p_desconto IS NULL OR p_transacao_id IS NULL OR p_cliente_id IS NULL OR p_funcionario_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.parcela
       SET valor = p_valor
         , desconto = p_desconto
         , transacao_id = p_transacao_id
         , cliente_id = p_cliente_id
         , funcionario_id = p_funcionario_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPermissao`(
	IN p_id int
  , IN p_modulo varchar(50)
  , OUT ret varchar(200)
)
BEGIN
    IF p_modulo IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
	ELSE
		UPDATE pet_shop.permissoes
		   SET modulo = p_modulo
		 WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
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
  , IN p_cidade_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_email, c_registro, c_pessoa int default 0;
    IF p_nome IS NULL OR p_logradouro IS NULL OR p_numero IS NULL OR p_cep IS NULL OR p_cidade_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_email
      FROM pet_shop.pessoa p
	 WHERE p.email = p_email;
	IF c_email > 0 THEN
		SET ret = "{'success': false, 'msg':'Email já está sendo utilizado por outra pessoa'}";
		LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_registro
      FROM pet_shop.pessoa p
	 WHERE p.registro = p_registro;
	IF c_registro > 0 THEN
		SET ret = "{'success': false, 'msg':'Registro já está sendo utilizado por outra pessoa'}";
		LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_pessoa
      FROM pet_shop.pessoa p
	 WHERE p.id = id;
	IF c_pessoa < 1 THEN
		SET ret = "{'success': false, 'msg':'Cadastro não encontrado'}";
		LEAVE label;
	END IF;
    
	UPDATE pet_shop.pessoa
	   SET nome = p_nome
         , email = p_email
         , registro = p_registro
         , logradouro = p_logradouro
         , numero = p_numero
         , complemento = p_complemento
         , cep = p_cep
         , ponto_de_referencia = p_ponto_de_referencia
         , cidade_id = p_cidade_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPessoaTemFuncao`(
	IN p_id int
  , IN p_pessoa_id int
  , IN p_funcao_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_pessoa int default 0;
    IF p_id IS NULL or p_pessoa_id IS NULL OR p_funcao_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_pessoa
      FROM pet_shop.pessoa_tem_funcao ptf
	 WHERE ptf.pessoa_id = p_pessoa_id
       AND ptf.funcao_id = p_funcao_id;
	IF c_pessoa = 0 THEN
		SET ret = "{'success': false, 'msg':'Função não encontrada para a pessoa'}";
		LEAVE label;
	END IF;
    
	UPDATE pet_shop.pessoa_tem_funcao
	   SET pessoa_id = p_pessoa_id
         , funcao_id = p_funcao_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `altPessoaTemPermissoes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPessoaTemPermissoes`(
	IN p_id int
  , IN p_pessoa_tem_funcao_id int
  , IN p_permissoes_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_pessoa int default 0;
    IF p_id IS NULL or p_pessoa_tem_funcao_id IS NULL OR p_permissoes_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_pessoa
      FROM pet_shop.pessoa_tem_permissoes ptp
	 WHERE ptp.pessoa_tem_funcao_id = p_pessoa_tem_funcao_id
	   AND ptp.permissoes_id = p_permissoes_id;
	IF c_pessoa = 0 THEN
		SET ret = "{'success': false, 'msg':'Permissão não cadastrada'}";
		LEAVE label;
	END IF;
    
	UPDATE pet_shop.pessoa_tem_permissoes
	   SET pessoa_tem_funcao_id = p_pessoa_tem_funcao_id
         , permissoes_id = p_permissoes_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPessoaTemRedeSocial`(
	IN p_id int
  , IN p_perfil varchar(200)
  , IN p_rede_social_id int
  , IN p_pessoa_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_pessoa int default 0;
    IF p_id IS NULL OR p_perfil IS NULL OR p_rede_social_id IS NULL OR p_pessoa_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_pessoa
      FROM pet_shop.pessoa_tem_rede_social ptrs
	 WHERE ptrs.rede_social_id = p_rede_social_id
	   AND ptrs.pessoa_id = p_pessoa_id;
	IF c_pessoa = 0 THEN
		SET ret = "{'success': false, 'msg':'Cadastro não encontrado'}";
		LEAVE label;
	END IF;
    
	UPDATE pet_shop.pessoa_tem_rede_social
	   SET perfil = p_perfil
         , rede_social_id = p_rede_social_id
         , pessoa_id = p_pessoa_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altPorte`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_tamanho_minimo int
  , IN p_tamanho_maximo int
  , IN p_peso_minimo int
  , IN p_peso_maximo int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_id IS NULL OR p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.porte
	   SET nome = p_nome
         , tamanho_minimo = p_tamanho_minimo
         , tamanho_maximo = p_tamanho_maximo
         , peso_minimo = p_peso_minimo
         , peso_maximo = p_peso_maximo
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altRaca`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_especie_id int
  , IN p_porte_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_id IS NULL OR p_nome IS NULL OR p_especie_id IS NULL OR p_porte_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.raca
	   SET nome = p_nome
         , especie_id = p_especie_id
         , porte_id = p_porte_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altRedeSocial`(
	IN p_id int
  , IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_id IS NULL OR p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.rede_social
	   SET nome = p_nome
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altRestricao`(
	IN p_id int
  , IN p_restricao varchar(50)
  , IN p_descricao varchar(200)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_id IS NULL OR p_restricao IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.restricao
	   SET restricao = p_restricao
         , descricao = p_descricao
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altServico`(
	IN p_id int
  , IN p_servico varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_id IS NULL OR p_servico IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.servico
	   SET servico = p_servico
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
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
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_preco IS NULL OR p_recorrente IS NULL OR p_data_hora IS NULL
    OR p_servico_id IS NULL OR p_animal_id IS NULL OR p_servico_contratado_id IS NULL
    OR p_executado IS NULL OR p_pago IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.servico_agendado
	   SET preco = p_preco
         , recorrente = p_recorrente
         , data_hora = p_data_hora
         , servico_id = p_servico_id
         , animal_id = p_animal_id
         , servico_contratado_id = p_servico_contratado_id
         , executado = p_executado
         , pago = p_pago
         , observacao = p_observacao
         , data_hora_executado = p_data_hora_executado
         , funcionario_executa_id = p_funcionario_executa_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altServicoContratado`(
	IN p_id int
  , IN p_pessoa_tem_funcao_id_funcionario int
  , IN p_preco decimal(10, 2)
  , IN p_transacao_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_preco IS NULL OR p_transacao IS NULL OR p_pessoa_tem_funcao_id_funcionario IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.servico_contratado
	   SET pessoa_tem_funcao_id_funcionario = p_pessoa_tem_funcao_id_funcionario
         , preco = p_preco
         , transacao_id = p_transacao_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altServicoTemPorte`(
	IN p_id int
  , IN p_servico_id int
  , IN p_porte_id int
  , IN p_preco decimal(10, 2)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_servico_id IS NULL OR p_porte_id IS NULL OR p_preco IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.servico_tem_porte
	   SET servico_id = p_servico_id
         , porte_id = p_porte_id
         , preco = p_preco
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altTelefone`(
	IN p_id int
  , IN p_numero int
  , IN p_codigo_area int
  , IN p_codigo_pais varchar(3)
  , IN p_pessoa_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_id IS NULL OR p_numero IS NULL OR p_codigo_area IS NULL OR p_codigo_pais IS NULL OR p_pessoa_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.telefone
	   SET numero = p_numero
         , codigo_area = p_codigo_area
         , codigo_pais = p_codigo_pais
         , pessoa_id = p_pessoa_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altTransacao`(
	IN p_id int
  , IN p_tipo char(1)
  , IN p_valor decimal(10, 2)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_id IS NULL OR p_tipo IS NULL OR p_valor IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.transacao
	   SET tipo = p_tipo
         , valor = p_valor
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `altVacina`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_dose int
  , IN p_intervalo int
  , IN p_lote_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_id IS NULL OR p_nome IS NULL OR p_dose IS NULL OR p_intervalo IS NULL OR p_lote_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Necessário informar todos os campos obrigatórios'}";
        LEAVE label;
	END IF;
    
	UPDATE pet_shop.vacina
	   SET nome = p_nome
         , dose = p_dose
         , intervalo = p_intervalo
         , lote_id = p_lote_id
	 WHERE id = p_id;
	SET ret = "{'success': true, 'msg': 'Registro atualizado com sucesso', 'id':" + p_id + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delAnamnese`(
	IN p_id int
)
BEGIN
	DELETE FROM `pet_shop`.`anamnese`
	 WHERE `id` = p_id;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delAnimal`(
	IN p_id int
)
BEGIN
	DELETE FROM `pet_shop`.`animal`
	WHERE `id` = p_id;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delAnimalTemRestricao`(
	IN p_id int
)
BEGIN
	DELETE FROM `pet_shop`.`animal_tem_restricao`
	WHERE `id` = p_id;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delAplicacao`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.aplicacao
	WHERE id = p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delCidade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delCidade`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.cidade
	WHERE id = p_id;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delConfiguracao`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.configuracao
	WHERE id = p_id;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delEspecie`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.especie
	WHERE id = p_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delEstado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delEstado`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.estado
	WHERE id = p_id;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delFuncao`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.funcao
	WHERE id = p_id;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delGrupoDeItem`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.grupo_de_item
	WHERE id = p_id;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delItem`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.item
	WHERE id = p_id;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delItemDeVenda`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.item_de_venda
	WHERE id = p_id;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delLembrete`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.lembrete
	WHERE id = p_id;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delLote`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.lote
	WHERE id = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPais`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.pais
	WHERE id = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delParcela` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delParcela`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.parcela
	WHERE id = p_id;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPedido`(
	IN p_id int
)
BEGIN
	DELETE FROM pet_shop.pedido
	WHERE id = p_id;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPermissao`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.permissoes
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPessoa`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.pessoa
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPessoaTemFuncao`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.pessoa_tem_funcao
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPessoaTemPermissao`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.pessoa_tem_permissoes
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPessoaTemRedeSocial`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.pessoa_tem_rede_social
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPorte`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.porte
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delRaca`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.raca
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delRedeSocial`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.rede_social
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delRestricao`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.restricao
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delServico`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.servico
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delServicoAgendado`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.servico_agendado
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delServicoContratado`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.servico_contratado
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delServicoTemPorte`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.servico_tem_porte
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delTelefone`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.telefone
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delTransacao`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.transacao
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delVacina`(
	IN p_id int
  , OUT ret varchar(200)
)
BEGIN
    IF p_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'É necessário informar um ID'}";
	ELSE
		DELETE FROM pet_shop.vacina
		WHERE id = p_id;
		SET ret = "{'success': true, 'msg': 'Registro removido com sucesso'}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnamnese`(
	IN p_id int
  , IN p_servico_agendado_id int
)
BEGIN
	SELECT *
	  FROM anamnese
	 WHERE 1 = 1
	   AND ((p_id is null) or (id = p_id))
	   AND ((p_servico_agendado_id is null) or (servico_agendado_id = p_servico_agendado_id));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnimal`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_pessoa_tem_funcao_id int
  , IN p_raca_id int
  , IN p_porte_id int
)
BEGIN
	SELECT *
      FROM animal
	 WHERE 1 = 1
	   AND ((p_id is null) or (id = p_id))
       AND ((p_nome is null) or (nome like concat('%', p_nome, '%')))
       AND ((p_pessoa_tem_funcao_id is null) or (pessoa_tem_funcao_id = p_pessoa_tem_funcao_id))
       AND ((p_raca_id is null) or (raca_id = p_raca_id))
       AND ((p_porte_id is null) or (porte_id = p_porte_id))
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAplicacao`(
	IN p_id int
  , IN p_data_hora datetime
  , IN p_aplicado tinyint(1)
  , IN p_vacina_id int
  , IN p_servico_agendado_id int
)
BEGIN
	SELECT *
	  FROM aplicacao
	 WHERE 1 = 1
       AND ((p_data_hora is null) or ((split_str(data_hora, ' ', 1) = split_str(p_data_hora, ' ', 1))))
       AND ((p_aplicado is null) or (aplicado = p_aplicado))
       AND ((p_vacina_id is null) or (vacina_id = p_vacina_id))
       AND ((p_servico_agendado_id is null) or (servico_agendado_id = p_servico_agendado_id));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCidade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCidade`(
	IN p_id int
  , IN p_nome varchar(100)
  , IN p_estado_id int
)
BEGIN
	SELECT c.*
		 , e.*
		 , p.*
	  FROM cidade
	 INNER JOIN estado e
		ON estado.id = c.estado_id
	 INNER JOIN pais p
		ON pais.id = e.pais_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (c.id = p_id))
       AND ((p_nome is null) OR (c.nome like concat('%', p_nome, '%')))
       AND ((p_estado_id is null) OR (c.estado_id = p_estado_id));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getConfiguracao`(
	IN p_id int
)
BEGIN
	SELECT *
	  FROM configuracao
	 WHERE 1 = 1
       AND ((p_id is null) or (c.id = id));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEspecie`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT e.*
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
/*!50003 DROP PROCEDURE IF EXISTS `getEstado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEstado`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_uf char(2)
  , IN p_pais_id int
)
BEGIN
	SELECT *
	  FROM estado e
	 WHERE 1 = 1
	   AND ((p_id is null) or (e.id = p_id))
       AND ((p_nome is null) or (e.nome like concat('%', p_nome, '%')))
       AND ((p_uf is null) or (e.uf like p_nome))
       AND ((p_pais_id is null) or (e.pais_id = p_pais_id));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFuncao`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT *
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getGrupoDeItem`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT *
	  FROM grupo_de_item gi
	 WHERE 1 = 1
       AND ((p_id is null) or (gi.id = p_id))
       AND ((p_nome is null) or (gi.nome = p_nome));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getItem`(
	IN grupo_id int
  , IN item_id int
)
BEGIN
	IF grupo_id IS NOT NULL THEN
		SELECT i.*
             , gi.*
		  FROM item i
		  LEFT JOIN grupo_de_item gi
            ON gi.id = i.grupo_de_item_id
		 WHERE gi.id = grupo_de_item_id;
    ELSEIF item_id IS NOT NULL THEN
		SELECT i.*
             , gi.*
		  FROM item i
		  LEFT JOIN grupo_de_item gi
            ON gi.id = i.grupo_de_item_id
		 WHERE i.id = item_id;
	ELSE
		SELECT i.*
             , gi.*
		  FROM item i
		  LEFT JOIN grupo_de_item gi
            ON gi.id = i.grupo_de_item_id;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemDeVenda`(
	IN id int
)
BEGIN
	IF id IS NOT NULL THEN
		SELECT *
		  FROM item_de_venda
		 WHERE item_de_venda.id = id;
	ELSE
		SELECT *
		  FROM item_de_venda;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLembrete`(
	IN p_id int
  , IN p_descricao varchar(200)
)
BEGIN
	SELECT *
	  FROM lembrete
	 WHERE 1 = 1
       AND ((p_id is null) or (lembrete.id = p_id))
       AND ((p_descricao is null) or (lembrete.descricao like concat('%', p_descricao, '%')));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLote`(
	IN p_id int
  , IN p_numero varchar(50)
  , IN p_data_inicio date
  , IN p_data_fim date
  , IN p_preco_min decimal(10, 2)
  , IN p_preco_max decimal(10, 2)
)
BEGIN
	SELECT *
	  FROM lote
	 WHERE 1 = 1
       AND ((p_id is null) or (lote.id = p_id))
       AND ((p_numero is null) or (lote.numero like concat('%', p_numero, '%')))
       AND (((p_data_inicio is null) OR (lote.vencimento >= p_data_inicio)) OR
            ((p_data_fim is null) OR (lote.vencimento <= p_data_fim)))
       AND (((p_preco_min is null) OR (lote.preco >= p_preco_min)) OR
            ((p_preco_max is null) OR (lote.preco <= p_preco_max)));
       
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPais`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT *
	  FROM pais p
	 WHERE 1 = 1
       AND ((p_id is null) or (p.id = p_id))
	   AND ((p_nome is null) or (p.nome like concat('%', p_nome, '%')));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getParcela` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getParcela`(
	IN p_id int
  , IN p_transacao_id int
  , IN p_data_inicio date
  , IN p_data_fim date
  , IN p_valor_min decimal(10, 2)
  , IN p_valor_max decimal(10, 2)
)
BEGIN
	SELECT *
	  FROM parcela p
	 WHERE 1 = 1
       AND ((p_id is null) or (p.id = p_id))
       AND ((p_transacao_id is null) or (p.transacao_id = p_transacao_id))
       AND (((p_data_inicio is null) OR (p.data_vencimento >= p_data_inicio)) OR
            ((p_data_fim is null) OR (p.data_vencimento <= p_data_fim)))
       AND (((p_valor_min is null) OR (p.valor >= p_valor_min)) OR
            ((p_valor_max is null) OR (p.valor <= p_valor_max)));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPedido`(
	IN p_id int
  , IN p_valor_min decimal(10, 2)
  , IN p_valor_max decimal(10, 2)
  , IN p_desconto_min decimal(10, 2)
  , IN p_desconto_max decimal(10, 2)
  , IN p_transacao_id int
  , IN p_cliente_id int
  , IN p_funcionario_id int
)
BEGIN
	SELECT p.*
		 , iv.*
		 , i.*
	  FROM pedido p
	 INNER JOIN item_de_venda iv
		ON iv.pedido_id = p.id
	 INNER JOIN item i
		ON i.id = iv.item_id
	 WHERE 1 = 1
       AND ((p_id is null) or (p.id = p_id))
       AND (((p_valor_min is null) OR (p.valor >= p_valor_min)) OR
            ((p_valor_max is null) OR (p.valor <= p_valor_max)))
       AND (((p_desconto_min is null) OR (p.desconto >= p_desconto_min)) OR
            ((p_desconto_max is null) OR (p.desconto <= p_desconto_max)))
       AND ((p_transacao_id is null) or (p.transacao_id = p_transacao_id))
       AND ((p_cliente_id is null) or (p.cliente_id = p_cliente_id))
       AND ((p_funcionario_id is null) or (p.funcionario_id = p_funcionario_id));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPermissoes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPermissoes`(
	IN p_id int
  , IN p_modulo varchar(50)
)
BEGIN
	SELECT *
	  FROM permissoes p
	 INNER JOIN pessoa_tem_permissao ptp
		ON ptp.permissoes_id = p.id
	 INNER JOIN pessoa_tem_funcao ptf
		ON ptf.id = ptp.pessoa_tem_funcao_id
	 INNER JOIN pessoa pes
		ON pes.id = ptf.pessoa_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (p.id = p_id))
       AND ((p_modulo is null) OR (p.modulo like concat('%', p_modulo, '%')));
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
/*!50003 DROP PROCEDURE IF EXISTS `getPessoaTemFuncao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemFuncao`(
	IN p_id int
  , IN p_pessoa_id int
  , IN p_funcao_id int
)
BEGIN
	SELECT *
	  FROM pessoa_tem_funcao ptf
	 INNER JOIN funcao f
		ON f.id = ptf.funcao_id
	 LEFT JOIN pessoa p
		ON p.id = ptf.pessoa_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (ptf.id = p_id))
       AND ((p_pessoa_id is null) OR (ptf.pessoa_id = p_pessoa_id))
       AND ((p_funcao_id is null) OR (ptf.funcao_id = p_funcao_id));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPessoaTemPermissoes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemPermissoes`(
	IN p_id int
  , IN p_pessoa_tem_funcao_id int
  , IN p_permissoes_id int
)
BEGIN
	SELECT *
	  FROM pessoa_tem_permissoes ptp
	 INNER JOIN permissoes per
		ON per.id = ptp.permissoes_id
	 LEFT JOIN pessoa_tem_funcao ptf
		ON ptf.id = ptp.pessoa_tem_funcao_id
	 INNER JOIN pessoa pes
		ON pes.id = ptf.pessoa_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (ptp.id = p_id))
       AND ((p_pessoa_tem_funcao_id is null) OR (ptp.pessoa_tem_funcao_id = p_pessoa_tem_funcao_id))
       AND ((p_permissoes_id is null) OR (ptp.permissoes_id = p_permissoes_id));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemRedeSocial`(
	IN p_id int
  , IN p_perfil varchar(200)
  , IN p_rede_social_id int
  , IN p_pessoa_id int
)
BEGIN
	SELECT *
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPorte`(
	IN id int
)
BEGIN
	IF id IS NOT NULL THEN
		SELECT *
		  FROM porte
		 WHERE porte.id = id;
    ELSE
		SELECT *
		  FROM porte;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRaca`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_especie_id int
  , IN p_porte_id int
)
BEGIN
	SELECT *
	  FROM raca r
	 WHERE 1 = 1
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRedeSocial`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_pessoa_tem_funcao_id int
)
BEGIN
	SELECT *
	  FROM rede_social rs
	 WHERE 1 = 1
       AND ((p_id is null) OR (rs.id = p_id))
       AND ((p_nome is null) OR (rs.nome like concat('%', p_nome, '%')))
       AND ((p_pessoa_tem_funcao_id is null) OR (rs.pessoa_tem_funcao_id = p_pessoa_tem_funcao_id));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRestricao`(
	IN p_id int
  , IN p_restricao varchar(50)
  , IN p_descricao varchar(200)
)
BEGIN
	SELECT *
	  FROM restricao r
	 WHERE 1 = 1
       AND ((p_id is null) OR (r.id = p_id))
       AND ((p_restricao is null) OR (r.restricao like concat('%', p_restricao, '%')))
       AND ((p_descricao is null) OR (r.descricao like concat('%', p_descricao, '%')));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRestricoesAnimal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRestricoesAnimal`(
	IN animal_id int
  , IN restricao_id int
)
BEGIN
	/* todas as restrições deste animal */
	IF animal_id IS NOT NULL THEN
		SELECT atr.*
             , r.*
	      FROM animal_tem_restricao atr
         INNER JOIN restricao r
			ON r.id = atr.restricao_id
		 WHERE atr.animal_id = animal_id;
	/* todos os animais desta restrição */
	ELSEIF restricao_id IS NOT NULL THEN
		SELECT atr.*
             , a.*
          FROM animal_tem_restricao atr
		INNER JOIN animal a
           ON a.id = atr.animal_id
		WHERE atr.restricao_id = restricao_id;
	ELSE
		SELECT * FROM animal_tem_restricao;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServico`(
	IN id int
)
BEGIN
	IF id IS NOT NULL THEN
		SELECT *
		  FROM servico s
		 WHERE s.id = id;
    ELSE
		SELECT *
		  FROM servico s;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicoAgendado`(
	IN id int
)
BEGIN
	IF id IS NOT NULL THEN
		SELECT *
		  FROM servico_agendado s
		 WHERE s.id = id;
    ELSE
		SELECT *
		  FROM servico_agendado s;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicoContratado`(
	IN id int
)
BEGIN
	IF id IS NOT NULL THEN
		SELECT *
		  FROM servico_contratado s
		 WHERE s.id = id;
    ELSE
		SELECT *
		  FROM servico_contratado s;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicoTemPorte`(
	IN id int
)
BEGIN
	IF id IS NOT NULL THEN
		SELECT *
		  FROM servico_tem_porte s
		 WHERE s.id = id;
    ELSE
		SELECT *
		  FROM servico_tem_porte s;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTelefone`(
	IN p_id int
  , IN p_numero int
  , IN p_codigo_area int
  , IN p_codigo_pais varchar(3)
  , IN p_pessoa_id int
)
BEGIN
	SELECT *
	  FROM telefone t
	 WHERE 1 = 1
       AND ((p_id is null) OR (p.id = p_id))
       AND ((p_numero is null) OR (p.numero = p_numero))
       AND ((p_codigo_area is null) OR (p.codigo_area = p_codigo_area))
       AND ((p_codigo_pais is null) OR (p.codigo_pais like concat('%', p_codigo_pais, '%')))
       AND ((p_pessoa_id is null) OR (p.pessoa_id = p_pessoa_id));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTransacao`(
	IN p_id int
  , IN p_data_inicio datetime
  , IN p_data_fim datetime
  , IN p_tipo char(1)
)
BEGIN
	SELECT *
      FROM transacao t
	 WHERE 1 = 1
       AND ((p_id is null) OR (t.id = p_id))
       AND ((p_tipo is null) OR (t.tipo = p_tipo))
       AND ((p_data_inicio is null) OR (t.data_hora >= p_data_inicio))
       AND ((p_data_fim is null) OR (t.data_fim <= p_data_fim));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getVacina`(
	IN p_id int
  , IN p_lote_id int
  , IN p_nome varchar(50)
  , IN p_dose int
  , IN p_intervalo int
)
BEGIN
	SELECT *
	  FROM vacina v
	 WHERE 1 = 1
       AND ((p_id is null) OR (v.id = p_id))
       AND ((p_lote_id is null) OR (v.lote_id = p_lote_id))
       AND ((p_nome is null) OR (v.nome like concat('%', p_nome, '%')))
       AND ((p_dose is null) OR (v.dose = p_dose))
       AND ((p_intervalo is null) OR (v.intervalo = p_intervalo));
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insAnamnese`(
	IN p_peso int
  , IN p_tamanho int
  , IN p_temperatura int
  , IN p_servico_agendado_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_peso IS NULL OR p_tamanho IS NULL OR p_temperatura IS NULL OR p_servico_agendado_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
	
    INSERT INTO `pet_shop`.`anamnese`
		(`peso`, `tamanho`, `temperatura`, `servico_agendado_id`)
	VALUES
		(p_peso, p_tamanho, p_temperatura, p_servico_agendado_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insAnimal`(
	IN p_nome varchar(50)
  , IN p_sexo char(1)
  , IN p_data_nascimento datetime
  , IN p_pessoa_tem_funcao_id int
  , IN p_raca_id int
  , IN p_porte_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL OR p_sexo IS NULL OR p_data_nascimento IS NULL OR p_pessoa_tem_funcao_id IS NULL OR p_raca_id IS NULL OR p_porte_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
	INSERT INTO `pet_shop`.`animal`
		(`nome`, `sexo`, `data_hora_cadastro`, `data_nascimento`,
        `pessoa_tem_funcao_id`, `raca_id`, `porte_id`)
	VALUES
		(p_nome, p_sexo, sysdate(), p_data_nascimento,
        p_pessoa_tem_funcao_id, p_raca_id, p_porte_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insAnimalTemRestricao`(
	IN p_restricao_id int
  , IN p_animal_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_restricao_id IS NULL OR p_animal_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
	INSERT INTO `pet_shop`.`animal_tem_restricao`
		(`restricao_id`, `animal_id`)
	VALUES
		(p_restricao_id, p_animal_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insAplicacao`(
	IN p_data_hora datetime
  , IN p_aplicado tinyint
  , IN p_dose int
  , IN p_vacina_id int
  , IN p_servico_agendado_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_data_hora IS NULL OR p_aplicado IS NULL OR p_dose IS NULL OR p_vacina_id IS NULL OR p_servico_agendado_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
	INSERT INTO pet_shop.aplicacao
		(data_hora, aplicado, dose, vacina_id, servico_agendado_id)
	VALUES
		(p_data_hora, p_aplicado, p_dose, p_vacina_id, p_servico_agendado_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insCidade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insCidade`(
	IN p_nome varchar(100)
  , IN p_estado_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL OR p_estado_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.cidade
		(nome, estado_id)
	VALUES
		(p_nome, p_estado_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insConfiguracao`(
	IN p_quantidade_animais int
  , IN p_periodos_dia int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_quantidade_animais IS NULL OR p_periodos_dia IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
	INSERT INTO pet_shop.configuracao
		(quantidade_animais, periodos_dia)
	VALUES
		(p_quantidade_animais, p_periodos_dia);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insEspecie`(
	IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
	INSERT INTO pet_shop.especie
		(nome)
	VALUES
		(p_nome);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insEstado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insEstado`(
	IN p_nome varchar(50)
  , IN p_uf varchar(2)
  , IN p_pais_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL OR p_uf IS NULL OR p_pais_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.estado
		(nome, uf, pais_id)
	VALUES
		(p_nome, p_uf, p_pais_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insFuncao`(
	IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
	INSERT INTO pet_shop.funcao
		(nome)
	VALUES
		(p_nome);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insGrupoDeItem`(
	IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.grupo_de_item
		(nome)
	VALUES
		(p_nome);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insItem`(
	IN p_nome varchar(100)
  , IN p_preco decimal(10, 2)
  , IN p_quantidade int
  , IN p_grupo_de_item_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL OR p_preco IS NULL OR p_quantidade IS NULL OR p_grupo_de_item_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.item
		(nome, preco, quantidade, grupo_de_item_id, data_hora_cadastro)
	VALUES
		(p_nome, p_preco, p_quantidade, p_grupo_de_item_id, sysdate());
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insItemDeVenda`(
    IN p_preco decimal(10, 2)
  , IN p_quantidade int
  , IN p_item_id int
  , IN p_pedido_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_preco IS NULL OR p_quantidade IS NULL OR p_item_id IS NULL OR p_pedido_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.item_de_venda
		(preco, quantidade, item_id, pedido_id)
	VALUES
		(p_preco, p_quantidade, p_item_id, p_pedido_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insLembrete`(
	IN p_descricao varchar(200)
  , IN p_data_hora_apontamento datetime
  , IN p_executado tinyint(1)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_descricao IS NULL OR p_data_hora_apontamento IS NULL OR p_executado IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.lembrete
		(descricao, data_hora_apontamento, executado)
	VALUES
		(p_descricao, p_data_hora_apontamento, p_executado);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insLote`(
	IN p_numero varchar(50)
  , IN p_vencimento date
  , IN p_preco decimal(10, 2)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_numero IS NULL OR p_vencimento IS NULL OR p_preco IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
	INSERT INTO pet_shop.lote
		(numero, vencimento, preco)
	VALUES
		(p_numero, p_vencimento, p_preco);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPais`(
	IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.pais
		(nome)
	VALUES
		(p_nome);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insParcela` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insParcela`(
	IN p_valor decimal(10, 2)
  , IN p_data_vencimento date
  , IN p_transacao_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_valor IS NULL OR p_data_vencimento IS NULL OR p_transacao_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.parcela
		(valor, data_vencimento, transacao_id)
	VALUES
		(p_valor, p_data_vencimento, p_transacao_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPedido`(
	IN p_valor decimal(10, 2)
  , IN p_desconto decimal(10, 2)
  , IN p_transacao_id int
  , IN p_cliente_id int
  , IN p_funcionario_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_valor IS NULL OR p_desconto IS NULL OR p_transacao_id IS NULL OR p_cliente_id IS NULL OR p_funcionario_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.pedido
		(valor, desconto, transacao_id, cliente_id, funcionario_id)
	VALUES
		(p_valor, p_desconto, p_transacao_id, p_cliente_id, p_funcionario_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPermissao`(
	IN p_modulo varchar(50)
  , OUT ret varchar(200)
)
BEGIN
    IF p_modulo IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
	ELSE
		INSERT INTO pet_shop.permissoes
			(modulo)
		VALUES
			(p_modulo);
		SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
	END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
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
  , IN p_cidade_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_email, c_registro int default 0;
    IF p_nome IS NULL OR p_logradouro IS NULL OR p_numero IS NULL OR p_cep IS NULL OR p_cidade_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_email
      FROM pet_shop.pessoa p
	 WHERE p.email = p_email;
	IF c_email > 0 THEN
		SET ret = "{'success': false, 'msg':'Email já está sendo utilizado por outra pessoa'}";
		LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_registro
      FROM pet_shop.pessoa p
	 WHERE p.registro = p_registro;
	IF c_registro > 0 THEN
		SET ret = "{'success': false, 'msg':'Registro já está sendo utilizado por outra pessoa'}";
		LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.pessoa
		(nome, email, registro, logradouro, numero, complemento, cep, ponto_de_referencia, cidade_id)
	VALUES
		(p_nome, p_email, p_registro, p_logradouro, p_numero, p_complemento, p_cep, p_ponto_de_referencia, p_cidade_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPessoaTemFuncao`(
	IN p_pessoa_id int
  , IN p_funcao_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_pessoa int default 0;
    IF p_pessoa_id IS NULL OR p_funcao_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_pessoa
      FROM pet_shop.pessoa_tem_funcao ptf
	 WHERE ptf.pessoa_id = p_pessoa_id
	   AND ptf.funcao_id = p_funcao_id;
	IF c_pessoa > 0 THEN
		SET ret = "{'success': false, 'msg':'Função já cadastrada'}";
		LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.pessoa_tem_funcao
		(pessoa_id, funcao_id)
	VALUES
		(p_pessoa_id, p_funcao_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPessoaTemPermissoes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPessoaTemPermissoes`(
	IN p_pessoa_tem_funcao_id int
  , IN p_permissoes_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_pessoa int default 0;
    IF p_pessoa_tem_funcao_id IS NULL OR p_permissoes_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_pessoa
      FROM pet_shop.pessoa_tem_permissoes ptp
	 WHERE ptp.pessoa_tem_funcao_id = p_pessoa_tem_funcao_id
	   AND ptp.permissoes_id = p_permissoes_id;
	IF c_pessoa > 0 THEN
		SET ret = "{'success': false, 'msg':'Permissão já cadastrada'}";
		LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.pessoa_tem_permissoes
		(pessoa_tem_funcao_id, permissoes_id)
	VALUES
		(p_pessoa_tem_funcao_id, p_permissoes_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPessoaTemRedeSocial`(
	IN p_perfil varchar(200)
  , IN p_rede_social_id int
  , IN p_pessoa_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_pessoa int default 0;
    IF p_perfil IS NULL OR p_rede_social_id IS NULL OR p_pessoa_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
    SELECT count(*)
      INTO c_pessoa
      FROM pet_shop.pessoa_tem_rede_social ptrs
	 WHERE ptrs.p_rede_social_id = p_rede_social_id
	   AND ptrs.p_pessoa_id = p_pessoa_id;
	IF c_pessoa > 0 THEN
		SET ret = "{'success': false, 'msg':'Rede social já cadastrada'}";
		LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.pessoa_tem_rede_social
		(perfil, rede_social_id, pessoa_id)
	VALUES
		(p_perfil, p_rede_social_id, p_pessoa_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPorte`(
	IN p_nome varchar(50)
  , IN p_tamanho_minimo int
  , IN p_tamanho_maximo int
  , IN p_peso_minimo int
  , IN p_peso_maximo int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_porte int default 0;
    IF p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.porte
		(nome, tamanho_minimo, tamanho_maximo, peso_minimo, peso_maximo)
	VALUES
		(p_nome, p_tamanho_minimo, p_tamanho_maximo, p_peso_minimo, p_peso_maximo);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insRaca`(
	IN p_nome varchar(50)
  , IN p_especie_id int
  , IN p_porte_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL OR p_especie_id IS NULL OR p_porte_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.raca
		(nome, especie_id, porte_id)
	VALUES
		(p_nome, p_especie_id, p_porte_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insRedeSocial`(
	IN p_nome varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.rede_social
		(nome)
	VALUES
		(p_nome);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insRestricao`(
	IN p_restricao varchar(50)
  , IN p_descricao varchar(200)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_restricao IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.restricao
		(restricao, descricao)
	VALUES
		(p_restricao, p_descricao);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insServico`(
	IN p_servico varchar(50)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_servico IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.servico
		(servico)
	VALUES
		(p_servico);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
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
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_preco IS NULL OR p_recorrente IS NULL OR p_data_hora IS NULL
    OR p_servico_id IS NULL OR p_animal_id IS NULL OR p_servico_contratado_id IS NULL
    OR p_executado IS NULL OR p_pago IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.servico_agendado
		(preco, recorrente, data_hora, servico_id, animal_id, servico_contratado_id
        , executado, pago, observacao, data_hora_executado, funcionario_executa_id)
	VALUES
		(p_preco, p_recorrente, p_data_hora, p_servico_id, p_animal_id, p_servico_contratado_id
        , p_executado, p_pago, p_observacao, p_data_hora_executado, p_funcionario_executa_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insServicoTemPorte`(
	IN p_servico_id int
  , IN p_porte_id int
  , IN p_preco decimal(10, 2)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_servico_id IS NULL OR p_porte_id IS NULL OR p_preco IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.servico_tem_porte
		(servico_id, porte_id, preco)
	VALUES
		(p_servico_id, p_porte_id, p_preco);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insTelefone`(
	IN p_numero int
  , IN p_codigo_area int
  , IN p_codigo_pais varchar(3)
  , IN p_pessoa_id int
  , OUT ret varchar(200)
)
label: BEGIN
	DECLARE c_telefone int default 0;
    IF p_numero IS NULL OR p_codigo_area IS NULL OR p_codigo_pais IS NULL OR p_pessoa_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
    select count(*) into c_telefone from pet_shop.telefone where codigo_area = p_codigo_area and codigo_pais = p_codigo_pais and numero = p_numero;
    if c_telefone != 0 then
		SET ret = "{'success': false, 'msg':'Telefone já está sendo utilizado por outra pessoa'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.telefone
		(numero, codigo_area, codigo_pais, pessoa_id)
	VALUES
		(p_numero, p_codigo_area, p_codigo_pais, p_pessoa_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insTransacao`(
	IN p_tipo char(1)
  , IN p_valor decimal(10, 2)
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_tipo IS NULL OR p_valor IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.transacao
		(tipo, valor, data_hora)
	VALUES
		(p_tipo, p_valor, sysdate());
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insVacina`(
	IN p_nome varchar(50)
  , IN p_dose int
  , IN p_intervalo int
  , IN p_lote_id int
  , OUT ret varchar(200)
)
label: BEGIN
    IF p_nome IS NULL OR p_dose IS NULL OR p_intervalo IS NULL OR p_lote_id IS NULL THEN
		SET ret = "{'success': false, 'msg':'Impossível inserir campo nulo'}";
        LEAVE label;
	END IF;
    
	INSERT INTO pet_shop.vacina
		(nome, dose, intervalo, lote_id)
	VALUES
		(p_nome, p_dose, p_intervalo, p_lote_id);
	SET ret = "{'success': true, 'msg': 'Registro inserido com sucesso', 'id':" + last_insert_id() + "}";
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-07  0:46:00
