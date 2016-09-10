CREATE DEFINER=`root`@`localhost` PROCEDURE `getConfiguracao`()
BEGIN
	SELECT quantidade_animais, periodos_dia
    FROM configuracao;
END