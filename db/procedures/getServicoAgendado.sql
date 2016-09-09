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

	SELECT 	sa.id, s.nome, sa.data_hora, sp.preco, a.nome, sa.servico_contratado_id,
			sa.recorrente, sa.executado, sa.pago, sa.observacao, sa.data_hora_executado
		FROM servico_agendado sa
		INNER JOIN servico_tem_porte sp, servico s, animal a
		WHERE sa.servico_tem_porte_id = sp.id
		AND sp.servico_id = s.id 
		AND sa.animal_id = a.id
        AND ((id IS NULL) or(sa.id = id))
        AND ((servico_contratado_id IS NULL) or(sa.servico_contratado_id = servico_contratado_id))
        AND ((data_inicio IS NULL AND data_fim IS NULL) or(sa.data_hora BETWEEN data_inicio AND data_fim));

END