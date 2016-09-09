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
	IN p_id INT
  , IN p_nome VARCHAR(100)
  , IN p_estado_id INT
  , IN p_pais_id INT
)
BEGIN
	SELECT c.id, c.nome as cidade, e.nome estado, e.uf, p.nome as pais
	  FROM cidade c
	 INNER JOIN estado e
		ON e.id = c.estado_id
	 INNER JOIN pais p
		ON p.id = e.pais_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (c.id = p_id))
       AND ((p_nome is null) OR (c.nome like concat('%', p_nome, '%')))
       AND ((p_estado_id is null) OR (c.estado_id = p_estado_id))
       AND ((p_pais_id is null) OR (e.pais_id = p_pais_id));
END