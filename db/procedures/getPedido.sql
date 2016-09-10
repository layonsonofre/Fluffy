CREATE DEFINER=`root`@`localhost` PROCEDURE `getPedido`(IN id INT)
BEGIN
	SELECT p.id, p.valor, p.desconto, pe1.nome as cliente, pe2.nome as funcionario
    FROM pedido p
    INNER JOIN pessoa_tem_funcao ptf1,pessoa_tem_funcao ptf2, pessoa pe1, pessoa pe2
    WHERE p.cliente_id = ptf1.id 
	AND p.funcionario_id = ptf2.id
    AND  ptf1.pessoa_id = pe1.id
    AND  ptf2.pessoa_id = pe2.id
    AND ((id IS NULL) or (p.id = id))
    ;
    
END