
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemFuncao`(
	IN p_id int
  , IN p_pessoa_id int
  , IN p_funcao_id int
)
BEGIN
	SELECT ptf.id, p.nome as pessoa, f.nome as funcao
	  FROM pessoa_tem_funcao ptf
	 INNER JOIN funcao f
		ON f.id = ptf.funcao_id
	 INNER JOIN pessoa p
		ON p.id = ptf.pessoa_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (ptf.id = p_id))
       AND ((p_pessoa_id is null) OR (ptf.pessoa_id = p_pessoa_id))
       AND ((p_funcao_id is null) OR (ptf.funcao_id = p_funcao_id));
END