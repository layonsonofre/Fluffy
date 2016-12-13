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
@app.route('/api/historicoContratos', methods=['GET'])
def getContratos() :

	servico_id = str(request.args.get("servico_id")) if request.args.get("servico_id") is not None else None
	servico_contratado_id = str(request.args.get("servico_contratado_id")) if request.args.get("servico_contratado_id") is not None else None
	servico_agendado_id = str(request.args.get("servico_agendado_id")) if request.args.get("servico_agendado_id") is not None else None
	animal_id = str(request.args.get("animal_id")) if request.args.get("animal_id") is not None else None
	cliente_id = str(request.args.get("cliente_id")) if request.args.get("cliente_id") is not None else None
	funcionario_contrato_id = str(request.args.get("funcionario_contrato_id")) if request.args.get("funcionario_contrato_id") is not None else None
	funcionario_executa_id = str(request.args.get("funcionario_executa_id")) if request.args.get("funcionario_executa_id") is not None else None
	data_inicio_contrato = str(request.args.get("data_inicio_contrato")) if request.args.get("data_inicio_contrato") is not None else None
	data_fim_contrato = str(request.args.get("data_fim_contrato")) if request.args.get("data_fim_contrato") is not None else None
	data_inicio_agendamento = str(request.args.get("data_inicio_agendamento")) if request.args.get("data_inicio_agendamento") is not None else None
	data_fim_agendamento = str(request.args.get("data_fim_agendamento")) if request.args.get("data_fim_agendamento") is not None else None
	cancelado = str(request.args.get("cancelado")) if request.args.get("cancelado") is not None else None
	executado = str(request.args.get("executado")) if request.args.get("executado") is not None else None
	pago = str(request.args.get("pago")) if request.args.get("pago") is not None else None

	data = Util.getData("getServicoContratado", [servico_contratado_id, data_inicio_contrato, data_fim_contrato, funcionario_contrato_id])

	result = []

	servicos_contratados = []
	for info in data:
		servicos_contratados.append(ServicoContratado(info))

	if cliente_id is not None and animal_id is None:
		animal_id = Animal(Util.getData("getAnimal", [None, None, cliente_id, None, None, None])[0]).id

	for sc in servicos_contratados:
		servicos_agendados = []
		data
		data = Util.getData("getServicoAgendado", [servico_agendado_id, sc.id, data_inicio_agendamento, data_fim_agendamento, None, executado, pago, None, None, animal_id, servico_id, cancelado, funcionario_executa_id])
		for info in data:
			servicos_agendados.append(ServicoAgendado(info))

		if len(servicos_agendados) > 0:
			data = Util.getData("getAnimal", [servicos_agendados[0].animal[0], None, None, None, None, None])
			animal = Animal(data[0]) if data is not None else None
		else:
			animal = None

		if len(servicos_agendados) > 0:
			result.append({
				"id":sc.id,
				"pessoa_tem_funcao_funcionario": {
					"id":sc.pessoa_tem_funcao[0],
					"pessoa_id":sc.pessoa_tem_funcao[1],
					"nome":sc.pessoa_tem_funcao[2]
				},
				"pessoa_tem_funcao_cliente": {
					"id": (animal.pessoa_tem_funcao_cliente[0] if animal is not None else None),
					"pessoa_id":(animal.pessoa_tem_funcao_cliente[1] if animal is not None else None),
					"nome":(animal.pessoa_tem_funcao_cliente[2] if animal is not None else None)
				},
				"data_hora":sc.data_hora,
				"preco":sc.preco,
				"transacao_id":sc.transacao,
				"servicos_agendados": [sa.toJSON() for sa in servicos_agendados]
			})

	return jsonify(success=True,result=result, message="")


@app.route("/api/taxiDog", methods=["GET"])
def getTaxiDog():

	servico = Servico(Util.getData('getServico', [None, "TaxiDog"])[0])

	animal_id = str(request.args.get("animal_id")) if request.args.get("animal_id") is not None else None
	cliente_id = str(request.args.get("cliente_id")) if request.args.get("cliente_id") is not None else None
	data_inicio_agendamento = str(request.args.get("data_inicio_agendamento")) if request.args.get("data_inicio_agendamento") is not None else None
	data_fim_agendamento = str(request.args.get("data_fim_agendamento")) if request.args.get("data_fim_agendamento") is not None else None
	executado = str(request.args.get("executado")) if request.args.get("executado") is not None else None
	cancelado = str(request.args.get("cancelado")) if request.args.get("cancelado") is not None else None

	servicos_agendados = [ServicoAgendado(info) for info in Util.getData('getServicoAgendado',[None, None, data_inicio_agendamento, data_fim_agendamento, None, executado, None, None, None, animal_id, servico.id, cancelado, None])]

	servico_list = []
	for sa in servicos_agendados:
		animal = Animal(Util.getData('getAnimal', [sa.animal[0], None, None, None, None, None])[0])
		pessoa = Pessoa(Util.getData('getPessoa', [animal.pessoa_tem_funcao_cliente[1], None, None, None, None, None, None, None, None, None, None, None, None, None, None, None])[0])
		servico_list.append({
			"servico_agendado_id":sa.id,
			"data_hora": sa.data_hora,
			"animal_id": animal.id,
			"animal_nome": animal.nome,
			"pessoa_id": pessoa.id,
			"pessoa_nome": pessoa.nome,
			"local": pessoa.logradouro + "," + str(pessoa.numero),
			"bairro": pessoa.bairro,
			"animal": animal.toJSON(),
			"pessoa": pessoa.toJSON(),
			"servicoAgendado": sa.toJSON()
			})

	return jsonify(success=True, message = "", servico_list = servico_list)
