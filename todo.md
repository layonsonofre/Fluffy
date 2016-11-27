# Todos

* AnimalTemRestricao nao funcionando ainda (mas acho que estou enviando errado)
* Aumentar tamanho da coluna bairro
* Mudar nome da coluna 'TOTAL_DOSE' pra 'DOSE' -> Não está editando este campo da vacina

```sql
--- RODAR ESTE MÉTODO
DROP PROCEDURE altConfiguracao;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `altConfiguracao`(
	IN p_quantidade_animais int
  , IN p_periodos_dia int
)

BEGIN

    IF p_quantidade_animais IS NULL AND p_periodos_dia IS NULL THEN
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'Nenhuma informação foi alterada';
	END IF;

	UPDATE configuracao
       SET quantidade_animais = CASE WHEN p_quantidade_animais IS NULL THEN quantidade_animais ELSE p_quantidade_animais END
         , periodos_dia = CASE WHEN p_periodos_dia IS NULL THEN periodos_dia ELSE p_periodos_dia END
	 WHERE 1 = 1;

    SELECT 1;

END$$
DELIMITER ;
```
