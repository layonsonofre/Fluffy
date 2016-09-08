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
E DEFINER=`root`@`localhost` PROCEDURE `getServicoContratado`(
	IN id int
)
BEGIN
	IF id IS NOT NULL THEN
		SELECT s.id, p.nome, s.data_hora, s.preco
		  FROM servico_contratado s
          INNER JOIN pessoa_tem_funcao pf, pessoa p
          WHERE s.pessoa_tem_funcao_id_funcionario = pf.id
          AND pf.pessoa_id = p.id
		  AND s.id = id;
    ELSE
		SELECT s.id, p.nome, s.data_hora, s.preco
		  FROM servico_contratado s
          INNER JOIN pessoa_tem_funcao pf, pessoa p
          WHERE s.pessoa_tem_funcao_id_funcionario = pf.id
          AND pf.pessoa_id = p.id;
    END IF;
END