#!/usr/bin/env python
# -*- coding: utf-8 -*-

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

@app.route('/api/getPermissoes', methods=['GET'])
def getPermissoes() :

	authorization = str(request.headers["Authorization"])
	try:
		auth_type, auth_token = authorization.split(" ")
	except Exception as e:
		return jsonify(success=False, result={}, mensagem="Sua Sessao Expirou", code=401)

	if auth_type != "Bearer":
		return jsonify(success=False, result={}, mensagem="Sua Sessao Expirou", code=401)

	data = Util.getData("getOAuth", [None, str(auth_token), None])

	if len(data) != 1:
		return jsonify(success=False, result={}, mensagem="Sua Sessao Expirou", code=401)

	oauth = OAuth(data[0])

	if oauth.time_left < 0:
		if oauth.time_left > - (3*60*60):
			return jsonify(success=False, result={}, mensagem="Sua Sessao Expirou", code=401)
		else :    
			return jsonify(success=False, result={}, mensagem="Sua Sessao Expirou", code=401)

	print([None, None, None, None, None, None, oauth.id, None])
	data = Util.getData("getPessoaTemFuncao", [None, None, None, None, None, None, oauth.id, None])
	print(data)
	ptf = PessoaTemFuncao(data[0])

	data = Util.getData("getPessoaTemPermissao", [None, ptf.id, None])
	
	permissoes = []
	for info in data:
		permissoes.append(PessoaTemPermissao(info))

	return jsonify(result={
							"token": {
								"id": oauth.id,
								"token": oauth.token
							},
							"pessoa": {
								"id":ptf.pessoa[0],
								"nome":ptf.pessoa[1],
								"email":ptf.pessoa[2],
								"registro":ptf.pessoa[3]
							},
							"modulos": [{"id": p.permissao[0],"modulo": p.permissao[1]} for p in permissoes]
							})


@app.route('/api/getHistorico', methods=['GET'])
def getHistorico() :

	tipo = str(request.args.get("tipo")) if request.args.get("tipo") is not None else None
	data_inicio = str(request.args.get("data_inicio")) if request.args.get("data_inicio") is not None else None
	data_fim = str(request.args.get("data_fim")) if request.args.get("data_fim") is not None else None

	print([tipo, data_inicio, data_fim])
	data = Util.getData("getHistorico", [tipo, data_inicio, data_fim])
	print(data)
	if data is None or len(data) == 0 :
		return jsonify(success=True,result=list,message="Nenhum registro cadastrado")

	caixa = [float(data[0][0]), float(data[0][1]), float(data[0][2])]
	transacao = [data[0][3], data[0][4], data[0][5], data[0][6], data[0][7]]
	print(caixa)

	list = []
	for info in data:
		if info[15] is not None:
			list.append( {
				"tipo": info[9],
				"data_hora": info[13],
				"descricao": info[14],
				"valor": float(info[15])
				} )
		elif info[16] is not None:
			list.append( {
				"tipo": info[9],
				"data_hora": info[10],
				"descricao": "Pedido",
				"valor": float(info[16]) - float(info[17])
				} )
		else:
			list.append( {
				"tipo": info[9],
				"data_hora": info[10],
				"descricao": info[12],
				"valor": float(info[11])
				} )
	

	return jsonify(success=True,result= {
											"soma_credito": caixa[0],
											"soma_debito": caixa[1],
											"caixa": caixa[2],
											"vendas_totais": transacao[0],
											"vendas_pagas": transacao[1],
											"servicos_totais": transacao[2],
											"servicos_executados": transacao[3],
											"servicos_pagos": transacao[4],
											"historico": list
										}, message="")
