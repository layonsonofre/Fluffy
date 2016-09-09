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
	IN id INT,
	IN servico_id INT,
	IN porte_id INT
)
BEGIN
	SELECT sp.id, s.nome, p.nome, sp.preco FROM servico_tem_porte sp
    INNER JOIN porte p, servico s
    WHERE sp.porte_id = p.id
    AND sp.servico_id = s.id
    AND ((id IS NULL) or (sp.id = s.id))
    AND ((servico_id IS NULL) or (sp.servico_id = servico_id))
    AND ((porte_id IS NULL) or (sp.porte_id = porte_id));
END