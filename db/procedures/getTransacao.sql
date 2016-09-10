
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