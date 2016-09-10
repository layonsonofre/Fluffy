
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPessoaTemRedeSocial`(
	IN p_id int
  , IN p_perfil varchar(200)
  , IN p_pessoa_id int
  , IN p_rede_social_id int
)
BEGIN
	SELECT ptrs.id, pes.nome as pessoa, ptrs.perfil, rs.nome as redeSocial
	  FROM pessoa_tem_rede_social ptrs
	 INNER JOIN pessoa pes
		ON pes.id = ptrs.pessoa_id
	 INNER JOIN rede_social rs
		ON rs.id = ptrs.rede_social_id
	 WHERE 1 = 1
       AND ((p_id is null) OR (ptrs.id = p_id))
       AND ((p_perfil is null) OR (ptrs.perfil like concat('%', p_perfil, '%')))
       AND ((p_rede_social_id is null) OR (ptrs.rede_social_id = p_rede_social_id))
       AND ((p_pessoa_id is null) OR (ptrs.pessoa_id = p_pessoa_id));
END