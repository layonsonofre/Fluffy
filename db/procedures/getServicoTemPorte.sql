
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicoTemPorte`(
	IN id INT,
	IN servico_id INT,
	IN porte_id INT
)
BEGIN
	SELECT sp.id, s.nome, p.nome, sp.preco FROM servico_tem_porte sp
    INNER JOIN porte p, servico s
    WHERE sp.porte_id = p.id
    AND sp.servico_id = s.id
    AND ((id IS NULL) or (sp.id = s.id))
    AND ((servico_id IS NULL) or (sp.servico_id = servico_id))
    AND ((porte_id IS NULL) or (sp.porte_id = porte_id));
END