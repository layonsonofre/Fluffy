#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request, Response, jsonify

from angular_flask import app
import hashlib

# routing for API endpoints, generated from the models designated as API_MODELS
from util import *
from angular_flask.core import mysql
from angular_flask.models import *

@app.route('/api/insertServicoAgendado', methods=['POST'])
def insertServicoAgendado() :
	json = request.json

	print(json)

	try:

		message = "Campos obrigatórios: "
		chave = 0

		if "pessoa_tem_funcao_funcionario_id" not in json:
			message = message + (("Funcionário") if chave == 0 else (", Funcionário"))
			chave = 1
		if "servicos_agendados" not in json:
			message = message + (("Serviços") if chave == 0 else (", Serviços"))
			chave = 1

		if chave == 1:
			raise Exception(message)

		transacao_id = 0
		valor = 0

		if "transacao_id" in json:
			transacao_id = json["transacao_id"]
		else:
			try:
				data = Util.postData("insTransacao", ["C", 0, None])
				transacao_id = data[0]
			except Exception as e:
				message = ""
				try: message = e.args[1]
				except Exception as e: raise Exception("Falha ao realizar operação!")
				table = "transacao"
				json = str(request.json)
				method = request.method
				data = Util.postData("insLog", [message, json, table, method])
				raise Exception("Falha ao realizar operação: " + message)

		transacao = Transacao(Util.getData("getTransacao", [transacao_id, None, None, None])[0])

		if "valor" in json:
			valor = json["valor"]

		try:
			data = Util.postData("insServicoContratado", [json["pessoa_tem_funcao_funcionario_id"], valor, transacao_id])
			servico_contratado_id = data[0]
			servicosAgendados = json["servicos_agendados"]
		except Exception as e:
			data = Util.postData("delTransacao", [transacao_id])
			try: message = e.args[1]
			except Exception as e: raise Exception("Falha ao realizar operação!")
			table = "servico_contratado"
			json = str(request.json)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			raise Exception("Falha ao realizar operação: " + message)

		sc = ServicoContratado(Util.getData("getServicoContratado", [servico_contratado_id, None, None, None])[0])

		servico_stored = 0
		servicos = []
		servico_erros = []
		servico_erros_mensagens = []
		for servicoAgendado in servicosAgendados:
			
			try:

				observacao = None
				data_hora_executado =  None
				pessoa_tem_funcao_funcionario_executa_id =  None
				preco = 0
				recorrente = False
				data_hora = None
				servico_id = None
				animal_id = None
				executado = False
				pago = False
				cancelado = False				

				message = "Campos obrigatórios: "
				chave = 0

				if "preco" not in servicoAgendado:
					message = message + ( "Preço" if chave == 0 else ", Preço")
					chave = 1
				if "recorrente" not in servicoAgendado:
					message = message + ( "Recorrente" if chave == 0 else ", Recorrente")
					chave = 1
				if "data_hora" not in servicoAgendado:
					message = message + ( "Data e Hora" if chave == 0 else ", Data e Hora")
					chave = 1
				if "servico_id" not in servicoAgendado:
					message = message + ( "Servico" if chave == 0 else ", Servico")
					chave = 1
				if "animal_id" not in servicoAgendado:
					message = message + ( "Animal" if chave == 0 else ", Animal")
					chave = 1
				#if "executado" not in servicoAgendado:
				#	message = message + ( "Executado" if chave == 0 else ", Executado")
				#	chave = 1
				#if "pago" not in servicoAgendado:
				#	message = message + ( "Pago" if chave == 0 else ", Pago")
				#	chave = 1
				#if "cancelado" not in servicoAgendado:
				#	message = message + ( "Cancelado" if chave == 0 else ", Cancelado")
				#	chave = 1

				if chave == 1:
					raise Exception(message)

				observacao = servicoAgendado["observacao"] if ("observacao" in servicoAgendado) else None
				data_hora_executado = servicoAgendado["data_hora_executado"] if ("data_hora_executado" in servicoAgendado) else None
				pessoa_tem_funcao_funcionario_executa_id = servicoAgendado["pessoa_tem_funcao_funcionario_executa_id"] if("pessoa_tem_funcao_funcionario_executa_id" in servicoAgendado) else None
				preco = servicoAgendado["preco"] if ("preco" in servicoAgendado) else 0
				recorrente = servicoAgendado["recorrente"] if ("recorrente" in servicoAgendado) else False
				data_hora = servicoAgendado["data_hora"] if ("data_hora" in servicoAgendado) else None
				servico_id = servicoAgendado["servico_id"] if ("servico_id" in servicoAgendado) else None
				animal_id = servicoAgendado["animal_id"] if ("animal_id" in servicoAgendado) else None
				executado = servicoAgendado["executado"] if ("executado" in servicoAgendado) else False
				pago = servicoAgendado["pago"] if ("pago" in servicoAgendado) else False
				cancelado = servicoAgendado["cancelado"] if "cancelado" in servicoAgendado  else False
			
				args = [
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
				]

				sa = ServicoAgendado([
					None, 
					data_hora, 
					None, 0, servico_id, None, None, None, 
					animal_id, None, 
					servico_contratado_id, 
					recorrente, 
					executado, 
					pago,
					observacao,
					data_hora_executado,
					pessoa_tem_funcao_funcionario_executa_id, None, None,
					preco,
					cancelado
				])

				sa.id = Util.postData("insServicoAgendado", args)[0]
				servicos.append(sa)
				servico_stored = servico_stored + 1
			except Exception as e:
				message = e.args
				try: message = e.args[1]
				except Exception as e: message = " ".join(message)
				table = "servico_agendado"
				json = str(servicoAgendado)
				method = request.method
				data = Util.postData("insLog", [message, json, table, method])
				sa = ServicoAgendado([
					None, 
					data_hora, 
					None, 0, servico_id, None, None, None, 
					animal_id, None, 
					servico_contratado_id, 
					recorrente, 
					executado, 
					pago,
					observacao,
					data_hora_executado,
					pessoa_tem_funcao_funcionario_executa_id, None, None,
					preco,
					cancelado
				])
				servico_erros.append(sa)
				servico_erros_mensagens.append(message)

		if servico_stored == 0:
			data = Util.postData("delServicoContratado", [servico_contratado_id])
			data = Util.postData("delTransacao", [transacao_id])
			return jsonify(result={}, success=False, message="Falha ao realizar operação: " + ",".join(servico_erros_mensagens), servicos_agendados_erros={"servicos_agendados":[s.toJSON() for s in servico_erros], "messages":servico_erros_mensagens})

		return jsonify(result={}, success=True, message="Serviços Agendados com Sucesso!", transacao=transacao.toJSON(), servico_contratado=sc.toJSON(), servicos_agendados=[s.toJSON() for s in servicos], servicos_agendados_erros={"servicos_agendados":[s.toJSON() for s in servico_erros], "messages":servico_erros_mensagens})
	except Exception as e:
		return jsonify(result={}, success=False, message=" ".join(e.args))

@app.route('/api/insertPedido', methods=['POST'])
def insertPedido() :

	json = request.json

	try:

		message = "Campos obrigatórios: "
		chave = 0

		if "pessoa_tem_funcao_cliente_id" not in json:
			message = message + ( "Cliente" if chave == 0 else ", Cliente")
			chave = 1
		if "pessoa_tem_funcao_funcionario_id" not in json:
			message = message + ( "Funcionário" if chave == 0 else ", Funcionário")
			chave = 1
		if "itens_de_venda" not in json:
			message = message + ( "Itens de Venda" if chave == 0 else ", Itens de Venda")
			chave = 1

		if chave == 1:
			raise Exception(message)

		transacao_id = 0
		valor = 0
		desconto = 0
		pago = 0;


		if "transacao_id" in json:
			transacao_id = json["transacao_id"]
		else:
			try:
				data = Util.postData("insTransacao", ["C", 0, None])
				transacao_id = data[0]
			except Exception as e:
				message = ""
				try: message = e.args[1]
				except Exception as e: raise Exception("Falha ao realizar operação!")
				table = "transacao"
				json = str(request.json)
				method = request.method
				data = Util.postData("insLog", [message, json, table, method])
				raise Exception("Falha ao realizar operação: " + message)

		transacao = Transacao(Util.getData("getTransacao", [transacao_id, None, None, None])[0])

		if "valor" in json:
			valor = json["valor"]

		if "desconto" in json:
			desconto = json["desconto"]

		if "pago" in json:
			pago = json["pago"]

		try:
			data = Util.postData("insPedido", [valor, desconto, transacao_id, json["pessoa_tem_funcao_cliente_id"], json["pessoa_tem_funcao_funcionario_id"],pago])
			pedido_id = data[0]
			itensDeVenda = json["itens_de_venda"]
		except Exception as e:
			data = Util.postData("delTransacao", [transacao_id])
			message = ""
			try: message = e.args[1]
			except Exception as e: raise Exception("Falha ao realizar operação!")
			table = "pedido"
			json = str(request.json)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			raise Exception("Falha ao realizar operação: " + message)

		pedido = Pedido(Util.getData("getPedido", [pedido_id, None, None, None, None, None])[0])

		item_stored = 0
		idvs=[]
		idv_erro=[]
		idv_erro_message=[]
		for itemDeVenda in itensDeVenda:
			
			preco = 0
			quantidade = None
			item_id = None

			try:

				message = "Campos obrigatórios: "
				chave = 0

				if "preco" not in itemDeVenda:
					message = message + ( "Preço" if chave == 0 else ", Preço")
					chave = 1
				if "quantidade" not in itemDeVenda:
					message = message + ( "Quantidade" if chave == 0 else ", Quantidade")
					chave = 1
				if "item_id" not in itemDeVenda:
					message = message + ( "Item" if chave == 0 else ", Item")
					chave = 1

				if chave == 1:
					raise Exception(message)

				preco = itemDeVenda["preco"]
				quantidade = itemDeVenda["quantidade"]
				item_id = itemDeVenda["item_id"]

				item_de_venda = ItemDeVenda([None, preco, quantidade, item_id, None])
				item_de_venda.id = Util.postData("insItemDeVenda", [preco, quantidade, item_id, pedido_id])[0]
				idvs.append(item_de_venda)
				item_stored = item_stored + 1
			except Exception as e:
				message = e.args
				try: message = e.args[1]
				except Exception as e: message = " ".join(message)
				table = "item_de_venda"
				json = str(itemDeVenda)
				method = request.method
				data = Util.postData("insLog", [message, json, table, method])
				idv_erro.append(ItemDeVenda([None, preco, quantidade, item_id, None]))
				idv_erro_message.append(message)

		if item_stored == 0:
			data = Util.postData("delPedido", [pedido_id])
			data = Util.postData("delTransacao", [transacao_id])
			return jsonify(result={}, success=False, message="Falha ao realizar operação!", itens_de_venda_erro={"itens_de_venda":[idv.toJSON() for idv in idv_erro], "messages": idv_erro_message})

		return jsonify(result={}, success=True, message="Venda realizada Com Sucesso!", transacao=transacao.toJSON(), pedido=pedido.toJSON(), itens_de_venda=[idv.toJSON() for idv in idvs], itens_de_venda_erro={"itens_de_venda":[idv.toJSON() for idv in idv_erro], "messages": idv_erro_message})
	except Exception as e:
		return jsonify(result={}, success=False, message=" ".join(e.args))


@app.route('/api/insertCliente', methods=['POST'])
def insertCliente():

	json = request.json
	
	try:

		ptrs = []
		ptrs_erro = []
		ptrs_erro_message = []
		telefones = []
		tel_erro = []
		tel_erro_message = []
		pessoa = None
		ptf = None

		message = "Campos obrigatórios: "
		chave = 0

		if "pessoa" not in json:
			message = message + ("Cliente" if chave == 0 else ", Cliente")
			chave = 1

		if chave == 1:
			raise Exception(message)

		pessoa = json["pessoa"]

		try:
			data = Util.requestFormArgs("pessoa", pessoa)
			data.pop(0)
			result = Util.postData("insPessoa", data)
		except Exception as e:
			message = ""
			try: message = e.args[1]
			except Exception as e: raise Exception("Falha ao realizar operação!")
			table = "pessoa"
			json = str(pessoa)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			raise Exception("Falha ao realizar operação: " + message)

		data.insert(0,None)
		data.insert(2,"")

		pessoa = Pessoa(data)
		pessoa.id = result[0]

		funcao_id = 1
		funcao_nome = "cliente"

		if "clienteEspecial" in json and json["clienteEspecial"] is True:
			funcao_id = 2
			funcao_nome = "clienteEspecial"

		try:
			data = [pessoa.id, pessoa.nome, pessoa.email, pessoa.registro, funcao_id, funcao_nome, None, None, None]
			ptf = PessoaTemFuncao([None] + data)
			ptf.id = Util.postData("insPessoaTemFuncao", [data[0],data[4], None, None])[0]
		except Exception as e:
			result = Util.postData("delPessoa", [pessoa.id])
			message = ""
			try: message = e.args[1]
			except Exception as e: raise Exception("Falha ao realizar operação!")
			table = "pessoa_tem_funcao"
			json = str(request.json)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			raise Exception("Falha ao realizar operação: " + message)

		if "telefones" in json:
			for telefone in json["telefones"]:
				try:
					data = [telefone["numero"], telefone["codigo_area"], telefone["codigo_pais"], pessoa.id]
					tel = Telefone([None, data[2], data[1], data[0], data[3]])
					tel.id = Util.postData("insTelefone", data)[0]
					telefones.append(tel)
				except Exception as e:
					message = e.args
					try: message = e.args[1]
					except Exception as e: message = " ".join(message)
					tel_erro.append(tel)
					tel_erro_message.append(message)

		if "redesSociais" in json:
			for ptr in json["redesSociais"]:
				try:
					data = [ptr["perfil"], ptr["rede_social_id"], pessoa.id]
					pessoa_tem_rede_social = PessoaTemRedeSocial([None, pessoa.id, pessoa.nome, data[0], data[1], ""])
					pessoa_tem_rede_social.id = Util.postData("insPessoaTemRedeSocial", data)[0]
					ptrs.append(pessoa_tem_rede_social)
				except Exception as e:
					message = e.args
					try: message = e.args[1]
					except Exception as e: message = " ".join(message)
					ptrs_erro.append(pessoa_tem_rede_social)
					ptrs_erro_message.append(message)

		return jsonify(result={}, success=True, message="Cadastro de Cliente realizado com Sucesso!" ,pessoa=pessoa.toJSON(), ptf=ptf.toJSON(), telefones=[t.toJSON() for t in telefones], telefones_erros={"telefones":[t.toJSON() for t in tel_erro],"messages":tel_erro_message}, pessoa_tem_rede_sociais=[ptr.toJSON() for ptr in ptrs], pessoa_tem_rede_sociais_erros={"pessoa_tem_rede_sociais":[ptr.toJSON() for ptr in ptrs_erro], "messages": ptrs_erro_message})
	except Exception as e:
		
		for telefone in telefones:
			data = Util.postData("delTelefone", [telefone.id])
		for ptr in ptrs:
			data = Util.postData("delPessoaTemRedeSocial", [ptr.id])
		data = Util.postData("delPessoaTemFuncao", [ptf.id]) if ptf is not None else None
		data = Util.postData("delPessoa", [pessoa.id]) if hasattr(pessoa, 'id') else None
		return jsonify(result={}, success=False, message=" ".join(e.args))


@app.route('/api/insertFuncionario', methods=['POST'])
def insertFuncionario():

	json = request.json

	telefones = []
	tel_erro = []
	tel_erro_message = []
	ptps = []
	ptps_erro = []
	ptps_erro_message = []
	pessoa = None
	ptf = None

	try:

		message = "Campos obrigatórios: "
		chave = 0

		if "pessoa" not in json:
			message = message + ("Funcionário" if chave == 0 else ", Funcionário")
			chave = 1
		if "password" not in json:
			message = message + ("Senha" if chave == 0 else ", Senha")
			chave = 1
		if "permissoes" not in json:
			message = message + ("Permissões" if chave == 0 else ", Permissões")
			chave = 1

		if chave == 1:
			raise Exception(message)

		pessoa = json["pessoa"]

		try:
			data = Util.requestFormArgs("pessoa", pessoa)
			data.pop(0)
			result = Util.postData("insPessoa", data)
		except Exception as e:
			message = ""
			try: message = e.args[1]
			except Exception as e: raise Exception("Falha ao realizar operação!")
			table = "pessoa"
			json = str(pessoa)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			raise Exception("Falha ao realizar operação: " + message)

		data.insert(0,None)
		data.insert(2,"")

		pessoa = Pessoa(data)
		pessoa.id = result[0]

		funcao_id = 3
		funcao_nome = "funcionario"

		m = hashlib.md5()
		m.update(json["password"])

		try:
			data = [pessoa.id, pessoa.nome, pessoa.email, pessoa.registro, funcao_id, funcao_nome, m.hexdigest(), None, None]
			ptf = PessoaTemFuncao([None] + data)
			ptf.id = Util.postData("insPessoaTemFuncao", [data[0],data[4], data[6], None])[0]
		except Exception as e:
			result = Util.postData("delPessoa", [pessoa.id])
			message = ""
			try: message = e.args[1]
			except Exception as e: raise Exception("Falha ao realizar operação!")
			table = "pessoa_tem_funcao"
			json = str(request.json)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			raise Exception("Falha ao realizar operação: " + message)

		if "telefones" in json:
			for telefone in json["telefones"]:
				try:
					data = [telefone["numero"], telefone["codigo_area"], telefone["codigo_pais"], pessoa.id]
					tel = Telefone([None, data[2], data[1], data[0], data[3]])
					tel.id = Util.postData("insTelefone", data)[0]
					telefones.append(tel)
				except Exception as e:
					message = e.args
					try: message = e.args[1]
					except Exception as e: message = " ".join(message)
					tel_erro.append(tel)
					tel_erro_message.append(message)

		for permissao in json["permissoes"]:
			try:
				data = [ptf.id,permissao["id"]]
				pessoa_tem_permissao = PessoaTemPermissao([None, ptf.id, pessoa.id, pessoa.nome, data[1], ""])
				pessoa_tem_permissao.id = Util.postData("insPessoaTemPermissao", data)[0]
				ptps.append(pessoa_tem_permissao)
			except Exception as e:
				message = e.args
				try: message = e.args[1]
				except Exception as e: message = " ".join(message)
				ptps_erro.append(pessoa_tem_permissao)
				ptps_erro_message.append(message)

		return jsonify(result={}, success=True, message="Cadastro de Funcionário realizado com Sucesso!",pessoa=pessoa.toJSON(), ptf=ptf.toJSON(), telefones=[t.toJSON() for t in telefones], telefones_erros={"telefones":[t.toJSON() for t in tel_erro],"messages":tel_erro_message}, pessoa_tem_permissoes=[ptp.toJSON() for ptp in ptps], pessoa_tem_permissoes_erro={"pessoa_tem_permissoes":[ptp.toJSON() for ptp in ptps_erro], "messages": ptps_erro_message})
	except Exception as e:
		return jsonify(result={}, success=False, message=" ".join(e.args))

@app.route('/api/insertAdministrador', methods=['POST'])
def insertAdministrador():

	json = request.json

	telefones = []
	tel_erro = []
	tel_erro_message = []
	ptps = []
	ptps_erro = []
	ptps_erro_message = []
	pessoa = None
	ptf = None

	try:

		message = "Campos obrigatórios: "
		chave = 0

		if "pessoa" not in json:
			message = message + ("Funcionário" if chave == 0 else ", Funcionário")
			chave = 1
		if "password" not in json:
			message = message + ("Senha" if chave == 0 else ", Senha")
			chave = 1

		if chave == 1:
			raise Exception(message)

		pessoa = json["pessoa"]

		try:
			data = Util.requestFormArgs("pessoa", pessoa)
			data.pop(0)
			result = Util.postData("insPessoa", data)
		except Exception as e:
			message = ""
			try: message = e.args[1]
			except Exception as e: raise Exception("Falha ao realizar operação!")
			table = "pessoa"
			json = str(pessoa)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			raise Exception("Falha ao realizar operação: " + message)

		data.insert(0,None)
		data.insert(2,"")

		pessoa = Pessoa(data)
		pessoa.id = result[0]

		funcao_id = 4
		funcao_nome = "administrador"

		m = hashlib.md5()
		m.update(json["password"])

		try:
			data = [pessoa.id, pessoa.nome, pessoa.email, pessoa.registro, funcao_id, funcao_nome, m.hexdigest(), None, None]
			ptf = PessoaTemFuncao([None] + data)
			ptf.id = Util.postData("insPessoaTemFuncao", [data[0],data[4], data[6], None])[0]
		except Exception as e:
			result = Util.postData("delPessoa", [pessoa.id])
			message = ""
			try: message = e.args[1]
			except Exception as e: raise Exception("Falha ao realizar operação!")
			table = "pessoa_tem_funcao"
			json = str(request.json)
			method = request.method
			data = Util.postData("insLog", [message, json, table, method])
			raise Exception("Falha ao realizar operação: " + message)


		if "telefones" in json:		
			for telefone in json["telefones"]:
				try:
					data = [telefone["numero"], telefone["codigo_area"], telefone["codigo_pais"], pessoa.id]
					tel = Telefone([None, data[2], data[1], data[0], data[3]])
					tel.id = Util.postData("insTelefone", data)[0]
					telefones.append(tel)
				except Exception as e:
					message = e.args
					try: message = e.args[1]
					except Exception as e: message = " ".join(message)
					tel_erro.append(tel)
					tel_erro_message.append(message)

		data = Util.getData("getPermissao", [None, None])
		for info in data:
			try:
				permissao = Permissao(info)
				pessoa_tem_permissao = PessoaTemPermissao([None, ptf.id, pessoa.id, pessoa.nome, permissao.id, permissao.modulo])
				pessoa_tem_permissao.id = Util.postData("insPessoaTemPermissao", [ptf.id, permissao.id])[0]
				ptps.append(pessoa_tem_permissao)
			except Exception as e:
				message = e.args
				try: message = e.args[1]
				except Exception as e: message = " ".join(message)
				ptps_erro.append(pessoa_tem_permissao)
				ptps_erro_message.append(message)

		return jsonify(result={}, success=True, message="Cadastro de Administrador realizado com Sucesso!", pessoa=pessoa.toJSON(), ptf=ptf.toJSON(), telefones=[t.toJSON() for t in telefones], telefones_erros={"telefones":[t.toJSON() for t in tel_erro],"messages":tel_erro_message}, pessoa_tem_permissoes=[ptp.toJSON() for ptp in ptps], pessoa_tem_permissoes_erro={"pessoa_tem_permissoes":[ptp.toJSON() for ptp in ptps_erro], "messages": ptps_erro_message})
	except Exception as e:
		return jsonify(result={}, success=False, message=" ".join(e.args))

