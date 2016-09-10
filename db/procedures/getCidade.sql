
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