CREATE DEFINER=`root`@`localhost` PROCEDURE `getLembrete`(IN id INT)
BEGIN
	SELECT l.id, l.descricao, l.data_hora, l.executado, p.nome as pessoa
    FROM lembrete l
    INNER JOIN pessoa p ON l.pessoa_id = p.id
    WHERE 1 = 1
    AND ((id IS NULL) or (l.id = id))
    ;
END
