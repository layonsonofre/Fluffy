CREATE DEFINER=`root`@`localhost` PROCEDURE `getItem`(IN id INT)
BEGIN
	SELECT i.id, i.nome, i.preco, i.quantidade, gdi.nome as grupo, i.data_hora_cadastro
    FROM item i
    INNER JOIN grupo_de_item gdi ON i.grupo_de_item_id = gdi.id
    WHERE 1 = 1
		AND ((id IS NULL) or (i.id = id))
	;
END