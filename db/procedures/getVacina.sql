CREATE DEFINER=`root`@`localhost` PROCEDURE `getVacina`(IN id INT)
BEGIN
	SELECT v.id, v.nome, v.dose as total_doses, v.intervalo, l.numero as lote, l.vencimento
    FROM vacina v
    INNER JOIN lote l ON v.lote_id = l.id
    WHERE 1 = 1
    AND ((id IS NULL) or (v.id = id))
    ;
END