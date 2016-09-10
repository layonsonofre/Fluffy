
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicoContratado`(
  IN id int
)
BEGIN

  SELECT s.id, p.nome, s.data_hora, s.preco
      FROM servico_contratado s
          INNER JOIN pessoa_tem_funcao pf, pessoa p
          WHERE s.pessoa_tem_funcao_id_funcionario = pf.id
          AND pf.pessoa_id = p.id
      AND ((id IS NULL) or (s.id = id));
          
END