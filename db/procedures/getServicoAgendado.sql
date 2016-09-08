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
	IN id INT,
    IN servico_contratado_id INT,
    IN data_inicio DATETIME,
    IN data_fim DATETIME
)
BEGIN

	CREATE TABLE temp1(
		id INT,
		servico_nome VARCHAR(200),
		data_hora DATETIME,
        preco Decimal(10,2),
        animal_nome VARCHAR(50),
        servico_contratado_id INT,
        recorrente BOOLEAN,
        executado BOOLEAN,
        pago BOOLEAN,
        observacao VARCHAR(200),
        data_hora_executado DATETIME);
        
	CREATE TABLE temp2(
		id INT,
		servico_nome VARCHAR(200),
		data_hora DATETIME,
        preco Decimal(10,2),
        animal_nome VARCHAR(50),
        servico_contratado_id INT,
        recorrente BOOLEAN,
        executado BOOLEAN,
        pago BOOLEAN,
        observacao VARCHAR(200),
        data_hora_executado DATETIME);
        
	INSERT INTO temp1
	SELECT 	sa.id, s.nome, sa.data_hora, sp.preco, a.nome, sa.servico_contratado_id,
			sa.recorrente, sa.executado, sa.pago, sa.observacao, sa.data_hora_executado
			FROM servico_agendado sa
			INNER JOIN servico_tem_porte sp, servico s, animal a
			WHERE sa.servico_tem_porte_id = sp.id
            AND sp.servico_id = s.id 
            AND sa.animal_id = a.id;

	SET SQL_SAFE_UPDATES = 0;

	IF id IS NOT NULL THEN
		INSERT INTO temp2
		SELECT * FROM temp1
		WHERE temp1.id = id;
        
        DELETE FROM temp1;
        
        INSERT INTO temp1
        SELECT * FROM temp2;
        
        DELETE FROM temp2;
	END IF;
            
	IF servico_contratado_id IS NOT NULL THEN
		INSERT INTO temp2
		SELECT * FROM temp1
		WHERE temp1.servico_contratado_id = servico_contratado_id;
        
        DELETE FROM temp1;
        
        INSERT INTO temp1
        SELECT * FROM temp2;
        
        DELETE FROM temp2;
	END IF;
        
	IF data_inicio IS NOT NULL AND data_fim IS NOT NULL THEN
		INSERT INTO temp2
		SELECT * FROM temp1
		WHERE temp1.data_hora between data_inicio AND data_fim;
        
        DELETE FROM temp1;
        
        INSERT INTO temp1
        SELECT * FROM temp2;
        
        DELETE FROM temp2;
	END IF;

	SET SQL_SAFE_UPDATES = 1;
	
	SELECT * FROM temp1;

	DROP TABLE temp1;
    DROP TABLE temp2;
END