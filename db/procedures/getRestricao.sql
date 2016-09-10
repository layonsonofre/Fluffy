CREATE DEFINER=`root`@`localhost` PROCEDURE `getRestricao`(IN id INT)
BEGIN
	SELECT r.id, r.restricao, r.descricao
    FROM restricao r
    WHERE 1 = 1
    AND ((id IS NULL) or (r.id = id))
    ;
END