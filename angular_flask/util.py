
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
    	args["pessoa"] = ["id","nome","registro"]
    	args["servico"] = ["id","servico_id","porte_id"]
    	args["servicoContratado"] = ["id"]
    	args["servicoAgendado"] = ["id", "servico_contratado_id", "data_inicio","data_fim"]

    	return [request.args.get(arg) for arg in args[modelo]]