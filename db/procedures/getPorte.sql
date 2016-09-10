
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPorte`(
	IN id int
)
BEGIN
	
    SELECT p.id, p.nome, p.tamanho_minimo, p.tamanho_maximo, p.peso_minimo, p.peso_maximo
	FROM porte p
    WHERE 1 = 1
    AND ((id IS NULL) or (p.id = id));
END