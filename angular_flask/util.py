
from angular_flask.core import mysql
from flask import Flask, request

class Util:

    @staticmethod
    def getData(proc, args):
    	conn = mysql.connect()
    	cursor = conn.cursor()
    	cursor.callproc(proc, args)
    	data = cursor.fetchall()
    	return data

    @staticmethod
    def requestArgs(modelo):
    	args = {}
    	args["animal"] = ["id","nome","pessoa_id","raca_id","porte_id"]
        args["cidade"] = ["id","nome", "estado_id", "pais_id"]
        args["especie"] = ["id","nome"]
        args["estado"] = ["id","nome","uf","pais_id"]
        args["funcao"] = ["id","nome"]
        args["pais"] = ["id","nome"]
    	args["pessoa"] = ["id","nome","registro"]
        args["pessoaTemFuncao"] = ["id","pessoa_id","funcao_id"]
        args["pessoaTemRedeSocial"] = ["id","perfil","pessoa_id","rede_social_id"]
        args["porte"] = ["id"]
        args["raca"] = ["id","nome","especie_id","porte_id"]
        args["redeSocial"] = ["id","nome"]
    	args["servico"] = ["id","nome"]
    	args["servicoContratado"] = ["id"]
    	args["servicoAgendado"] = ["id", "servico_contratado_id", "data_inicio","data_fim"]
        args["servicoTemPorte"] = ["id","servico_id","porte_id"]
        args["transacao"] = ["id","tipo","data_inicio","data_fim"]

    	return [request.args.get(arg) for arg in args[modelo]]