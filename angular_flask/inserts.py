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
		try:
			data = Util.postData("insTransacao", ["C", 0, None])
			transacao_id = data[0]
		except Exception as e:
			message = e.__str__()
			table = "transacao"
			json = str(request.json)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
			return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)

	if "valor" in json:
		valor = json["valor"]

	try:
		data = Util.postData("insServicoContratado", [json["pessoa_tem_funcao_funcionario_id"], valor, transacao_id])
		servico_contratado_id = data[0]
		servicosAgendados = json["servicos_agendados"]
	except Exception as e:
		data = Util.postData("delTransacao", [transacao_id])
		message = e.__str__()
		table = "servico_contratado"
		json = str(request.json)
		method = request.method
		data = Util.postData("insLog", [message, json, table, method])
		#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
		return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)		

	servico_stored = 0
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
		cancelado = servicoAgendado["cancelado"] if "cancelado" in servicoAgendado  else False
		try:
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
				pessoa_tem_funcao_funcionario_executa_id,
				cancelado
			])
			print data
			servico_stored = servico_stored + 1
		except Exception as e:
			message = e.__str__()
			table = "servico_agendado"
			json = str(servicoAgendado)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])

		if servico_stored == 0:
			data = Util.postData("delServicoContratado", [servico_contratado_id])
			data = Util.postData("delTransacao", [transacao_id])
			#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
			return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)		
	
	return jsonify(result="OK", success=True, message="Inserido Com Sucesso!")

@app.route('/api/insertPedido', methods=['POST'])
def insertPedido() :

	json = request.json

	transacao_id = 0
	valor = 0
	desconto = 0

	if "transacao_id" in json:
		transacao_id = json["transacao_id"]
	else:
		try:
			data = Util.postData("insTransacao", ["C", 0, None])
			transacao_id = data[0]
		except Exception as e:
			message = e.__str__()
			table = "transacao"
			json = str(request.json)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
			return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)		

	if "valor" in json:
		valor = json["valor"]

	if "desconto" in json:
		desconto = json["desconto"]

	try:
		data = Util.postData("insPedido", [valor, desconto, transacao_id, json["pessoa_tem_funcao_cliente_id"], json["pessoa_tem_funcao_funcionario_id"]])
		pedido_id = data[0]
		print(pedido_id)
		itensDeVenda = json["itens_de_venda"]
	except Exception as e:
		data = Util.postData("delTransacao", [transacao_id])
		message = e.__str__()
		table = "pedido"
		json = str(request.json)
		method = request.method
		data = Util.postData("insLog", [message, json, table, method])
		#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
		return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)		

	item_stored = 0
	for itemDeVenda in itensDeVenda:

		preco = itemDeVenda["preco"]
		quantidade = itemDeVenda["quantidade"]
		item_id = itemDeVenda["item_id"]
		try:
			data = Util.postData("insItemDeVenda", [
				preco, quantidade, item_id, pedido_id
			])
			item_stored = item_stored + 1
		except Exception as e:
			message = e.__str__()
			table = "item_de_venda"
			json = str(itemDeVenda)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])

	if item_stored == 0:
		data = Util.postData("delPedido", [pedido_id])
		data = Util.postData("delTransacao", [transacao_id])
		#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
		return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)		

	return jsonify(result="OK", success=True, message="Inserido Com Sucesso!")


@app.route('/api/insertCliente', methods=['POST'])
def insertCliente():

	json = request.json
	pessoa = json["pessoa"]

	try:
		data = Util.requestFormArgs("pessoa", pessoa)
		data.pop(0)
		print(data)
		result = Util.postData("insPessoa", data)
	except Exception as e:
		message = e.__str__()
		table = "pessoa"
		json = str(pessoa)
		method = request.method
		data = Util.postData("insLog", [message, json, table, method])
		#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
		return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)		
	
	data.insert(0,None)
	data.insert(2,"")

	pessoa = Pessoa(data)
	pessoa.id = result[0]

	funcao_id = 1
	funcao_nome = "cliente"

	if "cliente-especial" in json and json["cliente-especial"] is True:
		funcao_id = 2
		funcao_nome = "cliente-especial"

	try:
		data = [pessoa.id, pessoa.nome, pessoa.email, pessoa.registro, funcao_id, funcao_nome, None, None, None]
		ptf = PessoaTemFuncao([None] + data)
		ptf.id = Util.postData("insPessoaTemFuncao", [data[0],data[4], None, None])[0]
	except Exception as e:
		result = Util.postData("delPessoa", [pessoa.id])
		message = e.__str__()
		table = "pessoa_tem_funcao"
		json = str(request.json)
		method = request.method
		data = Util.postData("insLog", [message, json, table, method])
		#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
		return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)

	telefones = []
	for telefone in json["telefones"]:
		data = [telefone["numero"], telefone["codigo_area"], telefone["codigo_pais"], pessoa.id]
		tel = Telefone([None, data[2], data[1], data[0], data[3]])
		tel.id = Util.postData("insTelefone", data)[0]
		telefones.append(tel)

	ptrs = []
	for ptr in json["redes_sociais"]:
		data = [ptr["perfil"], ptr["rede_social_id"], pessoa.id]
		pessoa_tem_rede_social = PessoaTemRedeSocial([None, pessoa.id, pessoa.nome, data[0], data[1], ""])
		pessoa_tem_rede_social.id = Util.postData("insPessoaTemRedeSocial", data)[0]
		ptrs.append(pessoa_tem_rede_social)

	return jsonify(pessoa=pessoa.toJSON(), ptf=ptf.toJSON(), telefones=[t.toJSON() for t in telefones], pessoa_tem_rede_sociais=[ptr.toJSON() for ptr in ptrs])

@app.route('/api/insertFuncionario', methods=['POST'])
def insertFuncionario():

	json = request.json
	pessoa = json["pessoa"]

	try:
		data = Util.requestFormArgs("pessoa", pessoa)
		data.pop(0)
		result = Util.postData("insPessoa", data)
	except Exception as e:
		message = e.__str__()
		table = "pessoa"
		json = str(pessoa)
		method = request.method
		data = Util.postData("insLog", [message, json, table, method])
		#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
		return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)		
	
	data.insert(0,None)
	data.insert(2,"")

	pessoa = Pessoa(data)
	pessoa.id = result[0]

	funcao_id = 3
	funcao_nome = "funcionario"

	try:
		data = [pessoa.id, pessoa.nome, pessoa.email, pessoa.registro, funcao_id, funcao_nome, json["password"], None, None]
		ptf = PessoaTemFuncao([None] + data)
		ptf.id = Util.postData("insPessoaTemFuncao", [data[0],data[4], data[6], None])[0]
	except Exception as e:
		result = Util.postData("delPessoa", [pessoa.id])
		message = e.__str__()
		table = "pessoa_tem_funcao"
		json = str(request.json)
		method = request.method
		data = Util.postData("insLog", [message, json, table, method])
		#return jsonify(success=False, result={}, codigo=code,message=error_message.decode('cp1251').encode('utf8'))
		return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)

	telefones = []
	for telefone in json["telefones"]:
		data = [telefone["numero"], telefone["codigo_area"], telefone["codigo_pais"], pessoa.id]
		tel = Telefone([None, data[2], data[1], data[0], data[3]])
		tel.id = Util.postData("insTelefone", data)[0]
		telefones.append(tel)

	ptps = []
	for permissao in json["permissoes"]:
		data = [ptf.id,permissao["id"]]
		pessoa_tem_permissao = PessoaTemPermissao([None, ptf.id, pessoa.id, pessoa.nome, data[1], ""])
		pessoa_tem_permissao.id = Util.postData("insPessoaTemPermissao", data)[0]
		ptps.append(pessoa_tem_permissao)

	return jsonify(pessoa=pessoa.toJSON(), ptf=ptf.toJSON(), telefones=[t.toJSON() for t in telefones], pessoa_tem_permissoes=[ptp.toJSON() for ptp in ptps])