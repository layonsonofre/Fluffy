CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemDeVenda`(IN id INT)
BEGIN

	SELECT idv.id, idv.preco, idv.quantidade, i.nome as item
    FROM item_de_venda idv
    INNER JOIN item i ON idv.item_id = i.id
    WHERE 1 = 1
    AND ((id IS NULL) or (idv.id = id))
    ;
END