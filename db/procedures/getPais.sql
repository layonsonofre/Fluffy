
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
END