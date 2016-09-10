
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFuncao`(
	IN p_id int
  , IN p_nome varchar(50)
)
BEGIN
	SELECT *
		FROM funcao f
		WHERE 1 = 1
		AND ((p_id is null) or (f.id = p_id))
		AND ((p_nome is null) or (f.nome = p_nome));
END