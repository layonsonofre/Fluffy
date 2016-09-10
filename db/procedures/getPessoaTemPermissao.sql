CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemPermissao`(IN id INT, IN pessoa_id INT, IN permissao_id INT)
BEGIN
	SELECT ptp.id, p.nome as pessoa, pe.modulo
    FROM pessoa_tem_permissao ptp
    INNER JOIN pessoa_tem_funcao ptf ON ptp.pessoa_tem_funcao_id = ptf.id
    INNER JOIN pessoa p ON ptf.pessoa_id = p.id
    INNER JOIN permissao pe ON ptp.permissoes_id = pe.id
    WHERE 1 = 1
    AND ((id IS NULL) or (ptp.id = id))
    AND ((pessoa_id IS NULL) or (p.id = pessoa_id))
    AND ((permissao_id IS NULL) or (pe.id = permissao_id))
    ;
END