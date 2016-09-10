
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServico`(
    IN id INT,
    IN nome VARCHAR(50)
)
BEGIN
    SELECT s.id, s.nome 
    FROM servico s
    WHERE 1 = 1
    AND ((id IS NULL) or (s.id = id))
    AND ((nome IS NULL) or (s.nome = nome));
END
