CREATE DEFINER=`root`@`localhost` PROCEDURE `getPermissao`(IN id INT)
BEGIN
	SELECT p.id, p.modulo
	FROM permissao p
    WHERE 1 = 1
    AND ((id IS NULL) or (p.id = id))
    ;
END