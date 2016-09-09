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
  , IN p_pessoa_id int
  , IN p_raca_id int
  , IN p_porte_id int
)
BEGIN
  SELECT a.id, a.nome, a.sexo, a.data_hora_cadastro, a.data_nascimento, p.nome, r.nome, porte.nome
    FROM animal a
    INNER JOIN pessoa_tem_funcao pf, pessoa p, raca r, porte
    WHERE a.pessoa_tem_funcao_id = pf.id
    AND pf.pessoa_id = p.id
    AND a.porte_id = porte.id
    AND a.raca_id = r.id
    AND ((p_id is null) or (a.id = p_id))
    AND ((p_nome is null) or (a.nome like concat('%', p_nome, '%')))
    AND ((p_pessoa_id is null) or (p.id = p_pessoa_id))
    AND ((p_raca_id is null) or (a.raca_id = p_raca_id))
    AND ((p_porte_id is null) or (a.porte_id = p_porte_id))
    ;
END