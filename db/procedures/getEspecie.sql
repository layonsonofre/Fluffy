
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEspecie`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT e.id, e.nome
		FROM especie e
		WHERE 1 = 1
		AND ((p_id is null) or (e.id = p_id))
		AND ((p_nome is null) or (e.nome like concat('%', p_nome, '%')));
END