
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
    	args["animal"] = ["pessoa_id"]
    	args["pessoa"] = ["pessoa_id"]
    	args["servico"] = ["servico_id", "porte_id"]

    	return [request.args.get(arg) for arg in args[modelo]]