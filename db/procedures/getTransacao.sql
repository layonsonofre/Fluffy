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
  , IN p_tipo char(1)
  , IN p_data_inicio datetime
  , IN p_data_fim datetime
)
BEGIN
	SELECT t.id, t.tipo, t.data_hora, t.valor
		FROM transacao t
		WHERE 1 = 1
		AND ((p_id is null) OR (t.id = p_id))
		AND ((p_tipo is null) OR (t.tipo = p_tipo))
		AND ((p_data_inicio is null and p_data_fim is null) OR (t.data_hora between p_data_inicio and p_data_fim));
END