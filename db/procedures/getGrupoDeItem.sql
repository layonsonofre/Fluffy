CREATE DEFINER=`root`@`localhost` PROCEDURE `getGrupoDeItem`(IN id INT)
BEGIN
	SELECT gdi.id, gdi.nome
    FROM grupo_de_item gdi
    WHERE 1 = 1
    AND ((id IS NULL) or (gdi.id = id))
    ;
END