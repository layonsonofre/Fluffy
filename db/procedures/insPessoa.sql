CREATE DEFINER=`root`@`localhost` PROCEDURE `insPessoa`(
	IN p_nome varchar(100)
  , IN p_email varchar(50)
  , IN p_registro varchar(14)
  , IN p_logradouro varchar(100)
  , IN p_numero int
  , IN p_complemento varchar(50)
  , IN p_cep varchar(8)
  , IN p_ponto_de_referencia varchar(200)
  , IN p_cidade_id int
  , OUT ret VARCHAR(100)
)
label: BEGIN
	DECLARE c_email VARCHAR(100);
    DECLARE c_registro VARCHAR(100);
	DECLARE error_message VARCHAR(100);
    
    IF p_nome IS NULL OR p_logradouro IS NULL OR p_numero IS NULL OR p_cep IS NULL OR p_cidade_id IS NULL THEN
        SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Impossível inserir campo nulo';
	END IF;
    
    SELECT count(*)
      INTO c_email
      FROM pet_shop.pessoa p
	 WHERE p.email = p_email;
	IF c_email > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Email já está sendo utilizado por outra pessoa';
	END IF;
    
    SELECT count(*)
      INTO c_registro
      FROM pet_shop.pessoa p
	 WHERE p.registro = p_registro;
	IF c_registro > 0 THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Registro já está sendo utilizado por outra pessoa';
	END IF;
    
	INSERT INTO pet_shop.pessoa
		(nome, data_hora_cadastro, email, registro, logradouro, numero, complemento, cep, ponto_de_referencia, cidade_id)
	VALUES
		(p_nome, NOW(), p_email, p_registro, p_logradouro, p_numero, p_complemento, p_cep, p_ponto_de_referencia, p_cidade_id);
END