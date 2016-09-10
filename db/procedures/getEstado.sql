
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEstado`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_uf char(2)
  , IN p_pais_id int
)
BEGIN
	SELECT e.id, e.nome as estado, e.uf, p.nome as pais
		FROM estado e
		INNER JOIN pais p
		WHERE e.pais_id = p.id
		AND ((p_id is null) or (e.id = p_id))
		AND ((p_nome is null) or (e.nome like concat('%', p_nome, '%')))
		AND ((p_uf is null) or (e.uf like p_nome))
		AND ((p_pais_id is null) or (e.pais_id = p_pais_id));
END