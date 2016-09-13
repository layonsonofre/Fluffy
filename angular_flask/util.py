
from angular_flask.core import mysql
from flask import Flask, request

class Util:

    @staticmethod
    def getData(proc, args):
        try:
    	   conn = mysql.connect()
    	   cursor = conn.cursor()
    	   cursor.callproc(proc, args)
    	   data = cursor.fetchall()
           return data
        except:
    	    raise

    @staticmethod
    def postData(proc, args):
        try:
           conn = mysql.connect()
           cursor = conn.cursor()
           cursor.callproc(proc, args)
           data = cursor.fetchone()
           cursor.close() 
           conn.commit()
           return data
        except:
            raise

    @staticmethod
    def requestFormArgs(modelo):
        args = {}
        args["anamnese"] = ["id","peso","tamanho","temperatura","servico_agendado"]
        args["animal"] = ["id","nome","sexo","data_nascimento","pessoa_id","raca_id","porte_id"]
        args["animalTemRestricao"] = ["id","animal_id","restricao_id"]
        args["aplicacao"] = ["id","data_hora","aplicado","dose","vacina_id","servico_agendado_id"]
        args["cidade"] = ["id","nome", "estado_id"]
        args["configuracao"] = ["id","quantidade_animais","periodos_dia"]
        args["especie"] = ["id","nome"]
        args["estado"] = ["id","nome","uf","pais_id"]
        args["funcao"] = ["id","nome"]
        args["grupoDeItem"] = ["id","nome"]
        args["item"] = ["id","nome","preco","quantidade","grupo_de_item_id"]
        args["itemDeVenda"] = ["id","preco","quantidade","item_id","pedido_id"]
        args["lembrete"] = ["id","descricao","data_hora","executado","pessoa_id"]
        args["lote"] = ["id","numero","vencimento","preco"]
        args["pais"] = ["id","nome"]
        args["pedido"] = ["id","valor","desconto","transacao","cliente_id","funcionario_id"]
        args["permissao"] = ["id","modulo"]
        args["pessoa"] = ["id","nome","email","registro","registro","logradouro","numero","complemento","cep","ponto_de_referencia","cidade_id"]
        args["pessoaTemFuncao"] = ["id","pessoa_id","funcao_id"]
        args["pessoaTemPermissao"] = ["id","pessoa_id","permissao_id"]
        args["pessoaTemRedeSocial"] = ["id","perfil","pessoa_id","rede_social_id"]

        ####TODO####
        args["porte"] = ["id"]
        args["raca"] = ["id","nome","especie_id","porte_id"]
        args["redeSocial"] = ["id","nome"]
        args["restricao"] = ["id"]
        args["servico"] = ["id","nome"]
        args["servicoContratado"] = ["id"]
        args["servicoAgendado"] = ["id", "servico_contratado_id", "data_inicio","data_fim"]
        args["servicoTemPorte"] = ["id","servico_id","porte_id"]
        args["telefone"] = ["id","pessoa_id"]
        args["transacao"] = ["id","tipo","data_inicio","data_fim"]
        args["vacina"] = ["id"]
        return [(request.form.get(arg) if (request.form.get(arg) != ("true" or "false")) else (True if request.form.get(arg) == "true" else False))  for arg in args[modelo]]

    @staticmethod
    def requestGetArgs(modelo):
    	args = {}
        args["anamnese"] = ["id"]
    	args["animal"] = ["id","nome","pessoa_id","raca_id","porte_id"]
        args["animalTemRestricao"] = ["id","animal_id","restricao_id"]
        args["aplicacao"] = ["id"]
        args["cidade"] = ["id","nome", "estado_id", "pais_id"]
        args["configuracao"] = []
        args["especie"] = ["id","nome"]
        args["estado"] = ["id","nome","uf","pais_id"]
        args["funcao"] = ["id","nome"]
        args["grupoDeItem"] = ["id"]
        args["item"] = ["id"]
        args["itemDeVenda"] = ["id"]
        args["lembrete"] = ["id"]
        args["lote"] = ["id"]
        args["pais"] = ["id","nome"]
        args["pedido"] = ["id"]
        args["permissao"] = ["id"]
    	args["pessoa"] = ["id","nome","registro"]
        args["pessoaTemFuncao"] = ["id","pessoa_id","funcao_id"]
        args["pessoaTemPermissao"] = ["id","pessoa_id","permissao_id"]
        args["pessoaTemRedeSocial"] = ["id","perfil","pessoa_id","rede_social_id"]
        args["porte"] = ["id"]
        args["raca"] = ["id","nome","especie_id","porte_id"]
        args["redeSocial"] = ["id","nome"]
        args["restricao"] = ["id"]
    	args["servico"] = ["id","nome"]
    	args["servicoContratado"] = ["id"]
    	args["servicoAgendado"] = ["id", "servico_contratado_id", "data_inicio","data_fim"]
        args["servicoTemPorte"] = ["id","servico_id","porte_id"]
        args["telefone"] = ["id","pessoa_id"]
        args["transacao"] = ["id","tipo","data_inicio","data_fim"]
        args["vacina"] = ["id"]

    	return [request.args.get(arg) for arg in args[modelo]]