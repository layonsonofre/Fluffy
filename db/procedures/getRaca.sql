
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRaca`(
	IN p_id int
  , IN p_nome varchar(50)
  , IN p_especie_id int
  , IN p_porte_id int
)
BEGIN
	SELECT r.id, r.nome, p.nome, e.nome
		FROM raca r
		INNER JOIN especie e, porte p
		WHERE r.especie_id = e.id
        AND r.porte_id = p.id
		AND ((p_id is null) OR (r.id = p_id))
		AND ((p_nome is null) OR (r.nome like concat('%', p_nome, '%')))
		AND ((p_especie_id is null) OR (r.especie_id = p_especie_id))
		AND ((p_porte_id is null) OR (r.porte_id = p_porte_id));
END