from flask import Flask, request, Response, jsonify

from angular_flask import app

# routing for API endpoints, generated from the models designated as API_MODELS
from util import *
from angular_flask.core import mysql
from angular_flask.models import *

@app.route('/api/getPessoa', methods=['GET'])
def getPessoa() :

	data = request.args
	print(data)
	return jsonify(result="OK")

@app.route('/api/getHistorico', methods=['GET'])
def getHistorico() :

	tipo = str(request.args.get("tipo")) if request.args.get("tipo") is not None else None
	data_inicio = request.args.get("data_inicio")
	data_fim = request.args.get("data_fim")

	print([tipo, data_inicio, data_fim])
	data = Util.getData("getHistorico", [tipo, data_inicio, data_fim])

	if data is None or len(data) == 0 :
		return jsonify(success=True,result=list,message="Nenhum registro cadastrado")

	caixa = [float(data[0][0]), float(data[0][1]), float(data[0][2])]
	print(caixa)

	list = []
	for info in data:
		if info[10] is not None:
			list.append( {
				"tipo": info[4],
				"data_hora": info[8],
				"descricao": info[9],
				"valor": float(info[10])
				} )
		elif info[11] is not None:
			list.append( {
				"tipo": info[4],
				"data_hora": info[5],
				"descricao": "Pedido",
				"valor": float(info[11]) - float(info[12])
				} )
		else:
			list.append( {
				"tipo": info[4],
				"data_hora": info[5],
				"descricao": info[7],
				"valor": float(info[6])
				} )
	

	return jsonify(success=True,result= {
											"soma_credito": caixa[0],
											"soma_debito": caixa[1],
											"caixa": caixa[2],
											"historico": list
										}, message="")
