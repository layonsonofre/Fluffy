CREATE DEFINER=`root`@`localhost` PROCEDURE `getTelefone`(IN id INT, IN pessoa_id INT)
BEGIN
	SELECT t.id, t.codigo_pais, t.codigo_area, t.numero, p.nome as pessoa
    FROM telefone t
    INNER JOIN pessoa p ON t.pessoa_id = p.id
    WHERE 1 = 1
    AND ((id IS NULL) or (t.id = id))
    AND ((pessoa_id IS NULL) or (p.id = pessoa_id))
    ;
END