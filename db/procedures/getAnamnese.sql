CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnamnese`(IN id INT)
BEGIN
	SELECT a.id, a.peso, a.tamanho, a.temperatura, an.nome 
	  FROM anamnese a
	 INNER JOIN servico_agendado sa
		ON a.servico_agendado_id = sa.id
	 INNER JOIN animal an
		ON sa.animal_id = an.id
	 WHERE 1 = 1
		AND ((id IS NULL) or(a.id = id))
	 ;
END