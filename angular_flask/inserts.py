from flask import Flask, request, Response, jsonify

from angular_flask import app

# routing for API endpoints, generated from the models designated as API_MODELS
from util import *
from angular_flask.core import mysql
from angular_flask.models import *

@app.route('/api/insertServicoAgendado', methods=['POST'])
def insertServicoAgendado() :
	json = request.json

	transacao_id = 0
	valor = 0

	if "transacao_id" in json:
		transacao_id = json["transacao_id"]
	else:
		data = Util.postData("insTransacao", ["C", 0])
		transacao_id = data[0]

	if "valor" in json:
		valor = json["valor"]

	data = Util.postData("insServicoContratado", [json["pessoa_tem_funcao_funcionario_id"], valor, transacao_id])
	servico_contratado_id = data[0]
	servicosAgendados = json["servicos_agendados"]

	for servicoAgendado in servicosAgendados:
		observacao = servicoAgendado["observacao"] if ("observacao" in servicoAgendado) else None
		data_hora_executado = servicoAgendado["data_hora_executado"] if ("data_hora_executado" in servicoAgendado) else None
		pessoa_tem_funcao_funcionario_executa_id = servicoAgendado["pessoa_tem_funcao_funcionario_executa_id"] if("pessoa_tem_funcao_funcionario_executa_id" in servicoAgendado) else None
		preco = servicoAgendado["preco"] if ("preco" in servicoAgendado) else None
		recorrente = ("recorrente" in servicoAgendado)
		data_hora = servicoAgendado["data_hora"] if ("data_hora" in servicoAgendado) else None
		servico_id = servicoAgendado["servico_id"] if ("servico_id" in servicoAgendado) else None
		animal_id = servicoAgendado["animal_id"] if ("animal_id" in servicoAgendado) else None
		executado = ("executado" in servicoAgendado)
		pago = ("pago" in servicoAgendado)

		data = Util.postData("insServicoAgendado", [
			preco,
			recorrente,
			data_hora,
			servico_id,
			animal_id,
			servico_contratado_id,
			executado,
			pago,
			observacao,
			data_hora_executado,
			pessoa_tem_funcao_funcionario_executa_id
		])
		print data

	return jsonify(result="OK")

@app.route('/api/insertPedido', methods=['POST'])
def insertPedido() :

	json = request.json

	transacao_id = 0
	valor = 0

	if "transacao_id" in json:
		transacao_id = json["transacao_id"]
	else:
		data = Util.postData("insTransacao", ["C", 0])
		transacao_id = data[0]

	if "valor" in json:
		valor = json["valor"]

	data = Util.postData("insServicoContratado", [json["pessoa_tem_funcao_funcionario_id"], valor, transacao_id])
	servico_contratado_id = data[0]
	print(servico_contratado_id)
	servicosAgendados = json["servicos_agendados"]

	for servicoAgendado in servicosAgendados:
		observacao = None
		data_hora_executado = None
		pessoa_tem_funcao_funcionario_executa_id = None
		observacao = servicoAgendado["observacao"] if ("observacao" in servicoAgendado) else None
		data_hora_executado = servicoAgendado["data_hora_executado"] if ("data_hora_executado" in servicoAgendado) else None
		pessoa_tem_funcao_funcionario_executa_id = servicoAgendado["pessoa_tem_funcao_funcionario_executa_id"] if("pessoa_tem_funcao_funcionario_executa_id" in servicoAgendado) else None
		data = Util.postData("insServicoAgendado", [
			servicoAgendado["preco"], servicoAgendado["recorrente"], servicoAgendado["data_hora"], servicoAgendado["servico_id"],
			servicoAgendado["animal_id"], servico_contratado_id, servicoAgendado["executado"],
			servicoAgendado["pago"], observacao, data_hora_executado,
			pessoa_tem_funcao_funcionario_executa_id
		])

	return jsonify(result="OK")
