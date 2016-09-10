CREATE DEFINER=`root`@`localhost` PROCEDURE `getLote`(IN id INT)
BEGIN
	SELECT l.id, l.numero, l.vencimento, l.preco
    FROM lote l
    WHERE 1 = 1
    AND ((id IS NULL) or (l.id = id))
    ;
END