CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnimalTemRestricao`(IN id INT, IN animal_id INT, IN restricao_id INT)
BEGIN
	SELECT atr.id, a.nome, r.restricao, r.descricao
    FROM animal_tem_restricao atr
    INNER JOIN animal a ON atr.animal_id = a.id
    INNER JOIN restricao r ON atr.restricao_id = r.id
    WHERE 1 = 1
    AND ((id IS NULL) or (atr.id = id))
    AND ((animal_id IS NULL) or (a.id = animal_id))
    AND ((restricao_id IS NULL) or (r.id = restricao_id))
    ;
END