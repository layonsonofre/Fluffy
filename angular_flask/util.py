
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
           conn.commit()
        except:
    	    raise

    @staticmethod
    def requestInsertArgs(modelo):
        args = {}
        args["pessoa"] = ["id","nome","email","registro","logradouro","numero","complemento","cep","ponto_de_referencia","cidade_id"]
        args["animal"] = ["nome","sexo","data_nascimento","pessoa_id","raca_id","porte_id"]
        return [request.form.get(arg) for arg in args[modelo]]

    @staticmethod
    def requestArgs(modelo):
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