CREATE DEFINER=`root`@`localhost` PROCEDURE `getAplicacao`(IN id INT)
BEGIN
	SELECT a.id, a.data_hora, a.aplicado, a.dose as dose_aplicada, v.dose as numero_de_doses,
		v.nome as vacina, an.nome as animal
	  FROM aplicacao a
	 INNER JOIN vacina v
		ON a.vacina_id = v.id
	 INNER JOIN servico_agendado sa
		ON a.servico_agendado_id = sa.id
	 INNER JOIN animal an
		ON sa.animal_id = an.id
	 WHERE 1 = 1
		AND ((id IS NULL) or(a.id = id))
	 ;
END