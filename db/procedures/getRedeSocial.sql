
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRedeSocial`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT *
		FROM rede_social rs
		WHERE 1 = 1
		AND ((p_id is null) OR (rs.id = p_id))
		AND ((p_nome is null) OR (rs.nome like concat('%', p_nome, '%')));
END