
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoa`(
	IN pessoa_id INT,
    IN nome VARCHAR(255),
    IN registro VARCHAR(14)
    )
BEGIN

	SELECT p.id, p.nome, p.data_hora_cadastro, p.email, p.registro, p.logradouro,
    p.numero, p.complemento, p.cep, p.ponto_de_referencia, c.nome, e.nome, pa.nome
    FROM pessoa p
    INNER JOIN cidade c, estado e, pais pa
    WHERE p.cidade_id = c.id
    AND c.estado_id = e.id
    AND e.pais_id = pa.id
    AND ((pessoa_id is null) or (p.id = pessoa_id))
    AND ((nome is null) or (p.nome like concat('%', nome, '%')))
    AND ((registro is null) or (p.registro like concat('%', registro, '%')));
END